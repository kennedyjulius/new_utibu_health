import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/common/widgets/Colors.dart';
import 'package:new_utibu_health_app/common/widgets/app_icon.dart';
import 'package:new_utibu_health_app/common/widgets/big_text.dart';
import 'package:new_utibu_health_app/common/widgets/expandable_text_widget.dart';
import 'package:new_utibu_health_app/models/products_modal.dart';
import 'package:new_utibu_health_app/screens/cart/cart_page.dart';

class ProductsDetails extends StatefulWidget {
  final int productId;
  final ProductModel productModel;

  const ProductsDetails({
    Key? key,
    required this.productId,
    required this.productModel,
  }) : super(key: key);

  @override
  _ProductsDetailsState createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  late DocumentReference _quantityRef;
  late int _quantity;
  late double _totalPrice;

  @override
  void initState() {
    super.initState();
    _quantity = widget.productModel.quantity ?? 0;
    _quantityRef = FirebaseFirestore.instance
        .collection('Products')
        .doc(widget.productId.toString())
        .collection('quantity')
        .doc('quantity');

    _totalPrice = widget.productModel.price * _quantity;

    // Initialize product details
    initProduct(widget.productModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.clear,
                    iconsize: 24,
                  ),
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Handle cart tap
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => CartPage(
                            productId: widget.productId,
                            productModel: widget.productModel,
                          ),
                        ));
                      },
                      child: AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconsize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: BigText(
                  size: 26,
                  text: widget.productModel.name,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.purple,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.productModel.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: BigText(
                      text: 'Description',
                      size: 20,
                      color: Colors.pink.shade100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ExpandableTextWidget(text: widget.productModel.description),
                  SizedBox(height: 20),
                  BigText(
                    text: 'Each Item Price: Ksh ${widget.productModel.price}',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),
                  _buildQuantityWidget(),
                  SizedBox(
                    height: 30,
                  ),
                  BigText(
                    text: 'Total Price to Pay : Ksh $_totalPrice',
                    size: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _removeQuantity();
                  },
                  child: AppIcon(
                    iconsize: 24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove,
                  ),
                ),
                BigText(
                  text: 'Ksh $_totalPrice',
                  color: AppColors.mainBlackColor,
                  size: 26,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    // Add the item to cart when tapped
                    addItemToCart();
                  },
                  child: AppIcon(
                    iconsize: 24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
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
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle adding to cart
                    addItemToCart();
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.mainColor,
                    ),
                    child: BigText(
                      text: 'Ksh $_totalPrice',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityWidget() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _removeQuantity();
          },
          child: AppIcon(
            iconsize: 24,
            iconColor: Colors.black,
            icon: Icons.remove,
          ),
        ),
        SizedBox(width: 10),
        BigText(
          text: '$_quantity',
          size: 18,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            _addQuantity();
          },
          child: AppIcon(
            iconsize: 24,
            iconColor: Colors.black,
            icon: Icons.add,
          ),
        ),
      ],
    );
  }

  void _removeQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
        _totalPrice = widget.productModel.price * _quantity;
      });
      _updateQuantityInFirebase();
    } else {
      if (_quantity < 0) {
        Get.snackbar("Alert Message",
            "The item Quantity cannot be less than 0 , kindly contact the admin for further support");
      }
      return;
    }
  }

  void _addQuantity() {
    setState(() {
      _quantity++;
      _totalPrice = widget.productModel.price * _quantity;
    });
    _updateQuantityInFirebase();
  }

  void addItemToCart() {
    ProductModel product = widget.productModel;
    if (_quantity > 0) {
      // Add the item to cart
      addItem(product);
      // Reset quantity to 0
      _quantity = 0;
      // Navigate to cart page
      Get.to(() => CartPage(
            productId: widget.productId,
            productModel: product,
          ));
    } else {
      // Show error message that quantity must be greater than 0
      Get.snackbar("Error", "Please select quantity before adding to cart");
    }
  }

  void addItem(ProductModel product) {
    // Implement logic to add item to cart
  }

  void initProduct(ProductModel product) {
    // Implement initialization logic for the product
  }

  int checkQuantity(int quantity) {
    // Implement logic to check quantity before adding to cart
    return quantity;
  }

  void _updateQuantityInFirebase() {
    _quantityRef.update({'quantity': _quantity});
  }
}
