import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text('🧑 NHÓM PHÁT TRIỂN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue)),
        SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: CircleAvatar(child: Icon(Icons.group)),
            title: Text('Nhóm: Chiến - Anh - Tú'),
            subtitle: Text('Dự án: App Sinh Tồn Cúc Phương 2026'),
          ),
        ),
      ],
    );
  }
}