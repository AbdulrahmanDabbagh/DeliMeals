import 'package:deli_meals/models/meal.dart';
import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './categories_page.dart';
import './favorites_page.dart';

class TabsPage extends StatefulWidget {
  final List<Meal> favoritesMeal;
  const TabsPage(this.favoritesMeal);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  late List<Map<String, Object>> pages;
  @override
  void initState() {
    pages = [
    {
      'page': CategoriesPage(),
      'title': 'Categories',
    },
    {
      'page': FavoritesPage(widget.favoritesMeal),
      'title': 'Your Favorites',
    }
  ];
    super.initState();
  }
  int _curentPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _curentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_curentPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: pages[_curentPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _curentPageIndex,
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
