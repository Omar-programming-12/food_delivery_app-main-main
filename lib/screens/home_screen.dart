import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';
import 'package:food_delivery_app/models/categories_model.dart';
import 'package:food_delivery_app/models/food_model.dart';
import 'package:food_delivery_app/screens/view_all_screen.dart';
import 'package:food_delivery_app/widgets/custom_app_bar.dart';
import 'package:food_delivery_app/screens/food_details_screen.dart';
import 'package:food_delivery_app/widgets/custom_category_item.dart';
import 'package:food_delivery_app/widgets/products_items_display.dart';

class HomeScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  const HomeScreen({super.key, required this.categories});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Burger';
  List<FoodModel> myFoodModel = [];
  List<CategoryModel> categories = [
    CategoryModel(
      image: 'assets/food-delivery/burger.png',
      name: 'Burger',
      isSelected: true,
    ),
    CategoryModel(
      image: 'assets/food-delivery/pizza.png',
      name: 'Pizza',
      isSelected: false,
    ),
    CategoryModel(
      image: 'assets/food-delivery/cup cake.png',
      name: 'Cup Cake',
      isSelected: false,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _filterFood();
  }

  void _filterFood() {
    myFoodModel = foodProduct
        .where((food) =>
            food.category.toLowerCase() == selectedCategory.toLowerCase())
        .toList();
  }

  void onCategoryChange(String categoryName) {
    setState(() {
      selectedCategory = categoryName;
      _filterFood();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: imageBackground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.only(top: 25, right: 25, left: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                        text: 'The Fastest In Delivery',
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: ' Food',
                                        style: TextStyle(
                                            color: Colors.deepOrange)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: red,
                                  height: 35,
                                  minWidth: 90,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Text(
                                    'Order Now',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset('assets/food-delivery/courier.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text('Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: black)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            CustomCategoryItem(
              categories: categories,
              onCategorySelected: onCategoryChange,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Now',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewAllScreen(
                                  foodList: foodProduct,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'View All',
                            style: TextStyle(color: orange, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: orange,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: List.generate(
                  myFoodModel.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: index == myFoodModel.length - 1 ? 25 : 0,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(seconds: 1),
                          pageBuilder: (_, __, ___) => FoodDetailsScreen(
                            product: myFoodModel[index],
                          ),
                        ),
                      ),
                      child: ProductsItemsDisplay(
                        foodModel: myFoodModel[index],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 🏠 أيقونة البيت + Dot صغيرة
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.home_filled,
                  color: red,
                  size: 30,
                ),
                const SizedBox(height: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: red,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            // ❤️ أيقونة القلب
            const Icon(
              Icons.favorite_outline_rounded,
              color: grey,
              size: 30,
            ),

            // 🔍 زرار البحث الكبير
            Container(
              padding: const EdgeInsets.all(17),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: red,
              ),
              child: const Icon(
                Icons.search,
                size: 35,
                color: Colors.white,
              ),
            ),

            // 🔔 أيقونة الجرس
            const Icon(
              Icons.notifications_outlined,
              color: grey,
              size: 30,
            ),

            // 🛒 أيقونة الكارت + Badge
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: grey,
                  size: 30,
                ),
                Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      "4",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
