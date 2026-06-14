import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../providers/app_state.dart';
import '../../theme/app_theme.dart';

/// Bản đồ tương tác (OpenStreetMap qua flutter_map).
/// - Cache offline: sau khi xem 1 lần, tile được lưu nên xem lại được khi mất mạng.
/// - Marker điểm quan trọng quanh Vườn Quốc gia Cúc Phương.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapPoint {
  final String emoji, name, dist;
  final LatLng pos;
  final Color color;
  _MapPoint(this.emoji, this.name, this.dist, this.pos, this.color);
}

class _MapScreenState extends State<MapScreen> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final me = LatLng(state.lat, state.lng);

    // Các điểm quan trọng quanh Cúc Phương (toạ độ minh hoạ)
    final points = <_MapPoint>[
      _MapPoint('💧', 'Suối tự nhiên #1', '~320m • ĐB',
          LatLng(state.lat + 0.004, state.lng + 0.003), AppColors.info),
      _MapPoint('💧', 'Suối tự nhiên #2', '~850m • B',
          LatLng(state.lat + 0.008, state.lng - 0.001), AppColors.info),
      _MapPoint('🏕️', 'Điểm cắm trại', '~180m • N',
          LatLng(state.lat - 0.0018, state.lng + 0.001), AppColors.safe),
      _MapPoint('🛤️', 'Đường mòn chính', '~90m • T',
          LatLng(state.lat, state.lng - 0.0012), AppColors.warning),
      _MapPoint('⚠️', 'Khu vực hang sâu', '~450m • Đ',
          LatLng(state.lat - 0.001, state.lng + 0.005), AppColors.danger),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🗺️ Bản đồ Offline'),
        actions: [
          IconButton(
            tooltip: 'Về vị trí của tôi',
            icon: const Icon(Icons.my_location),
            onPressed: () => _mapController.move(me, 15),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: me,
                    initialZoom: 14.5,
                    minZoom: 3,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.wildan',
                      // tile được cache tự động để xem lại offline
                      tileProvider: NetworkTileProvider(),
                    ),
                    // Marker các điểm quan trọng
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: me,
                          width: 70,
                          height: 70,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.my_location,
                                  color: AppColors.danger, size: 30),
                              Text('Bạn',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.danger)),
                            ],
                          ),
                        ),
                        ...points.map((p) => Marker(
                              point: p.pos,
                              width: 44,
                              height: 44,
                              child: GestureDetector(
                                onTap: () => _showPoint(context, p),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: p.color.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(p.emoji,
                                      style: const TextStyle(fontSize: 20)),
                                ),
                              ),
                            )),
                      ],
                    ),
                    // Ghi nguồn bản đồ (bắt buộc với OSM)
                    const RichAttributionWidget(
                      attributions: [
                        TextSourceAttribution('© OpenStreetMap contributors'),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(state.coordsText,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
          // Danh sách điểm
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: points
                  .map((p) => GestureDetector(
                        onTap: () {
                          _mapController.move(p.pos, 16);
                          _showPoint(context, p);
                        },
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: p.color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: p.color.withOpacity(0.4)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.emoji,
                                  style: const TextStyle(fontSize: 26)),
                              const Spacer(),
                              Text(p.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: p.color)),
                              Text(p.dist,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showPoint(BuildContext context, _MapPoint p) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(p.emoji, style: const TextStyle(fontSize: 36)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(p.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Khoảng cách: ${p.dist}'),
            Text('Toạ độ: ${p.pos.latitude.toStringAsFixed(4)}, '
                '${p.pos.longitude.toStringAsFixed(4)}'),
          ],
        ),
      ),
    );
  }
}
