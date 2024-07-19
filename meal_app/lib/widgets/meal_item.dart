
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? imageUrl;
  final int? duration;
  final Complexity? complexity;
  final Affordability? affordability;
  



  const MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    
  });


  String get complexityText{
   switch(complexity){
     case Complexity.Simple: return 'Simple';
     case Complexity.Challenging: return ' Challenging'; 
     case Complexity.Hard: return 'Hard';
     default: return 'Unknown'; 
    
   }
  }


    String get affordabilityText{
   switch(affordability){
     case Affordability.Affordable: return 'Affordable'; 
     case Affordability.Pricey: return ' Pricey'; 
     case Affordability.Luxurious: return 'Luxurious'; 
     default: return 'Unknown';
    
   }
  }






  @override
  Widget build(BuildContext context) {

    void selectMeal(BuildContext ctx) {
       Navigator.of(context).pushNamed(MealDetailScreen.routeName,
       arguments: id,
       ).then((result) {
       // if(result !=null) removeItem(result);
       } 
       
       );

    }

    // ونستخدمها لأن عند الضغط على الوجبة تظهر مقادرير العمل و خطوات العمل
    return InkWell(
      onTap: () => selectMeal(context),

      // إظهار كل الويدج التي أريدها
      child: Card(

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        // محتويات الكارد
        child: Column(
          children: [
            Stack(
              children: [
                //تساعد على عمل القص لأن الصورة تكون فوق الكارد وتغطي عليه
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title!,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(width: 6),
                      Text("$duration min"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(width: 6),
                      Text("$complexityText"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(width: 6),
                      Text("$affordabilityText"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
