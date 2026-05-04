import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey.shade200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Khoa CNTT\nĐH Phenikaa', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 13)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Tạ Công Chiến - 23010209', style: TextStyle(fontSize: 12, color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
              Text('Nguyễn Văn Tú - 23010109', style: TextStyle(fontSize: 12, color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
              Text('Nguyễn Lê Đức Anh - 23010246', style: TextStyle(fontSize: 12, color: Colors.grey.shade800, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}