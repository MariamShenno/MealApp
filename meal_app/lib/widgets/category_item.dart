
import'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategorgyItem extends StatelessWidget {


  final String id;
  final String title;
  final Color color;

 CategorgyItem(this.id, this.title, this.color);

 void selectCategory (BuildContext ctx){
  Navigator.of(ctx).pushNamed(CategoryMealsScreen.routeName,
  arguments: {
    'id': id,
    'title': title,
  },
  );
 }

  

  @override
  Widget build(BuildContext context) {
    //يفيدني يحتوي على on tap
    return InkWell(
      onTap: () => selectCategory (context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child:Container(
        padding: EdgeInsets.all(15),
        child: Text(title, style: Theme.of(context).textTheme.bodyLarge,),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
              ],
            begin: Alignment.topLeft ,
            end:  Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ) ,
      ),
    ) ;
  }
}