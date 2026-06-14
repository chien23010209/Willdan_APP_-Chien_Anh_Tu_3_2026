import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';

/// Chế độ Khẩn cấp - nền đỏ toàn màn hình.
class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      backgroundColor: AppColors.danger,
      appBar: AppBar(
        backgroundColor: AppColors.danger,
        foregroundColor: Colors.white,
        title: const Text('🚨 CHẾ ĐỘ KHẨN CẤP'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _BlinkWarning(),
          const SizedBox(height: 16),

          // Số điện thoại khẩn cấp
          _whiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('📞 Số khẩn cấp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 10),
                _callRow('115', 'Cấp cứu y tế'),
                _callRow('113', 'Công an'),
                _callRow('114', 'Cứu hỏa'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Thông tin vị trí cho cứu hộ
          _whiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('📍 Thông tin vị trí (báo cứu hộ)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 8),
                Text('Địa điểm: ${state.locationName}'),
                Text('Toạ độ GPS: ${state.coordsText}'),
                Text('Khu vực: ${state.region}'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Ưu tiên hành động
          _whiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('✅ Ưu tiên hành động (4 bước)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(height: 8),
                Text('1️⃣ Đảm bảo an toàn: Rời khỏi khu nguy hiểm'),
                Text('2️⃣ Xử lý vết thương: Cầm máu, rửa, băng bó'),
                Text('3️⃣ Tạo tín hiệu cứu hộ: 3 đống lửa, còi, SOS'),
                Text('4️⃣ Ở yên tại chỗ: Dễ tìm hơn khi ở một chỗ'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Sơ cứu 5 tình huống
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('🩹 Hướng dẫn sơ cứu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
          ...state.firstAid.map((f) => _FirstAidTile(aid: f)),

          const SizedBox(height: 12),
          // Quy tắc số 3
          _whiteCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('⏱️ Quy tắc số 3',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(height: 8),
                Text('• 3 phút không khí → Chết ngạt'),
                Text('• 3 giờ thời tiết khắc nghiệt → Hạ thân nhiệt'),
                Text('• 3 ngày không nước → Mất nước nghiêm trọng'),
                Text('• 3 tuần không ăn → Suy kiệt'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _whiteCard({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: DefaultTextStyle.merge(
          style: const TextStyle(color: Colors.black87),
          child: child,
        ),
      );

  Widget _callRow(String number, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('$number — $label')),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white),
            onPressed: () async {
              final uri = Uri.parse('tel:$number');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
            icon: const Icon(Icons.call, size: 18),
            label: const Text('Gọi'),
          ),
        ],
      ),
    );
  }
}

class _BlinkWarning extends StatefulWidget {
  const _BlinkWarning();
  @override
  State<_BlinkWarning> createState() => _BlinkWarningState();
}

class _BlinkWarningState extends State<_BlinkWarning>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _c,
      child: const Center(
        child: Text('⚠️', style: TextStyle(fontSize: 64)),
      ),
    );
  }
}

class _FirstAidTile extends StatelessWidget {
  final FirstAid aid;
  const _FirstAidTile({required this.aid});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Text(aid.emoji, style: const TextStyle(fontSize: 28)),
          title: Text(aid.title,
              style: const TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
          childrenPadding:
              const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            ...aid.doSteps.map((s) => _line('✓ ', s, AppColors.safe)),
            ...aid.dontSteps.map((s) => _line('', s, AppColors.danger)),
            if (aid.callEmergency)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text('🚨 GỌI CẤP CỨU 115 NGAY',
                    style: TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _line(String prefix, String text, Color color) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prefix, style: TextStyle(color: color)),
            Expanded(
                child: Text(text, style: TextStyle(color: color))),
          ],
        ),
      );
}
