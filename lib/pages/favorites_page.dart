import 'package:deli_meals/models/meal.dart';
import 'package:deli_meals/widgets/meals_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FavoritesPage extends StatelessWidget {
  final List<Meal> favoritesMeal;
  const FavoritesPage(this.favoritesMeal);

  @override
  Widget build(BuildContext context) {
    return favoritesMeal.isEmpty
        ? Center(
            child: Text('There is no Favorite Meals yet!! - You can add some :)'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealsItem(
                id: favoritesMeal[index].id,
                title: favoritesMeal[index].title,
                duration: favoritesMeal[index].duration,
                imageUrl: favoritesMeal[index].imageUrl,
                complexity: favoritesMeal[index].complexity,
                affordability: favoritesMeal[index].affordability,
              );
            },
            itemCount: favoritesMeal.length,
          );
  }
}
