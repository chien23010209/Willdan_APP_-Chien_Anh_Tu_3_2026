import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/models.dart';
import '../../providers/app_state.dart';
import '../../services/firebase_service.dart';
import '../../theme/app_theme.dart';

/// Nhật ký lộ trình — đọc/ghi dữ liệu realtime từ Firebase Firestore.
class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseService.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('📖 Nhật ký lộ trình')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDialog(context),
        icon: const Icon(Icons.add_location_alt),
        label: const Text('Đánh dấu'),
      ),
      body: StreamBuilder<List<JournalEntry>>(
        stream: fb.journalStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final entries = snapshot.data ?? [];
          if (entries.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  '📍 Chưa có điểm nào.\nNhấn "Đánh dấu" để lưu vị trí quan trọng '
                  '(nguồn nước, trú ẩn, nguy hiểm...).',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: entries.length,
            itemBuilder: (_, i) {
              final e = entries[i];
              return Card(
                child: ListTile(
                  leading: Text(JournalEntry.emojiFor(e.type),
                      style: const TextStyle(fontSize: 30)),
                  title: Text(e.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (e.note.isNotEmpty) Text(e.note),
                      Text('${JournalEntry.labelFor(e.type)} • '
                          '${e.lat.toStringAsFixed(4)}, ${e.lng.toStringAsFixed(4)}'),
                      Text(DateFormat('dd/MM/yyyy HH:mm').format(e.time),
                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: AppColors.danger),
                    onPressed: () => fb.deleteJournalEntry(e.id),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final state = context.read<AppState>();
    final titleCtrl = TextEditingController();
    final noteCtrl = TextEditingController();
    String type = 'water';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (ctx, setSheet) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Đánh dấu điểm mới',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                // Chọn loại
                Wrap(
                  spacing: 8,
                  children: [
                    _typeChoice('water', '💧 Nguồn nước', type,
                        (v) => setSheet(() => type = v)),
                    _typeChoice('shelter', '🏕️ Trú ẩn', type,
                        (v) => setSheet(() => type = v)),
                    _typeChoice('danger', '⚠️ Nguy hiểm', type,
                        (v) => setSheet(() => type = v)),
                    _typeChoice('mark', '📍 Đánh dấu', type,
                        (v) => setSheet(() => type = v)),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Tiêu đề', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noteCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Mô tả (tuỳ chọn)',
                      border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text('📍 Toạ độ tự động: ${state.coordsText}',
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (titleCtrl.text.trim().isEmpty) return;
                      await FirebaseService.instance.addJournalEntry(
                        JournalEntry(
                          id: '',
                          type: type,
                          title: titleCtrl.text.trim(),
                          note: noteCtrl.text.trim(),
                          lat: state.lat,
                          lng: state.lng,
                          time: DateTime.now(),
                        ),
                      );
                      if (ctx.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('Lưu điểm'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _typeChoice(
      String value, String label, String current, ValueChanged<String> onSel) {
    return ChoiceChip(
      label: Text(label),
      selected: current == value,
      onSelected: (_) => onSel(value),
    );
  }
}
