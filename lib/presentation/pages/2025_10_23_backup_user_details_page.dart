import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../url/api_service.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isLoading = true;
  Map<String, dynamic>? userData;
  String? deviceUserId;
  String? userId;

  @override
  void initState() {
    super.initState();
    _initAndSync(); // start the whole flow
  }

  // ---------- Init & sync ----------
  Future<void> _initAndSync() async {
    deviceUserId = await _getOrCreateDeviceId();
    await _loadCachedData();
    await _ensureProfileExistsAndFetch(deviceUserId!);
  }

  // ---------- Device ID ----------
  // replaced method
  Future<String> _getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    // return cached id if present
    String? id = prefs.getString('device_user_id');
    if (id != null && id.isNotEmpty) return id;

    // try platform-specific IDs (in a robust way)
    try {
      if (!kIsWeb) {
        final deviceInfo = DeviceInfoPlugin();

        if (Platform.isAndroid) {
          // use dynamic to avoid depending on a specific device_info_plus API surface
          final info = await deviceInfo.androidInfo;
          final dyn = info as dynamic;
          try {
            id = dyn.id as String?; // common on some versions
          } catch (_) {}
          try {
            id ??= dyn.androidId as String?; // other versions
          } catch (_) {}
          // also try some alternate property names if present
          try {
            id ??= dyn.android_id as String?;
          } catch (_) {}
        } else if (Platform.isIOS) {
          final info = await deviceInfo.iosInfo;
          final dyn = info as dynamic;
          try {
            id = dyn.identifierForVendor as String?;
          } catch (_) {}
        }
      }
    } catch (e) {
      // ignore and fallback to UUID
      debugPrint('Device info read error: $e');
    }

    // final fallback to a generated UUID
    id ??= const Uuid().v4();

    // store and return
    await prefs.setString('device_user_id', id);
    debugPrint("✅ device_user_id: $id");
    return id;
  }

  // ---------- Load cached data ----------
  Future<void> _loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('user_data');
    if (cached != null && cached.isNotEmpty) {
      try {
        final map = jsonDecode(cached);
        if (mounted) setState(() => userData = Map<String, dynamic>.from(map));
        debugPrint("📦 Loaded cached user data");
      } catch (_) {
        // ignore parse errors
      }
    }
    // also load saved user_id if present
    userId = prefs.getString('user_id');
  }

  // ---------- Ensure profile exists and fetch ----------

  Future<void> _ensureProfileExistsAndFetch(String deviceId) async {
    setState(() => isLoading = true);
    try {
      final resp = await _fetchProfileFromServer(deviceId);

      if (resp == null || resp['success'] == false) {
        debugPrint("! No profile found. Creating new one...");
        final created =
            await _createProfileOnServer(deviceId); // must return server body
        if (created != null && created['success'] == true) {
          // save returned user_id if present
          if (created['user_id'] != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_id', created['user_id'].toString());
          }
          // fetch again
          final resp2 = await _fetchProfileFromServer(deviceId);
          if (resp2 != null && resp2['success'] == true) {
            await _saveAndSetUserData(resp2);
          }
        }
      } else {
        // success -> save and show
        await _saveAndSetUserData(resp);
      }
    } catch (e) {
      debugPrint("❌ _ensureProfileExistsAndFetch error: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // Future<void> _ensureProfileExistsAndFetch(String deviceId) async {
  //   setState(() => isLoading = true);
  //   try {
  //     // 1) Try fetch
  //     final profileResp = await _fetchProfileFromServer(deviceId);

  //     if (profileResp == null ||
  //         (profileResp is Map && profileResp['success'] == false)) {
  //       debugPrint("! No profile found. Creating new one...");
  //       // 2) Create profile
  //       final createResp = await _createProfileOnServer(deviceId);
  //       if (createResp != null && createResp['success'] == true) {
  //         // store returned user_id if provided
  //         if (createResp['user_id'] != null) {
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setString('user_id', createResp['user_id'].toString());
  //           userId = createResp['user_id'].toString();
  //         }
  //         // 3) Fetch again after creation
  //         final profile2 = await _fetchProfileFromServer(deviceId);
  //         if (profile2 != null && profile2['success'] != false) {
  //           await _saveAndSetUserData(profile2);
  //         } else {
  //           debugPrint(
  //               "⚠️ Profile created but fetch failed or returned empty.");
  //         }
  //       } else {
  //         debugPrint("⚠️ Failed to create profile on server.");
  //       }
  //     } else {
  //       // success: save and show profile
  //       await _saveAndSetUserData(profileResp);
  //     }
  //   } catch (e, st) {
  //     debugPrint("❌ _ensureProfileExistsAndFetch error: $e\n$st");
  //   } finally {
  //     if (mounted) setState(() => isLoading = false);
  //   }
  // }

  // ---------- Fetch profile from server ----------

  Future<Map<String, dynamic>?> _fetchProfileFromServer(String deviceId) async {
    try {
      final dio = Dio();
      final uri = Uri.parse(baseUrl)
          .resolve('/API/get_user_profile_kanban.php')
          .replace(queryParameters: {'device_user_id': deviceId});
      debugPrint("📡 Fetching profile: $uri");
      final resp = await dio.get(uri.toString());
      if (resp.statusCode == 200) {
        final body = resp.data is String ? jsonDecode(resp.data) : resp.data;
        if (body is Map<String, dynamic>) return body;
      }
    } catch (e) {
      debugPrint("❌ _fetchProfileFromServer error: $e");
    }
    return null;
  }

  // returns the raw server response Map or null

  // Future<Map<String, dynamic>?> _fetchProfileFromServer(String deviceId) async {
  //   try {
  //     final dio = Dio();
  //     final uri = Uri.parse(baseUrl)
  //         .resolve('/API/get_user_profile_kanban.php')
  //         .replace(queryParameters: {'device_user_id': deviceId});
  //     debugPrint("📡 Fetching profile: $uri");
  //     final resp = await dio.get(uri.toString());
  //     if (resp.statusCode == 200) {
  //       final json = resp.data is String ? jsonDecode(resp.data) : resp.data;
  //       if (json is Map<String, dynamic>) return json;
  //     }
  //   } catch (e) {
  //     debugPrint("❌ _fetchProfileFromServer error: $e");
  //   }
  //   return null;
  // }

  // Future<Map<String, dynamic>?> _fetchProfileFromServer(String deviceId) async {
  //   try {
  //     final dio = Dio();
  //     final uri = Uri.parse(baseUrl)
  //         .resolve('/API/get_user_profile_kanban.php')
  //         .replace(queryParameters: {'device_user_id': deviceId});
  //     debugPrint("📡 Fetching profile: $uri");
  //     final resp = await dio.get(uri.toString());
  //     if (resp.statusCode == 200) {
  //       final data = resp.data is String ? jsonDecode(resp.data) : resp.data;
  //       // server may return { success:true, data: {...} } or raw row {...}
  //       if (data is Map && data.containsKey('success')) {
  //         return Map<String, dynamic>.from(data);
  //       } else if (data is Map && data.containsKey('id')) {
  //         // raw row returned; wrap with success flag
  //         return {'success': true, 'data': data};
  //       } else {
  //         return Map<String, dynamic>.from(data);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("❌ _fetchProfileFromServer error: $e");
  //   }
  //   return null;
  // }

  // ---------- Create profile on server ----------
  // returns server response Map or null
  Future<Map<String, dynamic>?> _createProfileOnServer(String deviceId) async {
    try {
      final dio = Dio();
      final uri = Uri.parse(baseUrl).resolve('/API/create_user_profile.php');
      final data = {
        'device_user_id': deviceId,
        'project_owner_name': 'New User',
        'project_name': 'My Project',
        'contact_number': '',
        'email_address': '',
        'permanent_address': '',
        'created_by': 'App'
      };
      debugPrint("📡 Creating profile: $uri  data: $data");
      final resp = await dio.post(uri.toString(), data: data);
      if (resp.statusCode == 200) {
        final body = resp.data is String ? jsonDecode(resp.data) : resp.data;
        debugPrint("✅ create_user_profile response: $body");
        return body is Map ? Map<String, dynamic>.from(body) : null;
      }
    } catch (e) {
      debugPrint("❌ _createProfileOnServer error: $e");
    }
    return null;
  }

  // ---------- Save + set user data in UI & local storage ----------

  Future<void> _saveAndSetUserData(Map<String, dynamic> profileResponse) async {
    final prefs = await SharedPreferences.getInstance();

    // server returns either { success:true, data: {...} } OR raw row {...}
    final Map<String, dynamic> data =
        (profileResponse['data'] != null && profileResponse['data'] is Map)
            ? Map<String, dynamic>.from(profileResponse['data'])
            : Map<String, dynamic>.from(profileResponse);

    // persist raw JSON string (so _loadCachedData can read entire object)
    await prefs.setString('user_data', jsonEncode(data));

    // also persist user_id and device_user_id separately
    if (data['user_id'] != null) {
      await prefs.setString('user_id', data['user_id'].toString());
    }
    if (data['device_user_id'] != null) {
      await prefs.setString(
          'device_user_id', data['device_user_id'].toString());
    }

    // Update UI state from single map
    if (mounted) {
      setState(() {
        userData = Map<String, dynamic>.from(data);
      });
    }

    debugPrint("✅ Saved user data to cache: $data");
  }

  // Accepts either:
  // - server response { success:true, data: {...} }
  // - or raw data map {...}
  // Future<void> _saveAndSetUserData(Map<String, dynamic> profileResponse) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   // extract 'data' if present
  //   final Map<String, dynamic> data =
  //       profileResponse['data'] != null && profileResponse['data'] is Map
  //           ? Map<String, dynamic>.from(profileResponse['data'])
  //           : Map<String, dynamic>.from(profileResponse);

  //   // persist main fields
  //   await prefs.setString('user_data', jsonEncode(data));
  //   if (data['user_id'] != null) {
  //     await prefs.setString('user_id', data['user_id'].toString());
  //     userId = data['user_id'].toString();
  //   }
  //   if (data['device_user_id'] != null) {
  //     await prefs.setString(
  //         'device_user_id', data['device_user_id'].toString());
  //     deviceUserId = data['device_user_id'].toString();
  //   }

  //   // update UI map
  //   if (mounted) {
  //     setState(() {
  //       userData = Map<String, dynamic>.from(data);
  //     });
  //   }
  //   debugPrint("✅ Saved user data to cache: $data");
  // }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: const Color.fromARGB(255, 164, 233, 167),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Edit coming soon"))),
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (userData == null)
              ? const Center(child: Text("No data found for this user"))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor:
                            const Color.fromARGB(255, 166, 225, 168),
                        backgroundImage: (userData!['attached_file'] != null &&
                                userData!['attached_file']
                                    .toString()
                                    .isNotEmpty)
                            ? NetworkImage(
                                "$baseUrl${userData!['attached_file']}")
                            : null,
                        child: (userData!['attached_file'] == null ||
                                userData!['attached_file'].toString().isEmpty)
                            ? const Icon(Icons.person,
                                color: Colors.white, size: 50)
                            : null,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          userData!['project_owner_name'] ?? 'Unknown User',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Text(
                          userData!['project_name'] ?? '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      const Divider(height: 40),
                      _infoTile(Icons.email_outlined, "Email",
                          userData!['email_address']),
                      _infoTile(Icons.phone_outlined, "Phone",
                          userData!['contact_number']),
                      _infoTile(Icons.location_on_outlined, "Address",
                          userData!['permanent_address']),
                      _infoTile(Icons.person_outline, "Created By",
                          userData!['created_by']),
                      _infoTile(Icons.calendar_today_outlined, "Created At",
                          userData!['created_at']),
                    ],
                  ),
                ),
    );
  }

  Widget _infoTile(IconData icon, String title, String? value) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      subtitle: Text(value ?? "N/A"),
    );
  }
}
