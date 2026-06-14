import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import 'emergency_screen.dart';
import 'survival/survival_detail_screen.dart';
import 'tools/compass_screen.dart';
import 'tools/flashlight_screen.dart';
import 'tools/map_screen.dart';
import 'tools/chatbot_screen.dart';
import 'tools/sos_flash_screen.dart';
import 'tools/journal_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ---- HEADER ----
            SliverToBoxAdapter(child: _Header(state: state)),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ---- NÚT SOS NỔI BẬT ----
                  _SosBigButton(),
                  const SizedBox(height: 16),

                  // ---- THÔNG TIN VỊ TRÍ ----
                  _LocationCard(state: state),
                  const SizedBox(height: 20),

                  _SectionTitle('⚡ Công cụ nhanh'),
                  const SizedBox(height: 12),
                  _QuickTools(),
                  const SizedBox(height: 24),

                  _SectionTitle('📋 Hướng dẫn sinh tồn'),
                  const SizedBox(height: 12),
                  _SurvivalCategories(),
                  const SizedBox(height: 24),

                  _LocalAdvice(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final AppState state;
  const _Header({required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('🌲', style: TextStyle(fontSize: 26)),
                    const SizedBox(width: 8),
                    Text('Wildan',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.place, size: 16, color: AppColors.danger),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(state.locationName,
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: state.isDark ? 'Chế độ sáng' : 'Chế độ tối',
            onPressed: () => context.read<AppState>().toggleTheme(),
            icon: Icon(state.isDark ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}

class _SosBigButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.danger,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const EmergencyScreen())),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          child: Row(
            children: [
              const Text('🚨', style: TextStyle(fontSize: 38)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('CHẾ ĐỘ KHẨN CẤP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Một chạm để xử lý tình huống nguy hiểm',
                        style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final AppState state;
  const _LocationCard({required this.state});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Vị trí hiện tại',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const Spacer(),
                // chấm xanh nhấp nháy báo GPS hoạt động
                _BlinkingDot(active: state.gpsActive),
                const SizedBox(width: 6),
                Text(state.gpsActive ? 'GPS' : 'No GPS',
                    style: const TextStyle(fontSize: 12, color: AppColors.safe)),
              ],
            ),
            const Divider(height: 20),
            _infoRow('📍', 'Toạ độ GPS', state.coordsText),
            _infoRow('🌍', 'Khu vực', state.region),
            _infoRow('🌡️', 'Khí hậu', state.climate),
            _infoRow('⛰️', 'Địa hình', state.terrain),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Text('$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class _BlinkingDot extends StatefulWidget {
  final bool active;
  const _BlinkingDot({required this.active});
  @override
  State<_BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<_BlinkingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 800))
        ..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.active ? _c : const AlwaysStoppedAnimation(0.3),
      child: Container(
        width: 12,
        height: 12,
        decoration: const BoxDecoration(
            color: AppColors.safe, shape: BoxShape.circle),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(text,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold));
}

class _QuickTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tools = <_Tool>[
      _Tool('🧭', Icons.explore, 'La bàn', AppColors.info, const CompassScreen()),
      _Tool('🔦', Icons.flashlight_on, 'Đèn pin', AppColors.warning, const FlashlightScreen()),
      _Tool('🗺️', Icons.map, 'Bản đồ', AppColors.safe, const MapScreen()),
      _Tool('💬', Icons.medical_services, 'Sơ cứu AI', AppColors.info, const ChatbotScreen()),
      _Tool('⚡', Icons.sos, 'SOS Flash', AppColors.danger, const SosFlashScreen()),
      _Tool('📖', Icons.menu_book, 'Nhật ký', AppColors.medicine, const JournalScreen()),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.95,
      children: tools.map((t) => _ToolCard(tool: t)).toList(),
    );
  }
}

class _Tool {
  final String emoji;
  final IconData icon;
  final String label;
  final Color color;
  final Widget screen;
  _Tool(this.emoji, this.icon, this.label, this.color, this.screen);
}

class _ToolCard extends StatelessWidget {
  final _Tool tool;
  const _ToolCard({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: tool.color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => tool.screen)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon nền tròn + emoji nổi
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: tool.color.withOpacity(0.18),
                    child: Icon(tool.icon, color: tool.color, size: 26),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Text(tool.emoji,
                        style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(tool.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: tool.color)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SurvivalCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final guides = context.watch<AppState>().guides;
    return Column(
      children: guides.map((g) {
        final c = _colorForKey(g.color);
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: Text(g.emoji, style: const TextStyle(fontSize: 30)),
            title: Text(g.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Ưu tiên #${g.priority} • ${g.steps.length} bước'),
            trailing: Icon(Icons.chevron_right, color: c),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SurvivalDetailScreen(guide: g))),
          ),
        );
      }).toList(),
    );
  }

  Color _colorForKey(String key) {
    switch (key) {
      case 'danger':
        return AppColors.danger;
      case 'safe':
        return AppColors.safe;
      case 'warning':
        return AppColors.warning;
      default:
        return AppColors.info;
    }
  }
}

class _LocalAdvice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.warning.withOpacity(0.12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('🟡 Lời khuyên địa phương — Cúc Phương',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text('🛤️ Đường mòn: Theo dấu vết động vật đến nguồn nước.'),
            SizedBox(height: 6),
            Text('⚠️ Nguy hiểm: Rắn hổ mang và ong rừng hoạt động mạnh.'),
            SizedBox(height: 6),
            Text('✅ Lợi thế: Nhiều hang đá tự nhiên để trú ẩn.'),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 6),
            Text('⏱️ Quy tắc số 3 sinh tồn',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('3 phút không khí • 3 giờ thời tiết khắc nghiệt\n'
                '3 ngày không nước • 3 tuần không ăn'),
            SizedBox(height: 6),
            Text('→ Ưu tiên: An toàn > Trú ẩn > Nước > Lửa > Thức ăn',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }
}
