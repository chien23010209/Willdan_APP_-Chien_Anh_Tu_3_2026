import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'providers/app_state.dart';
import 'services/firebase_service.dart';
import 'screens/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebas
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseService.enableOfflinePersistence();
  } catch (e) {
    // App vẫn chạy offline bằng dữ liệu mẫu nếu Firebase chưa cấu hình.
    debugPrint('Firebase init lỗi (chạy chế độ offline): $e');
  }

  runApp(const WildanApp());
}

class WildanApp extends StatelessWidget {
  const WildanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..init(),
      child: Consumer<AppState>(
        builder: (context, state, _) {
          return MaterialApp(
            title: 'Wildan',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            home: const MainShell(),
          );
        },
      ),
    );
  }
}
