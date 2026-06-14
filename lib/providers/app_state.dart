import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../services/firebase_service.dart';

/// Quản lý trạng thái toàn app: theme, dữ liệu thư viện/hướng dẫn, vị trí GPS.
class AppState extends ChangeNotifier {
  final _fb = FirebaseService.instance;

  // ---- Theme ----
  ThemeMode _themeMode = ThemeMode.dark; // mặc định tối để tiết kiệm pin
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  // ---- Dữ liệu ----
  List<Species> species = [];
  List<SurvivalGuide> guides = [];
  List<FirstAid> firstAid = [];
  bool loading = true;

  // ---- Vị trí (demo cho Cúc Phương) ----
  String locationName = 'Vườn Quốc gia Cúc Phương';
  String region = 'Ninh Bình, Việt Nam';
  String climate = 'Nhiệt đới gió mùa';
  String terrain = 'Rừng núi đá vôi';
  double lat = 20.3167;
  double lng = 105.6667;
  bool gpsActive = true;

  Future<void> init() async {
    // Khôi phục theme đã lưu
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('themeMode');
    if (saved == 'light') _themeMode = ThemeMode.light;

    // Nạp dữ liệu lên Firestore lần đầu (nếu rỗng), rồi đọc về
    await _fb.seedIfEmpty();
    species = await _fb.getSpecies();
    guides = await _fb.getGuides();
    firstAid = await _fb.getFirstAid();
    loading = false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', isDark ? 'dark' : 'light');
  }

  void updateLocation(double newLat, double newLng) {
    lat = newLat;
    lng = newLng;
    gpsActive = true;
    notifyListeners();
  }

  String get coordsText =>
      '${lat.toStringAsFixed(4)}°N, ${lng.toStringAsFixed(4)}°E';
}
