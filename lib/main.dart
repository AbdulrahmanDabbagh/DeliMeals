import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './pages/filters_page.dart';
import './pages/category_meals_page.dart';
import './pages/meal_details_page.dart';
import './pages/tabs_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'Vegan': false,
    'Gluten': false,
    'Vegetarian': false,
    'lactose': false,
  };
  List<Meal> availableMeal = DUMMY_MEALS;
  List<Meal> favoritesMeal = [];
  void setFilters(Map<String, bool> newFilters) {
    setState(() {
      _filters = newFilters;
      availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['Vegan'] as bool && !meal.isVegan){return false;} 
        if (_filters['Gluten'] as bool && !meal.isGlutenFree) {return false;}
        if (_filters['Vegetarian'] as bool && !meal.isVegetarian) {return false;}
        if (_filters['lactose'] as bool && !meal.isLactoseFree) {return false;}
        return true;
      }).toList();
    });
  }

  void toggelFavorite(String mealId){
    if(favoritesMeal.any((meal) => meal.id==mealId)){
      favoritesMeal.removeWhere((meal) => meal.id==mealId);
    }else {
      favoritesMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ('DeliMeals'),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyMedium: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleLarge: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      routes: {
        '/': (context) => TabsPage(favoritesMeal),
        CategoryMealsPage.routeName: (context) => CategoryMealsPage(availableMeal),
        MealDetailsPage.routeName: (context) => MealDetailsPage(toggelFavorite,favoritesMeal),
        FiltersPage.routeName: (context) => FiltersPage(_filters, setFilters),
      },
    );
  }
}
