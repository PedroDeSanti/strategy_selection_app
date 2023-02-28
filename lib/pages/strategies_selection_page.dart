import 'package:flutter/material.dart';
import 'package:strategy_selection_app/models/startegy.dart';
import 'package:strategy_selection_app/repositories/strategy_repository.dart';

class StrategySelectionPage extends StatefulWidget {
  const StrategySelectionPage({super.key});

  @override
  State<StrategySelectionPage> createState() => _StrategySelectionPageState();
}

class _StrategySelectionPageState extends State<StrategySelectionPage> {
  final strategyList = StrategyRepository.strategies;

  List<Strategy> selectedStrategies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _dynamicAppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            leading: (selectedStrategies.contains(strategyList[index]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : const Icon(Icons.star_border),
            title: Text(strategyList[index].name),
            subtitle: Text(strategyList[index].description),
            trailing: const Icon(Icons.arrow_forward_ios),
            selected: selectedStrategies.contains(strategyList[index]),
            selectedTileColor: Colors.blue[50],
            onLongPress: () {
              _toggleSelection(strategyList[index]);
            },
            onTap: () {
              if (_isSelecting()) {
                _toggleSelection(strategyList[index]);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(strategyList[index].name),
                      ),
                      body: Center(
                        child: Text(strategyList[index].description),
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: strategyList.length,
      ),
    );
  }

  _dynamicAppBar() {
    if (_isSelecting()) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selectedStrategies.clear();
            });
          },
        ),
        title: Text('${selectedStrategies.length} selected'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                selectedStrategies.clear();
              });
            },
          ),
        ],
      );
    } else {
      return AppBar(
        title: const Text('Strategies'),
      );
    }
  }

  _toggleSelection(Strategy strategy) {
    setState(() {
      (selectedStrategies.contains(strategy))
          ? selectedStrategies.remove(strategy)
          : selectedStrategies.add(strategy);
    });
  }

  _isSelecting() {
    return selectedStrategies.isNotEmpty;
  }
}
