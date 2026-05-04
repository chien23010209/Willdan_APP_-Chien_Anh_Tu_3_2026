import 'package:flutter/material.dart';
import 'main_layout.dart';

void main() {
  runApp(const SurvivalApp());
}

class SurvivalApp extends StatelessWidget {
  const SurvivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sinh Tồn Cúc Phương',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade800),
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: const MainLayout(),
    );
  }
}