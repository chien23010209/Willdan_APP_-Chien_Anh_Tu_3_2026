import 'package:flutter/material.dart';

/// Bảng màu phân loại theo mô tả Wildan:
/// 🔴 Đỏ = Khẩn cấp/Nguy hiểm
/// 🟢 Xanh lá = An toàn/Ăn được
/// 🔵 Xanh dương = Thông tin/Hướng dẫn
/// 🟡 Vàng = Cảnh báo/Lưu ý
class AppColors {
  static const Color danger = Color(0xFFE53935); // Đỏ
  static const Color safe = Color(0xFF2E7D32); // Xanh lá đậm
  static const Color info = Color(0xFF1565C0); // Xanh dương
  static const Color warning = Color(0xFFF9A825); // Vàng
  static const Color medicine = Color(0xFF6A1B9A); // Dược liệu

  // Tông xanh chủ đạo của app (rừng)
  static const Color forest = Color(0xFF1B5E20); // xanh rừng đậm
  static const Color leaf = Color(0xFF43A047); // xanh lá tươi
  static const Color moss = Color(0xFF66BB6A); // xanh rêu sáng

  /// Lấy màu theo danh mục loài / hướng dẫn
  static Color byCategory(String category) {
    switch (category) {
      case 'edible':
        return safe;
      case 'danger':
        return danger;
      case 'medicine':
        return info;
      case 'useful':
        return warning;
      default:
        return info;
    }
  }
}

class AppTheme {
  static const _seed = AppColors.forest;

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.light,
      primary: AppColors.forest,
      secondary: AppColors.leaf,
    ),
    // Nền hơi ngả xanh lá
    scaffoldBackgroundColor: const Color(0xFFEDF5ED),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.forest,
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFFE0EFE0),
      indicatorColor: AppColors.moss.withOpacity(0.45),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.leaf,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      // Chữ to, dễ nhìn trong điều kiện khắc nghiệt
      bodyMedium: TextStyle(fontSize: 15.5, height: 1.4),
      bodyLarge: TextStyle(fontSize: 17, height: 1.45),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
      primary: AppColors.moss,
      secondary: AppColors.leaf,
    ),
    // Nền đen ngả xanh giúp tiết kiệm pin màn OLED ban đêm
    scaffoldBackgroundColor: const Color(0xFF071107),
    cardTheme: CardThemeData(
      color: const Color(0xFF122113),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0E1C0E),
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF0E1C0E),
      indicatorColor: AppColors.forest.withOpacity(0.6),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.leaf,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 15.5, height: 1.4),
      bodyLarge: TextStyle(fontSize: 17, height: 1.45),
    ),
  );
}
