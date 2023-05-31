import 'package:flutter/material.dart';
// import 'package:strategy_selection_app/pages/dashboard_page.dart';
import 'package:strategy_selection_app/pages/home_page.dart';
// import 'package:strategy_selection_app/pages/strategies_selection_page.dart';

class StrategySelectionApp extends StatelessWidget {
  const StrategySelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.grey,
      ),
      home: const HomePage(),
    );
  }
}
