# 🏕️ Willdan-APP - Sổ Tay Sinh Tồn Toàn Diện

**Willdan-APP** không chỉ là một ứng dụng di động, mà là "người bạn đồng hành" không thể thiếu trong mọi chuyến phiêu lưu. Ứng dụng cung cấp kiến thức sinh tồn chuẩn xác (100% Offline) dành cho phượt thủ, người cắm trại và khám phá rừng nhiệt đới.

---

## ✅ BÁO CÁO KẾT QUẢ THỰC HIỆN ĐỒ ÁN (CẬP NHẬT MỚI NHẤT)
*(Phần trình bày kết quả thực hành theo yêu cầu bài tập nhóm)*

**1. Xây dựng Layout ứng dụng (Home / Content / About):**
* **Header & Footer:** Được thiết kế cố định, hiển thị thông tin ĐH Phenikaa và danh sách sinh viên nhóm trên mọi màn hình.
* **Home Screen:** Thiết kế dạng Dashboard với các nút hình vuông (Grid View) phân loại rõ ràng: *Động vật, Thực vật, Kỹ năng, Dụng cụ*.
* **Content Screen:** Sử dụng List View để trình bày cẩm nang sinh tồn chi tiết.
* **About Screen:** Thông tin dự án và profile các thành viên.

**2. Xây dựng Navigation Bar:**
* Tích hợp thành công `BottomNavigationBar` ở cuối cùng mỗi trang.
* Hỗ trợ điều hướng mượt mà giữa 3 màn hình chính mà không làm đứt gãy giao diện tổng thể.

**3. Sự thống nhất và Thực thi Mockup:**
* **Thiết kế (Layout/Màu sắc/Font chữ):** Thống nhất dùng màu Xanh lá (`Colors.green.shade800`) làm chủ đạo, đồng bộ thông qua `ThemeData` toàn ứng dụng.
* **Content & Chức năng:** Chuẩn hóa dữ liệu theo mô hình OOP (Chia 4 Model riêng biệt).
* **Mockup:** Mã nguồn hiện tại được thực thi bám sát 100% với bản vẽ "Mockup screen" do nhóm thiết kế trước đó.



## 👥 Đội ngũ Phát triển (Willdan Team)

| Họ và Tên | Mã sinh viên | Vai trò đảm nhận |
| :--- | :---: | :--- |
| **Tạ Công Chiến** | `23010209` | Quản lý dự án (PM) & Lập trình viên |
| **Nguyễn Văn Tú** | `23010109` | Thiết kế UI/UX, Lập trình Frontend & Viết báo cáo |
| **Nguyễn Lê Đức Anh** | `23010246` | Đảm bảo chất lượng (QA) & Lập trình Backend |

---

## 🚀 Tính năng chi tiết của Ứng dụng

### 1. 📚 Thư viện Kỹ năng Sinh tồn (Survival Guide)
* **Tìm kiếm và lọc nước:** Nhận biết nguồn nước an toàn, phương pháp lọc nước.
* **Tạo và duy trì lửa:** Kỹ thuật đánh lửa không cần diêm, giữ lửa môi trường ẩm.
* **Xây dựng nơi trú ẩn:** Hướng dẫn dựng lều, tạo hầm trú ẩn khẩn cấp.
* **Thực phẩm tự nhiên:** Phân biệt nấm độc, thực vật ăn được và đặt bẫy.

### 2. ⛑️ Sơ cứu Y tế Khẩn cấp (First Aid)
* Hướng dẫn CPR, cầm máu, cố định gãy xương, hạ thân nhiệt.
* Cách xử lý khi bị rắn độc cắn, côn trùng đốt.

### 3. 🛠️ Bộ công cụ Sinh tồn Tích hợp (Survival Tools)
* **La bàn định vị:** La bàn số học có độ chính xác cao.
* **Đèn pin & SOS:** Tích hợp đèn pin và nháy Flash theo mã Morse.
* **Còi báo động:** Phát âm thanh tần số cao thu hút cứu hộ.

### 4. ⚠️ Hệ thống Cảnh báo Hiểm họa (Wildlife CRUD) - *Đang nâng cấp*
* Quản lý Sinh vật nguy hiểm qua lớp đối tượng `Wildlife.dart`.
* Thao tác dữ liệu (CRUD): Thêm, Đọc, Cập nhật, Xóa bản ghi trực tiếp trên Dashboard.

---
## 💻 Kiến trúc & Công nghệ (Tech Stack)
* **Frontend:** Flutter (Dart)
* **Local DB:** SQLite
* **Cloud Services:** Firebase Authentication, Cloud Firestore
* **Tools:** Figma, Adobe Illustrator
