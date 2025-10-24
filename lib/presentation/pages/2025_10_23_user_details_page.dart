import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../url/api_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isLoading = true;
  Map<String, dynamic>? userData;
  String? deviceUserId;

  @override
  void initState() {
    super.initState();
    _initAndSync();
  }

  Future<void> _initAndSync() async {
    deviceUserId = await _getOrCreateDeviceId();
    await _loadCachedData();
    await _ensureProfileExistsAndFetch(deviceUserId!);
  }

  Future<String> _getOrCreateDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    // Return cached ID if exists
    String? id = prefs.getString('device_user_id');
    if (id != null && id.isNotEmpty) return id;

    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        // id is safe and available for all Android devices
        id = info.id;
      } else if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        id = info.identifierForVendor;
      }
    } catch (e) {
      print("❌ Device info error: $e");
    }

    // Fallback to UUID if device info not available
    id ??= const Uuid().v4();

    // Save for future use
    await prefs.setString('device_user_id', id);
    print("✅ device_user_id: $id");
    return id;
  }

  Future<void> _loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString('user_data');
    if (cached != null) {
      setState(() => userData = jsonDecode(cached));
      print("📦 Loaded cached user data");
    }
  }

  Future<void> _ensureProfileExistsAndFetch(String deviceId) async {
    setState(() => isLoading = true);
    try {
      final profile = await _fetchProfileFromServer(deviceId);
      if (profile == null || profile['error'] != null) {
        final created = await _createProfileOnServer(deviceId);
        if (created) {
          final profile2 = await _fetchProfileFromServer(deviceId);
          if (profile2 != null && profile2['error'] == null) {
            await _saveAndSetUserData(profile2);
          }
        }
      } else {
        await _saveAndSetUserData(profile);
      }
    } catch (e) {
      print("❌ _ensureProfileExistsAndFetch error: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<Map<String, dynamic>?> _fetchProfileFromServer(String deviceId) async {
    try {
      final dio = Dio();
      final uri = Uri.parse(baseUrl)
          .resolve('/API/get_user_profile_kanban.php')
          .replace(queryParameters: {'device_user_id': deviceId});
      print("📡 Fetching profile: $uri");
      final resp = await dio.get(uri.toString());
      if (resp.statusCode == 200) {
        return resp.data is String ? jsonDecode(resp.data) : resp.data;
      }
    } catch (e) {
      print("❌ _fetchProfileFromServer error: $e");
    }
    return null;
  }

  Future<bool> _createProfileOnServer(String deviceId) async {
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
      print("📡 Creating profile: $uri  data: $data");
      final resp = await dio.post(uri.toString(), data: data);
      if (resp.statusCode == 200) {
        final body = resp.data is String ? jsonDecode(resp.data) : resp.data;
        return (body['success'] == true || body['id'] != null);
      }
    } catch (e) {
      print("❌ _createProfileOnServer error: $e");
    }
    return false;
  }

  Future<void> _saveAndSetUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', jsonEncode(data));
    if (mounted) setState(() => userData = Map<String, dynamic>.from(data));
    print("✅ Saved user data to cache");
  }

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
                  const SnackBar(content: Text("Edit coming soon")))),
        ],
      ),
      body: (userData == null && isLoading)
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


// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';
// import '../../url/api_service.dart'; // must provide baseUrl string
// import 'package:device_info_plus/device_info_plus.dart';
// import 'dart:io';

// class UserDetailsPage extends StatefulWidget {
//   const UserDetailsPage({super.key});

//   @override
//   State<UserDetailsPage> createState() => _UserDetailsPageState();
// }

// class _UserDetailsPageState extends State<UserDetailsPage> {
//   bool isLoading = true;
//   Map<String, dynamic>? userData;
//   String? deviceUserId;

//   @override
//   void initState() {
//     super.initState();
//     _initAndSync();
//   }

//   Future<void> _initAndSync() async {
//     deviceUserId = await _getOrCreateDeviceId();
//     await _loadCachedData();
//     await _ensureProfileExistsAndFetch(deviceUserId!);
//   }

//   // Future<String> _getOrCreateDeviceId() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   String? id = prefs.getString('device_user_id');
//   //   if (id == null || id.isEmpty) {
//   //     id = const Uuid().v4();
//   //     await prefs.setString('device_user_id', id);
//   //     print("🆕 Generated device_user_id: $id");
//   //   } else {
//   //     print("🔑 Loaded saved device_user_id: $id");
//   //   }
//   //   return id;
//   // }


//   Future<String> _getOrCreateDeviceId() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? id = prefs.getString('device_user_id');

//     if (id != null && id.isNotEmpty) {
//       print("🔑 Loaded saved device_user_id: $id");
//       return id;
//     }

//     final deviceInfo = DeviceInfoPlugin();

//     if (Platform.isAndroid) {
//       final info = await deviceInfo.androidInfo;
//       id = info.id; // Unique hardware ID for Android
//     } else if (Platform.isIOS) {
//       final info = await deviceInfo.iosInfo;
//       id = info.identifierForVendor; // Unique vendor ID for iOS
//     }

//     // Save it locally for caching
//     await prefs.setString('device_user_id', id!);
//     print("✅ Permanent device_user_id: $id");

//     return id!;
//   }

//   Future<void> _loadCachedData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cached = prefs.getString('user_data');
//     if (cached != null) {
//       setState(() => userData = jsonDecode(cached));
//       print("📦 Loaded cached user data");
//     }
//   }

//   // Ensure profile exists: fetch; if not exists, create; then fetch again
//   Future<void> _ensureProfileExistsAndFetch(String deviceId) async {
//     setState(() => isLoading = true);

//     try {
//       final profile = await _fetchProfileFromServer(deviceId);
//       if (profile == null || profile['error'] != null) {
//         // create minimal profile on server
//         final created = await _createProfileOnServer(deviceId);
//         if (created) {
//           // fetch again after creation
//           final profile2 = await _fetchProfileFromServer(deviceId);
//           if (profile2 != null && profile2['error'] == null) {
//             await _saveAndSetUserData(profile2);
//           } else {
//             print("⚠️ Profile created but fetching failed or returned error");
//           }
//         } else {
//           print("⚠️ Failed to create profile on server");
//         }
//       } else {
//         // profile exists already
//         await _saveAndSetUserData(profile);
//       }
//     } catch (e) {
//       print("❌ _ensureProfileExistsAndFetch error: $e");
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<Map<String, dynamic>?> _fetchProfileFromServer(String deviceId) async {
//     try {
//       final dio = Dio();
//       final url =
//           "$baseUrl/get_user_profile_kanban.php?device_user_id=$deviceId";
//       print("📡 Fetching profile: $url");
//       final resp = await dio.get(url);
//       if (resp.statusCode == 200) {
//         return resp.data is String ? jsonDecode(resp.data) : resp.data;
//       } else {
//         print("⚠️ HTTP ${resp.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("❌ _fetchProfileFromServer error: $e");
//       return null;
//     }
//   }

//   Future<bool> _createProfileOnServer(String deviceId) async {
//     try {
//       final dio = Dio();
//       final url = "$baseUrl/create_user_profile.php";
//       // Provide minimal sensible defaults; adjust fields as you want.
//       final data = {
//         'device_user_id': deviceId,
//         'project_owner_name': 'New User',
//         'project_name': 'My Project',
//         'contact_number': '',
//         'email_address': '',
//         'permanent_address': '',
//         'created_by': 'App'
//       };
//       print("📡 Creating profile: $url  data: $data");
//       final resp = await dio.post(url, data: data);
//       if (resp.statusCode == 200) {
//         final body = resp.data is String ? jsonDecode(resp.data) : resp.data;
//         return (body['success'] == true || body['id'] != null);
//       } else {
//         return false;
//       }
//     } catch (e) {
//       print("❌ _createProfileOnServer error: $e");
//       return false;
//     }
//   }

//   Future<void> _saveAndSetUserData(Map<String, dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user_data', jsonEncode(data));
//     setState(() => userData = Map<String, dynamic>.from(data));
//     print("✅ Saved user data to cache");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Details"),
//         backgroundColor: const Color.fromARGB(255, 164, 233, 167),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Edit coming soon"))),
//           ),
//         ],
//       ),
//       body: (userData == null && isLoading)
//           ? const Center(child: CircularProgressIndicator())
//           : (userData == null)
//               ? const Center(child: Text("No data found for this user"))
//               : Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: ListView(
//                     children: [
//                       CircleAvatar(
//                         radius: 45,
//                         backgroundColor:
//                             const Color.fromARGB(255, 166, 225, 168),
//                         backgroundImage: (userData!['attached_file'] != null &&
//                                 userData!['attached_file']
//                                     .toString()
//                                     .isNotEmpty)
//                             ? NetworkImage(
//                                 "$baseUrl${userData!['attached_file']}")
//                             : null,
//                         child: (userData!['attached_file'] == null ||
//                                 userData!['attached_file'].toString().isEmpty)
//                             ? const Icon(Icons.person,
//                                 color: Colors.white, size: 50)
//                             : null,
//                       ),
//                       const SizedBox(height: 20),
//                       Center(
//                         child: Text(
//                           userData!['project_owner_name'] ?? 'Unknown User',
//                           style: const TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Center(
//                         child: Text(
//                           userData!['project_name'] ?? '',
//                           style: const TextStyle(
//                               fontSize: 14, color: Colors.black54),
//                         ),
//                       ),
//                       const Divider(height: 40),
//                       _infoTile(Icons.email_outlined, "Email",
//                           userData!['email_address']),
//                       _infoTile(Icons.phone_outlined, "Phone",
//                           userData!['contact_number']),
//                       _infoTile(Icons.location_on_outlined, "Address",
//                           userData!['permanent_address']),
//                       _infoTile(Icons.person_outline, "Created By",
//                           userData!['created_by']),
//                       _infoTile(Icons.calendar_today_outlined, "Created At",
//                           userData!['created_at']),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   Widget _infoTile(IconData icon, String title, String? value) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.green),
//       title: Text(title),
//       subtitle: Text(value ?? "N/A"),
//     );
//   }
// }
