import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:torch_light/torch_light.dart';

import '../../providers/app_state.dart';
import '../../theme/app_theme.dart';

class SosFlashScreen extends StatefulWidget {
  const SosFlashScreen({super.key});
  @override
  State<SosFlashScreen> createState() => _SosFlashScreenState();
}

class _SosFlashScreenState extends State<SosFlashScreen> {
  bool _running = false;
  bool _flashOn = false;
  Timer? _timer;

  // Pattern SOS: 3 ngắn (dot), 3 dài (dash), 3 ngắn (dot)
  // mỗi phần tử: [bật?, thời lượng ms]
  static const int _unit = 250;
  final List<List<dynamic>> _pattern = [
    [true, _unit], [false, _unit], // S: dot
    [true, _unit], [false, _unit],
    [true, _unit], [false, _unit * 3],
    [true, _unit * 3], [false, _unit], // O: dash
    [true, _unit * 3], [false, _unit],
    [true, _unit * 3], [false, _unit * 3],
    [true, _unit], [false, _unit], // S: dot
    [true, _unit], [false, _unit],
    [true, _unit], [false, _unit * 7], // nghỉ giữa các chu kỳ
  ];

  int _step = 0;

  void _start() async {
    setState(() => _running = true);
    _runStep();
  }

  void _runStep() async {
    if (!_running) return;
    final on = _pattern[_step][0] as bool;
    final dur = _pattern[_step][1] as int;
    try {
      if (on) {
        await TorchLight.enableTorch();
      } else {
        await TorchLight.disableTorch();
      }
    } catch (_) {}
    setState(() => _flashOn = on);
    _timer = Timer(Duration(milliseconds: dur), () {
      _step = (_step + 1) % _pattern.length;
      _runStep();
    });
  }

  void _stop() async {
    _timer?.cancel();
    _running = false;
    _step = 0;
    try {
      await TorchLight.disableTorch();
    } catch (_) {}
    setState(() => _flashOn = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    TorchLight.disableTorch().catchError((_) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('⚡ SOS Flash (Morse)')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _flashOn ? AppColors.warning : Colors.grey.shade700,
                boxShadow: _flashOn
                    ? [
                        BoxShadow(
                            color: AppColors.warning.withOpacity(0.7),
                            blurRadius: 40,
                            spreadRadius: 10)
                      ]
                    : null,
              ),
              child: Icon(
                _flashOn ? Icons.flashlight_on : Icons.flashlight_off,
                size: 56,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('• • •  — — —  • • •',
                style: TextStyle(fontSize: 24, letterSpacing: 2)),
          ),
          const Center(
              child: Text('S         O         S',
                  style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _running ? AppColors.danger : AppColors.warning,
                foregroundColor: Colors.white,
              ),
              onPressed: _running ? _stop : _start,
              icon: Icon(_running ? Icons.stop : Icons.play_arrow),
              label: Text(_running ? 'DỪNG TÍN HIỆU' : 'PHÁT TÍN HIỆU SOS',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📍 Toạ độ cung cấp cho cứu hộ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(state.coordsText,
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: AppColors.info.withOpacity(0.12),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔵 Phương pháp tín hiệu khác',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('🔥 Lửa & khói (3 đống tam giác)'),
                  Text('💨 Khói trắng ban ngày, lửa sáng ban đêm'),
                  Text('📣 Âm thanh: 3 tiếng còi/la, lặp mỗi phút'),
                  Text('💡 Phản chiếu ánh sáng bằng gương/kim loại'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
