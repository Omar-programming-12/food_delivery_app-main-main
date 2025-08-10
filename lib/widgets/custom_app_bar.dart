import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants.dart';

AppBar CustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        // Points Icon
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/food-delivery/icon/dash.png'),
          ),
        ),
        const Spacer(),
        // Center Field
        Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,size: 18,color: red,),
              SizedBox(height: 5,),
              Text('Cairo , Egy',style: TextStyle(fontSize: 16, color: Colors.black),),
              SizedBox(height: 5,),
              Icon(Icons.keyboard_arrow_down_rounded,size: 18,color: orange,),
            ],
          ),
        ),
         // Man Icon 
         Padding(
           padding: const EdgeInsets.only(right: 35),
           child: Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset('assets/food-delivery/profile.png'),
                     ),
         )
      ],
    );
}