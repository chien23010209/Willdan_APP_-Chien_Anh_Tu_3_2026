import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import '../../theme/app_theme.dart';

class FlashlightScreen extends StatefulWidget {
  const FlashlightScreen({super.key});
  @override
  State<FlashlightScreen> createState() => _FlashlightScreenState();
}

class _FlashlightScreenState extends State<FlashlightScreen> {
  bool _torchOn = false;
  bool _screenLight = false;
  double _brightness = 0.8; // 10% - 100%

  Future<void> _toggleTorch() async {
    try {
      if (_torchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() => _torchOn = !_torchOn);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Thiết bị không có đèn flash.')));
      }
    }
  }

  @override
  void dispose() {
    if (_torchOn) {
      TorchLight.disableTorch().catchError((_) {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_screenLight) {
      // Màn hình trắng làm đèn
      return GestureDetector(
        onTap: () => setState(() => _screenLight = false),
        child: Scaffold(
          backgroundColor: Colors.white.withOpacity(_brightness),
          body: const Center(
            child: Text('Chạm để tắt',
                style: TextStyle(color: Colors.black54)),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('🔦 Đèn pin')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Đèn flash thật
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(Icons.flashlight_on,
                      size: 60,
                      color: _torchOn ? AppColors.warning : Colors.grey),
                  const SizedBox(height: 12),
                  const Text('Đèn flash camera',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: Text(_torchOn ? 'Đang bật' : 'Đang tắt'),
                    value: _torchOn,
                    onChanged: (_) => _toggleTorch(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Đèn màn hình
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('💡 Đèn màn hình',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Độ sáng: ${(_brightness * 100).toInt()}%'),
                  Slider(
                    value: _brightness,
                    min: 0.1,
                    max: 1.0,
                    onChanged: (v) => setState(() => _brightness = v),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => setState(() => _screenLight = true),
                      icon: const Icon(Icons.lightbulb),
                      label: const Text('Bật đèn màn hình'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: AppColors.warning.withOpacity(0.12),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🟡 Cảnh báo & nguồn sáng thay thế',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('🔋 Đèn flash tiêu hao pin rất nhanh — chỉ bật khi cần.'),
                  SizedBox(height: 6),
                  Text('Nguồn sáng thay thế: lửa 🔥, nhựa cây dễ cháy, mỡ động vật.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
