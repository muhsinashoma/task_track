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
            // imageUrl = data['owner_image'] != null &&
            //         data['owner_image'].toString().isNotEmpty
            //     ? '$baseUrl/uploads/${data['owner_image']}'
            //     : '';

            projectName = data['project_name'] ?? ''; // <-- Add this line
            imageUrl = data['owner_image'] != null &&
                    data['owner_image'].toString().isNotEmpty
                ? '$baseUrl/uploads/${data['owner_image']}'
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
                  content: Text("Edit Profile Coming Soon..."),
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
                backgroundImage:
                    imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                child: imageUrl.isEmpty
                    ? const Icon(Icons.person, size: 75, color: Colors.grey)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // // Name & Project
            // Column(
            //   children: [
            //     Text(
            //       userName.isNotEmpty ? userName : 'No Name Found',
            //       textAlign: TextAlign.center,
            //       style: const TextStyle(
            //         fontSize: 26,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black87,
            //       ),
            //     ),
            //     const SizedBox(height: 6),
            //     Text(
            //       projectName.isNotEmpty
            //           ? projectName
            //           : 'No Project Name Found',
            //       style: TextStyle(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w600,
            //         color: oceanColor,
            //       ),
            //     ),
            //   ],
            // ),

            // Only show owner name
            Column(
              children: [
                Text(
                  userName.isNotEmpty ? userName : 'No Name Found',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
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
                fontSize: 16,
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
                      fontSize: 20,
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
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// backup code below that works fine without ocean theme
//   @override
//   Widget build(BuildContext context) {
//     const oceanColor = Color.fromARGB(255, 158, 223, 180);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F6FB),
//       appBar: AppBar(
//         title: const Text(
//           'User Profile',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: oceanColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),

//             // Profile Image with Shadow
//             Container(
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: oceanColor.withOpacity(0.3),
//                     blurRadius: 15,
//                     offset: const Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: CircleAvatar(
//                 radius: 70,
//                 backgroundColor: Colors.white,
//                 backgroundImage:
//                     imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
//                 child: imageUrl.isEmpty
//                     ? const Icon(Icons.person, size: 70, color: Colors.grey)
//                     : null,
//               ),
//             ),

//             const SizedBox(height: 20),

//             // User Name with Edit Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Text(
//                     userName.isNotEmpty ? userName : 'No Name Found',
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.edit, color: oceanColor, size: 26),
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Edit Profile Coming Soon..."),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),

//             const SizedBox(height: 6),

//             // Email
//             Text(
//               email.isNotEmpty ? email : 'No Email Found',
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.black54,
//               ),
//             ),

//             const SizedBox(height: 10),

//             // Project Name
//             Text(
//               projectName.isNotEmpty ? projectName : 'No Project Name Found',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: oceanColor,
//               ),
//             ),

//             const SizedBox(height: 25),

//             // Card with user details
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: oceanColor.withOpacity(0.3),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Profile Details",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: oceanColor,
//                     ),
//                   ),

//                   const Divider(),
//                   _infoRow(Icons.perm_identity, "Project Name",
//                       projectName ?? 'Unknown'),
//                   const SizedBox(height: 15),
//                   _infoRow(Icons.phone, "Contact",
//                       contact.isNotEmpty ? contact : 'No Contact Found'),
//                   const Divider(),
//                   _infoRow(Icons.home, "Address",
//                       address.isNotEmpty ? address : 'No Address Found'),
//                   // const Divider(),
//                   // _infoRow(Icons.perm_identity, "Device ID",
//                   //     deviceUserId ?? 'Unknown'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// // Helper widget for info rows with ocean-themed icons
//   Widget _infoRow(IconData icon, String label, String value) {
//     const oceanColor = Color.fromARGB(255, 158, 223, 180);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: oceanColor, size: 22),
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
