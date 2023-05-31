import 'package:flutter/material.dart';
import 'package:strategy_selection_app/models/startegy.dart';

class StrategyPage extends StatefulWidget {
  StrategyPage({super.key, required this.strategy});

  Strategy strategy;

  @override
  State<StrategyPage> createState() => _StrategyPageState();
}

class _StrategyPageState extends State<StrategyPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.strategy.name),
        Text(widget.strategy.description),
      ],
    );
  }
}
