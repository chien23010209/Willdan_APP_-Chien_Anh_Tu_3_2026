import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ContentScreen extends StatelessWidget {
  const ContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('📚 Cẩm nang toàn thư', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
        const SizedBox(height: 10),
        _buildSectionHeader('Động vật', Icons.pets, Colors.red),
        ...DummyData.animals.map((e) => ListTile(leading: const Icon(Icons.circle, size: 10, color: Colors.red), title: Text(e.name))),
        
        _buildSectionHeader('Thực vật', Icons.eco, Colors.green),
        ...DummyData.plants.map((e) => ListTile(leading: const Icon(Icons.circle, size: 10, color: Colors.green), title: Text(e.name))),
        
        _buildSectionHeader('Kỹ năng', Icons.local_fire_department, Colors.orange),
        ...DummyData.skills.map((e) => ListTile(leading: const Icon(Icons.circle, size: 10, color: Colors.orange), title: Text(e.name))),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 10),
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
