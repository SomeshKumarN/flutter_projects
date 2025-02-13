import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';

class MealsWidget extends StatelessWidget {
  const MealsWidget({
    super.key,
    required this.meal,
  });
  final Meal meal;

  void _onSelectingMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
              meal: meal,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          _onSelectingMeal(context, meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: const Color.fromARGB(146, 21, 23, 23),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule, label: '${meal.duration}min'),
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.work, label: meal.complexity.name),
                        SizedBox(
                          width: 10,
                        ),
                        MealItemTrait(
                            icon: Icons.attach_money,
                            label: meal.affordability.name),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
