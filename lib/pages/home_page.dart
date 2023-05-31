import 'package:flutter/material.dart';
import 'package:strategy_selection_app/pages/dashboard_page.dart';
import 'package:strategy_selection_app/pages/debug_page.dart';
import 'package:strategy_selection_app/pages/settings_page.dart';
import 'package:strategy_selection_app/pages/strategies_selection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 1;

  _navigateBottomBar(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final List<Widget> _pages = const [
    StrategySelectionPage(),
    DashboardPage(),
    DebugPage(),
    SettingsPage(),
  ];

  _customNavBar() {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(
        height: 90,
      ),
      child: NavigationBar(
        selectedIndex: _currentPage,
        onDestinationSelected: _navigateBottomBar,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        animationDuration: const Duration(milliseconds: 1800),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined, size: 28),
            selectedIcon: Icon(Icons.list_alt_rounded, size: 28),
            label: 'Strategies',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined, size: 28),
            selectedIcon: Icon(Icons.dashboard_rounded, size: 28),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.bug_report_outlined, size: 28),
            selectedIcon: Icon(Icons.bug_report_rounded, size: 28),
            label: 'Debug',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, size: 28),
            selectedIcon: Icon(Icons.settings_rounded, size: 28),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  _customBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: _navigateBottomBar,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Strategies',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bug_report),
          label: 'Debug',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: _customNavBar(),
    );
  }
}
