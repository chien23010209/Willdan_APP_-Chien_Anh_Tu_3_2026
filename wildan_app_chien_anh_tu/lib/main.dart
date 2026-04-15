import 'package:flutter/material.dart';

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
      home: const CucPhuongSurvivalPage(title: 'Hành Trình Rừng Cúc Phương'),
    );
  }
}

class CucPhuongSurvivalPage extends StatefulWidget {
  const CucPhuongSurvivalPage({super.key, required this.title});
  final String title;

  @override
  State<CucPhuongSurvivalPage> createState() => _CucPhuongSurvivalPageState();
}

class _CucPhuongSurvivalPageState extends State<CucPhuongSurvivalPage> {
  // ========================================================================
  // YÊU CẦU 1: THỰC HIỆN SỬ DỤNG CÁC BIẾN (Forest, People, Survival)
  // ========================================================================
  
  String forestName = "Vườn Quốc gia Cúc Phương";
  double temperature = 26.5;

  int teamHealthPoints = 100;
  bool isRaining = false;

  int daysSurvived = 2;
  String targetLocation = "Cây Chò Ngàn Năm";

  // ========================================================================
  // YÊU CẦU 2: THỰC HIỆN SỬ DỤNG COLLECTIONS (Array, List, Map)
  // ========================================================================
  
  final List<String> teamMembers = <String>['Chiến', 'Tú', 'Đức Anh'];
  final List<String> inventory = <String>['Thuốc chống vắt', 'Đèn pin', 'Áo mưa', 'Bản đồ', 'Lều trại'];
  
  final Map<String, int> staminaMap = {
    'Chiến': 95,
    'Tú': 88,
    'Đức Anh': 90,
  };

  // ========================================================================
  // YÊU CẦU 4: TẠO VÀ HIỂN THỊ LIST TƯƠNG ỨNG ĐỐI TƯỢNG (Forest có id, name)
  // ========================================================================
  
  final List<Map<String, dynamic>> listForest = [
    {'id': 1, 'name': 'Rừng Cúc Phương'}, 
    {'id': 2, 'name': 'Rừng Quốc Gia Ba Vì'}, 
    {'id': 3, 'name': 'Rừng U Minh'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            // --- 1. HIỂN THỊ CÁC BIẾN (YÊU CẦU 1) ---
            const Text('🌲 THÔNG TIN HÀNH TRÌNH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.green)),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Địa điểm: $forestName'),
                    Text('Nhiệt độ: $temperature°C | Thời tiết: ${isRaining ? "Đang mưa" : "Tạnh ráo"}'),
                    const Divider(),
                    Text('Mục tiêu: $targetLocation'),
                    Text('Thời gian đi rừng: Ngày thứ $daysSurvived'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. HIỂN THỊ LIST BẰNG DẠNG ROW (YÊU CẦU 2 & 3) ---
            const Text('🧑 NHÓM SINH TỒN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
            Card(
              elevation: 2,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Icon(Icons.group, color: Colors.blue),
                      const SizedBox(width: 8),
                      for (var member in teamMembers) 
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            avatar: const Icon(Icons.person, size: 16),
                            label: Text(member, style: const TextStyle(fontWeight: FontWeight.bold)),
                            backgroundColor: Colors.white,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 3. HIỂN THỊ MAP BẰNG DẠNG ROW (YÊU CẦU 2 & 3) ---
            const Text('🔋 THỂ LỰC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.orange)),
            Card(
              elevation: 2,
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: staminaMap.entries.map((entry) => 
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.battery_charging_full, size: 20, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text('${entry.key}: ${entry.value}%', style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                      )
                    ).toList(),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 4. HIỂN THỊ LIST ĐỐI TƯỢNG (YÊU CẦU 4) ---
            const Text('🗺️ DANH SÁCH RỪNG ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.purple)),
            Card(
              elevation: 2,
              child: Column(
                // Sử dụng hàm .map() để duyệt qua List Map và hiển thị thành các dòng ListTile
                children: listForest.map((forest) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple.shade100,
                        child: Text('${forest['id']}', style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                      ),
                      title: Text('${forest['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        // Tính năng mở rộng: Bấm vào dòng này có thể làm gì đó sau này
                      },
                    ),
                    // Ngăn cách giữa các rừng bằng đường kẻ, ngoại trừ rừng cuối cùng
                    if (forest != listForest.last) const Divider(height: 1, indent: 16, endIndent: 16),
                  ],
                )).toList(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}