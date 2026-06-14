# 🌲 Wildan — Ứng dụng hướng dẫn sinh tồn offline (Flutter + Firebase)

Ứng dụng di động hướng dẫn sinh tồn trong rừng Việt Nam, tập trung vào **Vườn Quốc gia Cúc Phương**.
Hoạt động **offline** (dữ liệu được cache), dữ liệu quản lý qua **Firebase Firestore**.

> Bài tập lớn — Flutter (Android/iOS)

---

## ✨ Tính năng

**3 tab chính:** 🏠 Trang chủ · 📚 Thư viện · 🚨 SOS

**6 công cụ nhanh:**
| Công cụ | Mô tả |
|---|---|
| 🧭 La bàn số | Dùng cảm biến từ trường (`flutter_compass`) |
| 🔦 Đèn pin | Flash camera thật (`torch_light`) + đèn màn hình |
| 🗺️ Bản đồ offline | Sơ đồ điểm quan trọng (nước, trú ẩn, nguy hiểm) |
| 💬 Sơ cứu AI | Chatbot offline (rule-based), 6 tình huống |
| ⚡ SOS Flash | Phát mã Morse `••• ——— •••` bằng đèn flash |
| 📖 Nhật ký lộ trình | Đọc/ghi **realtime Firestore** |

**Nội dung:**
- 6 danh mục sinh tồn (Nước, Trú ẩn, Lửa, Thức ăn, Định hướng, Cứu hộ)
- Thư viện 10 loài động-thực vật + bộ lọc/tìm kiếm
- Chế độ khẩn cấp (nền đỏ): số 115/113/114, 5 hướng dẫn sơ cứu, quy tắc số 3
- 🌙 Dark/Light mode (tiết kiệm pin)

---

## 🚀 Cài đặt & chạy

### 1. Cài Flutter
Cần Flutter SDK ≥ 3.0. Kiểm tra:
```bash
flutter --version
flutter doctor
```

### 2. Sinh thư mục nền tảng & lấy dependencies
Dự án này chứa mã nguồn `lib/` và `pubspec.yaml`. Để có thư mục `android/`, `ios/`...
chạy lệnh sau **bên trong thư mục `wildan/`** (chỉ cần 1 lần):
```bash
cd wildan
flutter create .      # sinh android/ ios/ ... mà không ghi đè lib/
flutter pub get
```

### 3. Cấu hình Firebase
👉 Xem chi tiết trong **`firebase_setup_guide.md`**. Tóm tắt:
```bash
# Cài CLI
dart pub global activate flutterfire_cli
# Tạo cấu hình tự động (ghi đè lib/firebase_options.dart)
flutterfire configure
```

### 4. Chạy app
```bash
flutter run
```
Lần chạy đầu tiên, app tự **nạp (seed)** 10 loài + 6 hướng dẫn + 5 sơ cứu lên Firestore.

> ⚠️ Nếu chưa cấu hình Firebase, app vẫn chạy được bằng **dữ liệu mẫu offline** (`lib/services/seed_data.dart`).

---

## 🗂️ Cấu trúc thư mục

```
lib/
├── main.dart                  # Khởi tạo Firebase + app
├── firebase_options.dart      # Cấu hình Firebase (thay bằng file thật)
├── theme/app_theme.dart       # Theme sáng/tối + bảng màu phân loại
├── models/models.dart         # Species, SurvivalGuide, FirstAid, JournalEntry
├── services/
│   ├── firebase_service.dart  # Đọc/ghi Firestore + seed + fallback offline
│   └── seed_data.dart         # Dữ liệu gốc (10 loài, 6 hướng dẫn, 5 sơ cứu)
├── providers/app_state.dart   # State: theme, dữ liệu, GPS
└── screens/
    ├── main_shell.dart        # Bottom navigation 3 tab
    ├── dashboard_screen.dart  # Trang chủ
    ├── library_screen.dart    # Thư viện + chi tiết loài
    ├── sos_screen.dart        # Tab SOS
    ├── emergency_screen.dart  # Chế độ khẩn cấp (nền đỏ)
    ├── species_detail_screen.dart
    ├── survival/survival_detail_screen.dart
    └── tools/                 # 6 công cụ
        ├── compass_screen.dart
        ├── flashlight_screen.dart
        ├── map_screen.dart
        ├── chatbot_screen.dart
        ├── sos_flash_screen.dart
        └── journal_screen.dart
```

## 🔥 Cấu trúc dữ liệu Firestore
```
species/{id}     → loài động-thực vật
guides/{id}      → hướng dẫn sinh tồn (sắp xếp theo priority)
first_aid/{id}   → hướng dẫn sơ cứu
journal/{id}     → nhật ký lộ trình (đọc/ghi realtime)
```

## 🎨 Bảng màu phân loại
- 🔴 Đỏ = Khẩn cấp / Nguy hiểm
- 🟢 Xanh lá = An toàn / Ăn được
- 🔵 Xanh dương = Thông tin / Hướng dẫn / Dược liệu
- 🟡 Vàng = Cảnh báo / Lưu ý / Hữu dụng
