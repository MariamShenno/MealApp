import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

 List<Meal> _availableMeals = DUMMY_MEALS;
List<Meal> _favoriteMeals = [];

void _setFilters(Map<String, bool> filterData) {
  setState(() {
    _filters = filterData;

    _availableMeals = DUMMY_MEALS.where((meal) {
      if (_filters['gluten'] == true && meal.isGlutenFree == false) {
        return false;
      }
      if (_filters['lactose'] == true && meal.isLactoseFree == false) {
        return false;
      }
      if (_filters['vegan'] == true && meal.isVegan == false) {
        return false;
      }
      if (_filters['vegetarian'] == true && meal.isVegetarian == false) {
        return false;
      }
      return true;
    }).toList();
  });
}

  void _toggleFavorite(String mealId) {
    //تبحث عن تحقق شرط معين وكل عنصر يوافق الشرط ترجع الاندكس التابع للعنصر

    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

bool _isMealFavorite( String id){

  return _favoriteMeals.any((meal) => meal.id == id);
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),

      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal APP"),
      ),
      body: null,
    );
  }
}
