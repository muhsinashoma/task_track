import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Color.fromARGB(255, 164, 233, 167),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // You can add edit logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Edit feature coming soon!")),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            CircleAvatar(
              radius: 45,
              backgroundColor: Color.fromARGB(255, 166, 225, 168),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 50,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Muhsina Akter",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                "Assistant Manager (Web Development Application)",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ),
            Divider(height: 40),
            ListTile(
              leading: Icon(Icons.email_outlined, color: Colors.green),
              title: Text("Email"),
              subtitle: Text("muhsina.akter@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.phone_outlined, color: Colors.green),
              title: Text("Phone"),
              subtitle: Text("+8801XXXXXXXXX"),
            ),
            ListTile(
              leading: Icon(Icons.location_on_outlined, color: Colors.green),
              title: Text("Location"),
              subtitle: Text("Dhaka, Bangladesh"),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today_outlined, color: Colors.green),
              title: Text("Joined Date"),
              subtitle: Text("January 2024"),
            ),
          ],
        ),
      ),
    );
  }
}
