import 'package:flutter/material.dart';

// Import các màn hình (Screens)
import 'screens/home_screen.dart';
import 'screens/content_screen.dart';
import 'screens/wildlife_screen.dart';
import 'screens/about_screen.dart';

// Import dữ liệu và logic (Data)
import 'data/listsurvivalkit.dart';
import 'data/listwildlife.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sinh Tồn Cúc Phương',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Khởi tạo các bộ quản lý dữ liệu (Dùng chung cho toàn bộ App)
  final ListSurvivalKit kitManager = ListSurvivalKit();
  final ListWildlife wildlifeManager = ListWildlife();

@override
  void initState() {
    super.initState();

    // --- THÊM DANH SÁCH DỤNG CỤ SINH TỒN ---
    kitManager.createKit(1, "Dao đi rừng", "Cắt gọt, tự vệ, dựng lều", 1);
    kitManager.createKit(2, "Bật lửa & Đá lửa", "Tạo lửa sưởi ấm và nấu ăn", 3);
    kitManager.createKit(3, "Túi sơ cứu Y tế", "Băng bó vết thương, thuốc sát trùng", 2);
    kitManager.createKit(4, "Đèn pin siêu sáng", "Di chuyển ban đêm, phát tín hiệu", 2);
    kitManager.createKit(5, "Bình lọc nước", "Lọc nước suối thành nước uống", 1);
    kitManager.createKit(6, "Còi sinh tồn", "Phát tín hiệu cứu hộ khi lạc", 3);

    // --- THÊM DANH SÁCH CẢNH BÁO HIỂM HỌA ---
    // Hiểm họa có độc
    wildlifeManager.addWildlife(
      1, 
      "Rắn Lục Đuôi Đỏ", 
      "Cực kỳ cao", 
      "Hay nằm trên cành lá xanh, ngụy trang rất tốt", 
      "Không dùng tay gạt cành cây bừa bãi. Nếu bị cắn, giữ yên chi và đến y tế.", 
      true
    );

    // Hiểm họa gây khó chịu
    wildlifeManager.addWildlife(
      2, 
      "Vắt Rừng", 
      "Thấp", 
      "Xuất hiện nhiều sau mưa, bám vào chân người", 
      "Bôi cao sao vàng hoặc thuốc chống vắt vào giày và tất.", 
      false
    );

    // Hiểm họa động vật lớn
    wildlifeManager.addWildlife(
      3, 
      "Lợn Rừng Độc Chiếc", 
      "Cao", 
      "Hung dữ khi cảm thấy bị đe dọa hoặc đang nuôi con", 
      "Tuyệt đối không lại gần chụp ảnh. Nếu bị tấn công, hãy leo lên cây cao.", 
      false
    );

    // Hiểm họa côn trùng độc
    wildlifeManager.addWildlife(
      4, 
      "Sâu Róm Độc", 
      "Trung bình", 
      "Sống trên thân cây, lông gây ngứa và dị ứng nặng", 
      "Không tựa lưng vào thân cây lạ. Dùng băng dính lấy lông độc ra nếu chạm phải.", 
      true
    );
  }

  @override
  Widget build(BuildContext context) {
    // Danh sách các màn hình tương ứng với các Tab
    final List<Widget> _screens = [
      const HomeScreen(),
      ContentScreen(kitManager: kitManager),
      WildlifeScreen(wildlifeManager: wildlifeManager),
      const AboutScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hành Trình Cúc Phương", 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        elevation: 2,
      ),
      
      // Hiển thị màn hình dựa trên index của Tab đang chọn
      body: _screens[_currentIndex],

      // Thanh điều hướng dưới cùng
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green.shade800,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Dụng cụ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            activeIcon: Icon(Icons.warning_rounded),
            label: 'Hiểm họa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}