import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../url/api_service.dart'; // your const baseUrl

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    setState(() => isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      String? userIdentifier = prefs.getString('user_identifier');

      if (userIdentifier == null || userIdentifier.isEmpty) {
        print("⚠️ No user_identifier found in SharedPreferences");
        setState(() => isLoading = false);
        return;
      }

      final dio = Dio();
      final url =
          "$baseUrl/get_user_profile_kanban.php?user_identifier=$userIdentifier";

      print("📡 Fetching user profile from: $url");

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data =
            response.data is String ? jsonDecode(response.data) : response.data;

        if (data["error"] == null) {
          setState(() {
            userData = data;
            isLoading = false;
          });
        } else {
          print("⚠️ ${data["error"]}");
          setState(() => isLoading = false);
        }
      } else {
        print("⚠️ HTTP error ${response.statusCode}");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("❌ Error fetching user details: $e");
      setState(() => isLoading = false);
    }
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
            onPressed: () {
              // ✅ Action when edit icon is tapped
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Edit feature coming soon!")),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
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
