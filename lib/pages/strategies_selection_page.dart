import 'package:flutter/material.dart';
import 'package:strategy_selection_app/models/startegy.dart';
import 'package:strategy_selection_app/pages/strategy_page.dart';
import 'package:strategy_selection_app/repositories/strategy_repository.dart';

class StrategySelectionPage extends StatefulWidget {
  const StrategySelectionPage({super.key});

  @override
  State<StrategySelectionPage> createState() => _StrategySelectionPageState();
}

class _StrategySelectionPageState extends State<StrategySelectionPage> {
  List<Strategy> strategyList = StrategyRepository.strategies;

  List<Strategy> selectedStrategies = [];

  final _formKey = GlobalKey<FormState>();
  final _valor = TextEditingController();

  _strategyAddButton() {
    return !_isSelecting()
        ? FloatingActionButton(
            onPressed: () {
              _addNewStrategy();
            },
            child: const Icon(Icons.add),
          )
        : null;
  }

  Widget _strategyListView() {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            leading: (selectedStrategies.contains(strategyList[index]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : const Icon(Icons.circle),
            title: Text(strategyList[index].name),
            subtitle: Text(strategyList[index].description),
            trailing: const Icon(Icons.arrow_forward_ios),
            selected: selectedStrategies.contains(strategyList[index]),
            tileColor: Colors.grey[200],
            selectedTileColor: Colors.blue[50],
            onLongPress: () {
              _toggleSelection(strategyList[index]);
            },
            onTap: () {
              if (_isSelecting()) {
                _toggleSelection(strategyList[index]);
              } else {
                _openStrategy(strategyList[index]);
              }
            },
          ),
        );
      },
      padding: const EdgeInsets.all(16),
      // separatorBuilder: (_, __) => const Divider(),
      itemCount: strategyList.length,
    );
  }

  Widget _dynamicSliverAppBar() {
    if (_isSelecting()) {
      return SliverAppBar.large(
        centerTitle: true,
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
              _showDeletionDialog();
            },
          ),
        ],
      );
    } else {
      return SliverAppBar.large(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Strategies'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      );
    }
  }

  Widget _dynamicAppBar() {
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
              _showDeletionDialog();
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

  void _addNewStrategy() {
    if (_valor.text.isNotEmpty) {
      _valor.clear();
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                    controller: _valor,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Strategy name',
                      prefixIcon: Icon(Icons.edit),
                    ),
                    validator: _validateText),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        strategyList.add(Strategy(
                          name: _valor.text,
                          description: 'Description',
                          id: strategyList.length,
                        ));
                      });
                      _formKey.currentState!.reset();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Strategy added'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      // isScrollControlled: true,
    );
  }

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void _openStrategy(Strategy strategy) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StrategyPage(
          strategy: strategy,
        );
      },
      // isScrollControlled: true,
    );
  }

  void _showDeletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete selected strategies?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedStrategies();
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedStrategies() {
    setState(() {
      strategyList
          .removeWhere((strategy) => selectedStrategies.contains(strategy));
      selectedStrategies = [];
    });
  }

  void _toggleSelection(Strategy strategy) {
    setState(() {
      (selectedStrategies.contains(strategy))
          ? selectedStrategies.remove(strategy)
          : selectedStrategies.add(strategy);
    });
  }

  bool _isSelecting() {
    return selectedStrategies.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return <Widget>[
            _dynamicSliverAppBar(),
          ];
        },
        body: _strategyListView(),
      ),

      // appBar: _dynamicAppBar(),
      // body: _strategyListView(),

      floatingActionButton: _strategyAddButton(),
    );
  }
}
