# 🔥 Hướng dẫn cấu hình Firebase cho Wildan

## Bước 1: Tạo dự án Firebase
1. Vào https://console.firebase.google.com
2. Nhấn **Add project** → đặt tên (vd: `wildan-app`) → tạo.

## Bước 2: Bật Firestore Database
1. Trong Firebase Console → **Build → Firestore Database**.
2. Nhấn **Create database** → chọn **Start in test mode** (cho phép đọc/ghi khi học tập).
3. Chọn vùng (region) gần nhất, vd `asia-southeast1`.

> ⚠️ Test mode chỉ dùng để học. Trước khi nộp/triển khai thật, đặt lại Rules (xem cuối file).

## Bước 3: Kết nối Flutter (cách nhanh nhất — FlutterFire CLI)
```bash
# 1. Cài Firebase CLI (cần Node.js)
npm install -g firebase-tools
firebase login

# 2. Cài FlutterFire CLI
dart pub global activate flutterfire_cli

# 3. Tại thư mục dự án wildan/, chạy:
flutterfire configure
```
Lệnh trên sẽ:
- Tự tạo app Android/iOS trên Firebase
- **Ghi đè** `lib/firebase_options.dart` bằng cấu hình thật
- Tự thêm file `google-services.json` (Android) / `GoogleService-Info.plist` (iOS)

## Bước 4 (Android): kiểm tra Gradle
Đảm bảo trong `android/build.gradle` (project-level) có:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.1'
}
```
Và cuối `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```
Đặt `minSdkVersion` ≥ 23 trong `android/app/build.gradle`:
```gradle
defaultConfig {
    minSdkVersion 23
}
```
> FlutterFire CLI thường tự thêm các dòng này. Nếu chạy lỗi, kiểm tra lại.

## Bước 5: Chạy app
```bash
flutter pub get
flutter run
```
Lần đầu chạy, app tự nạp dữ liệu mẫu (10 loài, 6 hướng dẫn, 5 sơ cứu) lên Firestore
qua hàm `FirebaseService.seedIfEmpty()`.

---

## 🔒 Firestore Security Rules (đề xuất khi nộp bài)
Vào **Firestore → Rules**, dán:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Nội dung hướng dẫn: chỉ đọc
    match /species/{id}   { allow read: if true; allow write: if false; }
    match /guides/{id}    { allow read: if true; allow write: if false; }
    match /first_aid/{id} { allow read: if true; allow write: if false; }

    // Nhật ký: cho phép đọc & ghi (demo). Thực tế nên gắn Auth.
    match /journal/{id}   { allow read, write: if true; }
  }
}
```
> Lưu ý: vì app cần seed dữ liệu lần đầu, có thể tạm để `write: if true` cho
> species/guides/first_aid khi chạy lần đầu, rồi đổi lại `if false` sau khi đã nạp.

## ❓ App vẫn chạy được nếu chưa có Firebase?
Có. Nếu Firebase chưa cấu hình hoặc mất mạng, app dùng dữ liệu trong
`lib/services/seed_data.dart` (trừ chức năng Nhật ký cần Firestore để lưu).
