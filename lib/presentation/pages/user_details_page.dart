import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../url/api_service.dart'; // contains baseUrl string

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

  @override
  void initState() {
    super.initState();
    _saveAndSetUserData();
  }

  Future<void> _saveAndSetUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('device_user_id');

    // ✅ Generate or get persistent UUID
    if (deviceId == null || deviceId.isEmpty) {
      deviceId = const Uuid().v4();
      await prefs.setString('device_user_id', deviceId);
    }

    deviceUserId = deviceId;
    print('✅ Device ID initialized: $deviceId');

    try {
      final response = await Dio().get(
        '$baseUrl/get_user_profile_kanban.php',
        queryParameters: {'device_user_id': deviceId},
      );

      print('📡 Fetching profile: ${response.realUri}');
      print('📦 Response data: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];

        if (data != null) {
          await prefs.setString('user_data', jsonEncode(data));
          print('✅ Saved user data to cache: $data');

          setState(() {
            userName = data['project_owner_name'] ?? '';
            email = data['email_address'] ?? '';
            contact = data['contact_number'] ?? '';
            address = data['permanent_address'] ?? '';
            projectName = data['project_name'] ?? ''; // <-- Add this line
            imageUrl = (data['owner_image'] != null &&
                    data['owner_image'].toString().isNotEmpty)
                ? 'http://192.168.32.181/API/uploads/${data['owner_image']}'
                : '';
          });
        } else {
          print('⚠️ No data object found in response.');
        }
      } else {
        print('⚠️ Server returned no data for this device_user_id.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No data found for this user.')),
        );
      }
    } catch (e) {
      print('❌ Error fetching user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
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
            fontSize: 14, // ✅ font 10px
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
                    style: TextStyle(fontSize: 10), // ✅ font 10px
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

            // Profile Image with Shadow
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
                            // Show default icon if image fails to load
                            return const Icon(Icons.person,
                                size: 75, color: Colors.grey);
                          },
                        )
                      : const Icon(Icons.person, size: 75, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Only show owner name
            Column(
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'No Name Found',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14, // ✅ font 10px
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // Email
            Text(
              email.isNotEmpty ? email : 'No Email Found',
              style: const TextStyle(
                fontSize: 10, // ✅ font 10px
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 25),

            // Profile Details Card
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
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Details",
                    style: TextStyle(
                      fontSize: 10, // ✅ font 10px
                      fontWeight: FontWeight.bold,
                      color: oceanColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  _infoRow(Icons.perm_identity, "Project Name",
                      projectName.isNotEmpty ? projectName : 'Unknown'),
                  const SizedBox(height: 15),
                  _infoRow(Icons.phone, "Contact",
                      contact.isNotEmpty ? contact : 'No Contact Found'),
                  const SizedBox(height: 15),
                  _infoRow(Icons.home, "Address",
                      address.isNotEmpty ? address : 'No Address Found'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Info row widget
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
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10, // ✅ font 10px
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 10, // ✅ font 10px
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: Colors.indigo, size: 22),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   value,
//                   style: const TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
