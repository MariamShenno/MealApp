import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category_meals';

  final List<Meal> avaliableMeals;
  CategoryMealsScreen(this.avaliableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayMeals;

  @override
  void didChangeDependencies() {
    //تتنفذ قبل استخدام الويدجت نفس وقت تنفيذ اينت ستيت
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title']!;

    // ... بدل من استخدام دامي ميلز بشكل مباشر أقوم بعمل فلترة واخزنه في CATEGORYMEALS
    // Using Where

    displayMeals = widget.avaliableMeals.where((meal) {
      return meal.categories!.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
//  عندما استدعيها يقوم بحذف العنصر الذي يطابق الآي دي
    //تفيد في فلاتر سكرين
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        //بناء العناصر
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        //عدد العناصر
        itemCount: displayMeals.length,
      ),
    );
  }
}
