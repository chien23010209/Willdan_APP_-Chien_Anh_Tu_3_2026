// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'category_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0), // Padding tổng thể
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tiêu đề Dashboard
          const Text(
            'Bảng Điều Khiển Sinh Tồn',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Text(
            'Rừng Quốc gia Cúc Phương & Việt Nam',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 24), // Khoảng cách
          
          // DANH SÁCH CÁC THANH NGANG (LIST VIEW)
          Expanded(
            child: ListView(
              // Loại bỏ padding mặc định của ListView để sát lề Column
              padding: EdgeInsets.zero, 
              children: [
                _buildHorizontalBar(
                  context,
                  title: 'Động Vật',
                  icon: Icons.pets,
                  color: Colors.red.shade700,
                  categoryType: 'Animal',
                ),
                const SizedBox(height: 16), // Khoảng cách giữa các thanh
                _buildHorizontalBar(
                  context,
                  title: 'Thực Vật',
                  icon: Icons.eco,
                  color: Colors.green.shade700,
                  categoryType: 'Plant',
                ),
                const SizedBox(height: 16),
                _buildHorizontalBar(
                  context,
                  title: 'Kỹ Năng',
                  icon: Icons.local_fire_department,
                  color: Colors.orange.shade700,
                  categoryType: 'Skill',
                ),
                const SizedBox(height: 16),
                _buildHorizontalBar(
                  context,
                  title: 'Dụng Cụ',
                  icon: Icons.handyman,
                  color: Colors.blue.shade700,
                  categoryType: 'Tool',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tạo nút bấm dạng THANH NGANG xịn xò
  Widget _buildHorizontalBar(BuildContext context, {required String title, required IconData icon, required Color color, required String categoryType}) {
    return InkWell(
      onTap: () {
        // Chuyển sang màn hình danh sách chi tiết tương ứng
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryListScreen(categoryType: categoryType, title: title, color: color)),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding trong thanh
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Nền nhạt
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Row(
          children: [
            // Icon bên trái
            Icon(icon, size: 30, color: color),
            const SizedBox(width: 20), // Khoảng cách giữa icon và chữ
            
            // Tiêu đề (Expanded để chiếm hết không gian còn lại)
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            
            // Icon mũi tên trỏ sang phải (Tạo cảm giác bấm được)
            Icon(Icons.arrow_forward_ios, size: 16, color: color.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}