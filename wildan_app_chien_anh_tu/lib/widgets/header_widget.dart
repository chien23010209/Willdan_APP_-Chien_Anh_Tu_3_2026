import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160, 
      decoration: const BoxDecoration(
        color: Colors.green,
        image: DecorationImage(
          image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/e/e9/Cuc_Phuong_National_Park_Gate.jpg'),
          fit: BoxFit.cover,
          opacity: 0.8,
        ),
      ),
      child: Stack(
        children: [
          Container(color: Colors.black45), // Lớp phủ tối
          const Positioned(
            bottom: 15,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ĐẠI HỌC CÔNG NGHỆ THÔNG TIN PHENIKAA', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text('Bí kíp sinh tồn thực tế Rừng Cúc Phương', style: TextStyle(color: Colors.white, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}