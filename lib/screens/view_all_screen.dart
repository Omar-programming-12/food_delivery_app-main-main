import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/screens/food_details_screen.dart';
import 'package:food_delivery_app/widgets/products_items_display.dart';

class ViewAllScreen extends StatefulWidget {
  final List<FoodModel> foodList;

  const ViewAllScreen({super.key, required this.foodList});

  @override
  State<ViewAllScreen> createState() => _ViewAllScreenState();
}

class _ViewAllScreenState extends State<ViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // علشان لو الكيبورد طلع ميبقاش في Overflow
      appBar: View_All_appbar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GridView.builder(
            physics:
                const BouncingScrollPhysics(), // حركة Scroll ناعمة زي الموبايل
            itemCount: widget.foodList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // عمودين
              crossAxisSpacing: 15, // مسافة بين الأعمدة
              mainAxisSpacing: 15, // مسافة بين الصفوف
              childAspectRatio: 0.75, // نسبة العرض للطول
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    pageBuilder: (_, __, ___) => FoodDetailsScreen(
                      product: widget.foodList[index],
                    ),
                  ),
                ),
                child: ProductsItemsDisplay(
                  foodModel: widget.foodList[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  AppBar View_All_appbar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leadingWidth: 80,
      forceMaterialTransparency: true,
      actions: [
        const SizedBox(width: 27),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_back_ios_new,
                color: Colors.black, size: 18),
          ),
        ),
        const Spacer(),
        Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const Icon(Icons.more_horiz_rounded,
              color: Colors.black, size: 18),
        ),
        const SizedBox(width: 27),
      ],
    );
  }
}
