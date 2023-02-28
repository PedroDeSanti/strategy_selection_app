import 'package:flutter/material.dart';
import 'package:strategy_selection_app/pages/strategies_selection_page.dart';
import 'pages/dashboard_page.dart';

class StrategySelectionApp extends StatelessWidget {
  const StrategySelectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const StrategySelectionPage(),
    );
  }
}
