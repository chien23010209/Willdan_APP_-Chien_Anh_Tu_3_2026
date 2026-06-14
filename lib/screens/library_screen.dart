import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/app_state.dart';
import '../theme/app_theme.dart';
import 'species_detail_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _query = '';
  String _typeFilter = 'all'; // all | plant | animal
  String _catFilter = 'all'; // all | edible | danger | medicine | useful

  @override
  Widget build(BuildContext context) {
    final all = context.watch<AppState>().species;
    final list = all.where((s) {
      final matchQuery = _query.isEmpty ||
          s.name.toLowerCase().contains(_query.toLowerCase()) ||
          s.scientificName.toLowerCase().contains(_query.toLowerCase());
      final matchType = _typeFilter == 'all' || s.type == _typeFilter;
      final matchCat = _catFilter == 'all' || s.category == _catFilter;
      return matchQuery && matchType && matchCat;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('📚 Thư viện loài')),
      body: Column(
        children: [
          // Tìm kiếm
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Gõ tên loài để tìm...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14)),
                isDense: true,
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          // Lọc theo loại
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _chip('Tất cả', _typeFilter == 'all',
                    () => setState(() => _typeFilter = 'all')),
                _chip('🌱 Thực vật', _typeFilter == 'plant',
                    () => setState(() => _typeFilter = 'plant')),
                _chip('🦎 Động vật', _typeFilter == 'animal',
                    () => setState(() => _typeFilter = 'animal')),
              ],
            ),
          ),
          // Lọc theo danh mục
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _catChip('Tất cả', 'all', Colors.grey),
                _catChip('✅ Ăn được', 'edible', AppColors.safe),
                _catChip('⚠️ Nguy hiểm', 'danger', AppColors.danger),
                _catChip('💊 Dược liệu', 'medicine', AppColors.info),
                _catChip('🔧 Hữu dụng', 'useful', AppColors.warning),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: list.isEmpty
                ? const Center(child: Text('Không tìm thấy loài nào.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: list.length,
                    itemBuilder: (_, i) => _SpeciesCard(species: list[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
      ),
    );
  }

  Widget _catChip(String label, String value, Color color) {
    final selected = _catFilter == value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        selectedColor: color.withOpacity(0.25),
        onSelected: (_) => setState(() => _catFilter = value),
      ),
    );
  }
}

class _SpeciesCard extends StatelessWidget {
  final Species species;
  const _SpeciesCard({required this.species});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.byCategory(species.category);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Text(species.emoji, style: const TextStyle(fontSize: 36)),
        title: Text(species.name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(species.scientificName,
                style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(_catLabel(species.category),
                  style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => SpeciesDetailScreen(species: species))),
      ),
    );
  }

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
