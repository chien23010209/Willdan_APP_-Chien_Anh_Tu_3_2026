import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import 'emergency_screen.dart';
import 'tools/sos_flash_screen.dart';

/// Tab SOS - cổng vào nhanh các tính năng cứu hộ khẩn cấp.
class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('🚨 SOS - Cứu hộ khẩn cấp')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bigAction(
            context,
            emoji: '🚨',
            title: 'CHẾ ĐỘ KHẨN CẤP',
            subtitle: 'Số cứu hộ, sơ cứu, ưu tiên hành động',
            color: AppColors.danger,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const EmergencyScreen())),
          ),
          const SizedBox(height: 12),
          _bigAction(
            context,
            emoji: '⚡',
            title: 'SOS FLASH (Morse)',
            subtitle: 'Phát tín hiệu • • • — — — • • • bằng đèn flash',
            color: AppColors.warning,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SosFlashScreen())),
          ),
          const SizedBox(height: 20),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📍 Toạ độ của bạn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(state.coordsText,
                      style: const TextStyle(fontSize: 18)),
                  Text(state.locationName),
                  const SizedBox(height: 4),
                  const Text('Cung cấp toạ độ này cho đội cứu hộ.',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: AppColors.info.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('🔵 Phương pháp tín hiệu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('🔥 Lửa/khói: 3 đống tam giác'),
                  Text('📣 Âm thanh: 3 tiếng, lặp mỗi phút'),
                  Text('💡 Phản chiếu ánh sáng: gương, điện thoại'),
                  Text('✏️ Chữ SOS trên đất (tối thiểu 3m x 3m)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bigAction(BuildContext context,
      {required String emoji,
      required String title,
      required String subtitle,
      required Color color,
      required VoidCallback onTap}) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 36)),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
