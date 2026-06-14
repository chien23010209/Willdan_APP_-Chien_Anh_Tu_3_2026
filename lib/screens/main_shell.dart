import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';
import 'dashboard_screen.dart';
import 'library_screen.dart';
import 'sos_screen.dart';

/// Khung chính chứa 3 tab: Trang chủ, Thư viện, SOS.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _pages = const [
    DashboardScreen(),
    LibraryScreen(),
    SosScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Text('🏠', style: TextStyle(fontSize: 22)),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Text('📚', style: TextStyle(fontSize: 22)),
            label: 'Thư viện',
          ),
          NavigationDestination(
            icon: Text('🚨', style: TextStyle(fontSize: 22)),
            label: 'SOS',
          ),
        ],
      ),
    );
  }
}
