import 'package:flutter/material.dart';
import '../data/listsurvivalkit.dart';

class ContentScreen extends StatefulWidget {
  final ListSurvivalKit kitManager;
  const ContentScreen({super.key, required this.kitManager});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('🎒 QUẢN LÝ DỤNG CỤ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.brown)),
        const SizedBox(height: 10),
        Card(
          child: Column(
            children: widget.kitManager.kits.map((kit) => ListTile(
              leading: const Icon(Icons.handyman, color: Colors.brown),
              title: Text(kit.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('SL: ${kit.quantity} - ${kit.function}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit, color: Colors.blue), 
                    onPressed: () => setState(() => widget.kitManager.editKit(kit.id, "Đã sửa", 99))),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red), 
                    onPressed: () => setState(() => widget.kitManager.deleteKit(kit.id))),
                ],
              ),
            )).toList(),
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() {
            int id = widget.kitManager.kits.length + 1;
            widget.kitManager.createKit(id, "Món mới $id", "Dùng để sinh tồn", 1);
          }),
          child: const Text("Thêm đồ mới"),
        )
      ],
    );
  }
}