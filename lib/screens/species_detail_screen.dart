import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class SpeciesDetailScreen extends StatelessWidget {
  final Species species;
  const SpeciesDetailScreen({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.byCategory(species.category);
    return Scaffold(
      appBar: AppBar(title: Text(species.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Text(species.emoji, style: const TextStyle(fontSize: 90)),
                const SizedBox(height: 8),
                Text(species.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(species.scientificName,
                    style: const TextStyle(fontStyle: FontStyle.italic)),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(_catLabel(species.category),
                      style: TextStyle(
                          color: color, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _section('📝 Mô tả', species.description),
          _bulletSection('🔍 Đặc điểm nhận dạng', species.identification),
          if (species.usage.isNotEmpty) _section('🔧 Cách sử dụng', species.usage),
          if (species.warning.isNotEmpty)
            _warningCard(species.warning),
          _section('📍 Nơi thường gặp', species.habitat),
        ],
      ),
    );
  }

  Widget _section(String title, String body) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(body),
          ],
        ),
      );

  Widget _bulletSection(String title, List<String> items) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            ...items.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(e)),
                    ],
                  ),
                )),
          ],
        ),
      );

  Widget _warningCard(String text) => Card(
        color: AppColors.danger.withOpacity(0.12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded,
                  color: AppColors.danger),
              const SizedBox(width: 10),
              Expanded(
                child: Text(text,
                    style: const TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );

  String _catLabel(String cat) {
    switch (cat) {
      case 'edible':
        return '✅ Ăn được';
      case 'danger':
        return '⚠️ Nguy hiểm';
      case 'medicine':
        return '💊 Dược liệu';
      default:
        return '🔧 Hữu dụng';
    }
  }
}
