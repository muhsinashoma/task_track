import 'package:flutter/material.dart';
import 'kaban_set_state_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State manager showcase'),
      ),
      body: ListView(
        children: [
          _buildListTile(
            title: 'Set State -----------------test purpose---------',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const KanbanSetStatePage()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
