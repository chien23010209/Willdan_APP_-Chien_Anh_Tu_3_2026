import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import '../../theme/app_theme.dart';

class CompassScreen extends StatelessWidget {
  const CompassScreen({super.key});

  String _dirName(double deg) {
    const dirs = ['Bắc', 'Đông Bắc', 'Đông', 'Đông Nam', 'Nam', 'Tây Nam', 'Tây', 'Tây Bắc'];
    final i = ((deg + 22.5) % 360 ~/ 45).toInt();
    return dirs[i % 8];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🧭 La bàn số')),
      body: StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const _NoSensor();
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          double? heading = snapshot.data!.heading;
          if (heading == null) return const _NoSensor();
          if (heading < 0) heading += 360;

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text('${heading.toStringAsFixed(0)}°',
                    style: const TextStyle(
                        fontSize: 56, fontWeight: FontWeight.bold)),
              ),
              Center(
                child: Text(_dirName(heading),
                    style: const TextStyle(
                        fontSize: 24, color: AppColors.info)),
              ),
              const SizedBox(height: 24),
              Center(
                child: Transform.rotate(
                  angle: -heading * math.pi / 180,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.info, width: 3),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text('B',
                                  style: TextStyle(
                                      color: AppColors.danger,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            )),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('N',
                                    style: TextStyle(fontSize: 20)))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('T',
                                    style: TextStyle(fontSize: 20)))),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Đ',
                                    style: TextStyle(fontSize: 20)))),
                        Icon(Icons.navigation,
                            size: 60, color: AppColors.danger),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                color: AppColors.info.withOpacity(0.12),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🔵 Định hướng không cần la bàn',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('☀️ Mặt trời mọc hướng Đông, lặn hướng Tây.'),
                      Text('⭐ Ban đêm: tìm sao Bắc Đẩu chỉ hướng Bắc.'),
                      Text('🌿 Rêu thường mọc dày phía Bắc (ẩm) của thân cây.'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NoSensor extends StatelessWidget {
  const _NoSensor();
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          '⚠️ Thiết bị không có cảm biến từ trường (magnetometer).\n\n'
          'Hãy dùng phương pháp định hướng bằng mặt trời/sao.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
