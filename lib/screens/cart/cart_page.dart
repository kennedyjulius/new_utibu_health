// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/common/widgets/Colors.dart';
import 'package:new_utibu_health_app/common/widgets/app_icon.dart';
import 'package:new_utibu_health_app/models/products_modal.dart';
import 'package:new_utibu_health_app/screens/other_screens/homescreen.dart';


class CartPage extends StatelessWidget {
  final int productId;
  final ProductModel productModel;
  
  const CartPage(
      {Key? key, 
      required this.productId, 
      required this.productModel,
       
      
      })
      : super(key: key);

  //final List<ProductModel> cartList[];
  int get quantity => quantity;
  
  int get inCartItems => inCartItems + quantity;
  
  get productQuantity => productQuantity;
  
  get productPrice => productPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: Colors.black,
                      iconsize: 24,
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Get.toNamed(RouteHelper.getInitial());
                      Get.to(HomeScreen());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconsize: 24,
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      //Get.to(CartPage());
                    },
                    child: AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconsize: 24,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            top: 100,
            left: 20,
            right: 20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: 3, // Example item count, replace with actual count
                itemBuilder: (context, index) {
                  return _buildCartItem(context, index);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                      "Kshs ${productQuantity * productPrice}"), // Example total amount, replace with actual value
                  SizedBox(width: 5),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Perform checkout action
                // Here you can update the list view builder with quantity and total price
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mainColor,
                ),
                child: Text(
                  'Check out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index) {
    // Replace this with your actual cart item widget
    return Container(
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.only(bottom: 10),
      color: Colors.grey,
      child: Text("Item $index"), // Example showing item name
    );
  }
}
