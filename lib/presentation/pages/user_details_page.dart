import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../url/api_service.dart'; // contains baseUrl string

class Project {
  final String name;
  final List<String> attachedFiles;

  Project({required this.name, required this.attachedFiles});

  factory Project.fromJson(Map<String, dynamic> json) {
    List<String> files = [];
    if (json['attached_file'] != null) {
      try {
        files = List<String>.from(jsonDecode(json['attached_file']));
      } catch (e) {
// in case attached_file is not JSON
        files = [json['attached_file'].toString()];
      }
    }
    return Project(
      name: json['project_name'] ?? '',
      attachedFiles: files,
    );
  }
}

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String projectName = '';
  String userName = '';
  String email = '';
  String contact = '';
  String address = '';
  String imageUrl = '';
  String? deviceUserId;

  List<Project> projects = [];

  @override
  void initState() {
    super.initState();
    _saveAndSetUserData();
  }

  Future<void> _saveAndSetUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_user_id');

    if (deviceId == null || deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_user_id', deviceId);
    }
    deviceUserId = deviceId;

    try {
      final response = await Dio().get(
        '$baseUrl/get_user_profile_kanban.php',
        queryParameters: {'device_user_id': deviceId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final dataList = data is List ? data : [data];

        if (dataList.isNotEmpty) {
          await prefs.setString('user_data', jsonEncode(dataList));

          setState(() {
            userName = dataList[0]['project_owner_name'] ?? '';
            email = dataList[0]['email_address'] ?? '';
            contact = dataList[0]['contact_number'] ?? '';
            address = dataList[0]['permanent_address'] ?? '';
            projectName = dataList[0]['project_name'] ?? '';
            imageUrl = (dataList[0]['owner_image'] != null &&
                    dataList[0]['owner_image'].toString().isNotEmpty)
                ? 'http://10.0.2.2/API/uploads/${dataList[0]['owner_image']}'
                : '';

            projects = dataList.map((e) => Project.fromJson(e)).toList();
          });
        }
      } else {
        print('⚠️ No data found for this device_user_id.');
      }
    } catch (e) {
      print('❌ Error fetching user data: $e');
    }
  }

  void _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    const oceanColor = Color.fromARGB(255, 158, 223, 180);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      appBar: AppBar(
        title: const Text(
          'User Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: oceanColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit,
                color: Color.fromARGB(255, 93, 87, 87), size: 26),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Edit Profile Coming Soon...",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // ----------------- Profile Image -----------------
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: oceanColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 75,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person,
                                size: 75, color: Colors.grey);
                          },
                        )
                      : const Icon(Icons.person, size: 75, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'No Name Found',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              email.isNotEmpty ? email : 'No Email Found',
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
            const SizedBox(height: 25),
            // ----------------- Profile Details Card -----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: oceanColor.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Details",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: oceanColor),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  // ----------------- Project Name as Chips -----------------
                  _infoRowWidget(
                    Icons.perm_identity,
                    "Project Name",
                    projects.isNotEmpty
                        ? Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: projects
                                .map((p) => Chip(
                                      label: Text(
                                        p.name,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      backgroundColor: Colors.green.shade100,
                                    ))
                                .toList(),
                          )
                        : const Text('Unknown', style: TextStyle(fontSize: 10)),
                  ),
                  const SizedBox(height: 15),
                  _infoRow(Icons.phone, "Contact",
                      contact.isNotEmpty ? contact : 'No Contact Found'),
                  const SizedBox(height: 15),
                  _infoRow(Icons.home, "Address",
                      address.isNotEmpty ? address : 'No Address Found'),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // ----------------- Multiple Projects with attachments -----------------
            if (projects.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("All Projects",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: oceanColor.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 6)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(project.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12)),
                            const SizedBox(height: 5),
                            if (project.attachedFiles.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: project.attachedFiles.map((file) {
                                  final fileUrl =
                                      'http://10.0.2.2/API/uploads/$file';
                                  return GestureDetector(
                                    onTap: () => _openUrl(fileUrl),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.attach_file,
                                            size: 14, color: Colors.blue),
                                        const SizedBox(width: 5),
                                        Text(file,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline)),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

// Info row with Widget instead of String for value
  Widget _infoRowWidget(IconData icon, String label, Widget value) {
    const oceanColor = Color.fromARGB(255, 158, 223, 180);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: oceanColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                value,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    const oceanColor = Color.fromARGB(255, 158, 223, 180);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: oceanColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                Text(value,
                    style:
                        const TextStyle(fontSize: 10, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
