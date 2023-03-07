import 'package:flutter/material.dart';

import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/widgets/meals_item.dart';

class CategoryMealsPage extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeal;
  const CategoryMealsPage(this.availableMeal);

  @override
  State<CategoryMealsPage> createState() => _CategoryMealsPageState();
}

class _CategoryMealsPageState extends State<CategoryMealsPage> {
  bool didInit = false;
  late String categoryTitle;
  late List<Meal> categoryMeals;
  @override
  void didChangeDependencies() {
    if (!didInit) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeal
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      didInit = true;
    }

    super.didChangeDependencies();
  }

  deleteMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return MealsItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              duration: categoryMeals[index].duration,
              imageUrl: categoryMeals[index].imageUrl,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability,
            );
          },
          itemCount: categoryMeals.length,
        ));
  }
}
