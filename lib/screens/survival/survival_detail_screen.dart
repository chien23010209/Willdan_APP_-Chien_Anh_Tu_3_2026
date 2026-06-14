import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../theme/app_theme.dart';

class SurvivalDetailScreen extends StatelessWidget {
  final SurvivalGuide guide;
  const SurvivalDetailScreen({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${guide.emoji} ${guide.title}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(guide.emoji, style: const TextStyle(fontSize: 44)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(guide.title,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold)),
                        Text('Ưu tiên #${guide.priority}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Các bước thực hiện',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...guide.steps.asMap().entries.map((e) {
            final i = e.key;
            final step = e.value;
            return _StepTile(index: i + 1, step: step);
          }),
          const SizedBox(height: 16),
          // Thông tin địa phương
          Card(
            color: AppColors.warning.withOpacity(0.12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🟡 Thông tin địa phương',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(guide.localInfo),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final int index;
  final GuideStep step;
  const _StepTile({required this.index, required this.step});

  @override
  Widget build(BuildContext context) {
    final warning = step.isWarning;
    return Card(
      color: warning ? AppColors.danger.withOpacity(0.10) : null,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor:
                  warning ? AppColors.danger : AppColors.safe,
              child: warning
                  ? const Icon(Icons.priority_high,
                      size: 16, color: Colors.white)
                  : Text('$index',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(step.text,
                  style: TextStyle(
                      color: warning ? AppColors.danger : null,
                      fontWeight: warning ? FontWeight.w600 : null)),
            ),
          ],
        ),
      ),
    );
  }
}
