import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/models/food_model.dart';

class ProductsItemsDisplay extends StatelessWidget {
  final FoodModel foodModel;
  const ProductsItemsDisplay({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: 200,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.03),
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
        ),
        Container(
          width: size.width * 0.5,
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: foodModel.imageCard,
                child: Image.asset(
                  foodModel.imageCard,
                  height: 100,
                  width: 120,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                foodModel.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                foodModel.specialItems,
                style: TextStyle(
                  letterSpacing: 1.1,
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              RichText(
                text: TextSpan(
                  text: '\$ ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: red,
                  ),
                  children: [
                    TextSpan(
                      text: '${foodModel.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
