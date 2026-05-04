import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class CategoryListScreen extends StatelessWidget {
  final String categoryType;
  final String title;
  final Color color;

  const CategoryListScreen({super.key, required this.categoryType, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    List<dynamic> items = [];
    if (categoryType == 'Animal') items = DummyData.animals;
    if (categoryType == 'Plant') items = DummyData.plants;
    if (categoryType == 'Skill') items = DummyData.skills;
    if (categoryType == 'Tool') items = DummyData.tools;

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: color,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                  const Divider(),
                  if (categoryType == 'Animal') ...[
                    _buildTextRow('Độ nguy hiểm:', item.dangerLevel, isAlert: true),
                    _buildTextRow('Mô tả:', item.description),
                    _buildTextRow('Sơ cứu:', item.firstAid, isAction: true),
                  ],
                  if (categoryType == 'Plant') ...[
                    _buildTextRow('Độc tính:', item.toxicity, isAlert: true),
                    _buildTextRow('Mô tả:', item.description),
                    _buildTextRow('Sử dụng:', item.usage, isAction: true),
                  ],
                  if (categoryType == 'Skill') ...[
                    _buildTextRow('Mục đích:', item.description),
                    const SizedBox(height: 8),
                    const Text('Các bước thực hiện:', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...item.steps.map((step) => Padding(padding: const EdgeInsets.only(top: 4, left: 10), child: Text('• $step'))).toList(),
                  ],
                  if (categoryType == 'Tool') ...[
                    _buildTextRow('Quan trọng:', item.importance, isAlert: true),
                    _buildTextRow('Mô tả:', item.description),
                    _buildTextRow('Cách dùng:', item.usage, isAction: true),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextRow(String label, String content, {bool isAlert = false, bool isAction = false}) {
    Color textColor = Colors.black87;
    if (isAlert && (content.contains('Nguy') || content.contains('Độc') || content.contains('Tử vong'))) textColor = Colors.red;
    else if (isAction) textColor = Colors.green.shade700;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          children: [
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: content, style: TextStyle(color: textColor, fontWeight: isAlert || isAction ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}