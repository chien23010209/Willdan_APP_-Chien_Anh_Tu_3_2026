import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(Icons.school, size: 60, color: Colors.green.shade800),
          const SizedBox(height: 15),
          const Text('ĐẠI HỌC CÔNG NGHỆ THÔNG TIN PHENIKAA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green), textAlign: TextAlign.center),
          const Divider(height: 40, thickness: 1),
          const Align(alignment: Alignment.centerLeft, child: Text('👥 Danh sách thành viên:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 15),
          _buildMemberCard('Tạ Công Chiến', '23010209'),
          _buildMemberCard('Nguyễn Văn Tú', '23010109'),
          _buildMemberCard('Nguyễn Lê Đức Anh', '23010246'),
          const SizedBox(height: 20),
          const Text('Dự án cung cấp kiến thức sinh tồn dựa trên thực tế, tuân thủ nguyên tắc phi trò chơi (không thanh sinh lực, không gamification).', style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5), textAlign: TextAlign.justify),
        ],
      ),
    );
  }

  Widget _buildMemberCard(String name, String id) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.green.shade100, child: const Icon(Icons.person, color: Colors.green)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('MSSV: $id'),
      ),
    );
  }
}