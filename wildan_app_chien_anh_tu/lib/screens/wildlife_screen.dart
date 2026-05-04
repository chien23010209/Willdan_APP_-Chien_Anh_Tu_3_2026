import 'package:flutter/material.dart';
import '../data/listwildlife.dart';

class WildlifeScreen extends StatefulWidget {
  final ListWildlife wildlifeManager;
  const WildlifeScreen({super.key, required this.wildlifeManager});

  @override
  State<WildlifeScreen> createState() => _WildlifeScreenState();
}

class _WildlifeScreenState extends State<WildlifeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('⚠️ CẢNH BÁO HIỂM HỌA', 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.redAccent)),
        const SizedBox(height: 10),
        
        // READ: Hiển thị danh sách Wildlife
        Column(
          children: widget.wildlifeManager.wildlifes.map((wildlife) => Card(
            elevation: 3,
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              leading: Icon(
                wildlife.isPoisonous ? Icons.warning : Icons.pets, 
                color: wildlife.isPoisonous ? Colors.red : Colors.orange
              ),
              title: Text(wildlife.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Mức độ nguy hiểm: ${wildlife.dangerLevel}'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🐾 Tập tính: ${wildlife.behavior}'),
                      const SizedBox(height: 5),
                      Text(wildlife.getEmergencyNote(), 
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // EDIT: Sửa thông tin
                          TextButton.icon(
                            onPressed: () => setState(() {
                              widget.wildlifeManager.editWildlife(wildlife.id, "Cực kỳ cao", "Rút lui chậm rãi, không quay lưng.");
                            }),
                            icon: const Icon(Icons.edit),
                            label: const Text("Cập nhật"),
                          ),
                          // DELETE: Xóa thông tin
                          TextButton.icon(
                            onPressed: () => setState(() {
                              widget.wildlifeManager.deleteWildlife(wildlife.id);
                            }),
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text("Xóa"),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )).toList(),
        ),
        
        const SizedBox(height: 10),
        
        // CREATE: Thêm mới
        ElevatedButton.icon(
          onPressed: () => setState(() {
            int id = widget.wildlifeManager.wildlifes.length + 1;
            widget.wildlifeManager.addWildlife(
              id, "Sinh vật mới $id", "Trung bình", "Chưa rõ tập tính", "Quan sát từ xa", false
            );
          }),
          icon: const Icon(Icons.add_moderator),
          label: const Text("Báo cáo hiểm họa mới"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade50),
        )
      ],
    );
  }
}