import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersPage extends StatefulWidget {
  static const routeName = '/filter';
  final Function(Map<String, bool>) saveHandler;
  final Map<String, bool> filters;
  FiltersPage(this.filters, this.saveHandler);

  @override
  State<FiltersPage> createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  bool _glutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.filters['Gluten'] as bool;
    _isVegan = widget.filters['Vegan'] as bool;
    _isVegetarian = widget.filters['Vegetarian'] as bool;
    _lactoseFree = widget.filters['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchTile(
    String title,
    String description,
    Function(bool) onChanged,
    bool value,
  ) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'), actions: [
        IconButton(
          onPressed: () {
            Map<String, bool> newFilters = {
              'Vegan': _isVegan,
              'Gluten': _glutenFree,
              'Vegetarian': _isVegetarian,
              'lactose': _lactoseFree,
            };
            widget.saveHandler(newFilters);
          },
          icon: Icon(Icons.save),
        )
      ]),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile(
                'Gluten-free',
                'only include Gluten-free meals',
                (newvalue) {
                  setState(() {
                    _glutenFree = newvalue;
                  });
                },
                _glutenFree,
              ),
              _buildSwitchTile(
                'is Vegan',
                'only include Vegan meals',
                (newvalue) {
                  setState(() {
                    _isVegan = newvalue;
                  });
                },
                _isVegan,
              ),
              _buildSwitchTile(
                'is Vegetarian',
                'only include Vegetarian meals',
                (newvalue) {
                  setState(() {
                    _isVegetarian = newvalue;
                  });
                },
                _isVegetarian,
              ),
              _buildSwitchTile(
                'lactose-Free',
                'only include lactose-Free meals',
                (newvalue) {
                  setState(() {
                    _lactoseFree = newvalue;
                  });
                },
                _lactoseFree,
              )
            ],
          ))
        ],
      ),
    );
  }
}
