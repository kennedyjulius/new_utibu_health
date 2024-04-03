// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/common/widgets/custom_downward_arrow.dart';
import 'package:new_utibu_health_app/common/widgets/custom_formfield2.dart';
import 'package:new_utibu_health_app/common/widgets/custom_textwidget.dart';
import 'package:new_utibu_health_app/common/widgets/icon_and_text_widget.dart';
import 'package:new_utibu_health_app/models/products_modal.dart';
import 'package:new_utibu_health_app/screens/cart/cart_page.dart';
import 'package:new_utibu_health_app/screens/other_screens/account_screen.dart';
import 'package:new_utibu_health_app/screens/other_screens/address_screen.dart';
import 'package:new_utibu_health_app/screens/other_screens/chat_screen.dart';
import 'package:new_utibu_health_app/screens/other_screens/notificationList.dart';
import 'package:new_utibu_health_app/screens/other_screens/product_detail_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ProductModel>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = fetchProducts();
  }

  void _handleBuyButtonClick(ProductModel product) {
    // Navigate to the ProductsDetails screen with the selected product
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductsDetails(
          productId: int.parse(product.id), // Assuming product.id is a String
          productModel: product, // Pass the selected product
        ),
      ),
    );
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Products').get();
      return snapshot.docs.map((doc) {
        final data = (doc.data() as Map<String, dynamic>);
        final image = data['image'] ?? '';
        final id = data['productId']?.toString() ?? '';
        final name = data['name'] ?? '';
        final priceString = data['price']?.toString() ?? '';
        final description = data['description'] ?? '';
        final quantity = data['quantity']
            ?.toInt(); // Convert to int if present, otherwise null
        final location = data['location'];

        // Validate required fields
        if (image.isEmpty ||
            id.isEmpty ||
            name.isEmpty ||
            priceString.isEmpty ||
            description.isEmpty) {
          throw Exception('Invalid product data: $data');
        }

        final price = double.parse(priceString);

        return ProductModel(
          image: image,
          id: id,
          name: name,
          price: price,
          description: description,
          quantity: quantity,
          location: location,
        );
      }).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  final TextEditingController _searchController = TextEditingController();

  final PageController _pageController = PageController();

  // final List<String> images = [
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg",
  //   "assets/profile.jpg"
  // ];

  final List<Widget> myItems = [
   
    Image.asset("assets/advert.png"),
Image.asset("assets/advert2.png"),
Image.asset("assets/advert3.png"),
Image.asset("assets/pharmacy.png"),
Image.asset("assets/advert5.png"),
//Image.asset("assets/newadvert3.jpg"),
  ];

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 20,
          icon: Icon(
            Icons.menu,
            color: Colors.indigo,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Utibu Health',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(UserProfile());
            },
            icon: Icon(Icons.person),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Get.to(ChatScreen());
            },
            icon: Icon(Icons.message),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {
              // Get.to(CartPage(productId: productId, productName: productName, productPrice: productPrice, productQuantity: productQuantity, productImage: productImage))
              
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Get.to(NotificationList());
            },
            icon: Icon(Icons.notification_add),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            InkWell(
              onTap: () => AddressScreen(),
              child: Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.pinkAccent,
                ),
                child: Center(
                    child: Text(
                  "Add Delivery Location",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomFormField2(text1: "Search here", labelText: "search"),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextWidget(
                text: "New Arrivals.",
                size: 18,
                color: Colors.amber.shade200,
                fontWeight: FontWeight.bold),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  width: double.maxFinite -40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade50),
                  ),
                  child: CarouselSlider(
                      items: myItems,
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 150,
                        viewportFraction: 0.8,
                        animateToClosest: true,
                        pageSnapping: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayInterval: Duration(seconds: 4),
                        enlargeCenterPage: true,
                        //aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            myCurrentIndex = index;
                          });
                        },
                      )),
                ),
                SizedBox(
                  height: 8,
                ),
                AnimatedSmoothIndicator(
                  activeIndex: myCurrentIndex,
                  count: myItems.length,
                  effect: WormEffect(
                      dotHeight: 8,
                      dotWidth: 10,
                      spacing: 5,
                      dotColor: Colors.grey.shade200,
                      activeDotColor: Colors.blue.shade300,
                      paintStyle: PaintingStyle.fill),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWidget(
                    text: "New Offers",
                    size: 14,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "view all",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.pink.shade100),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: FutureBuilder<List<ProductModel>>(
                  future: productsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<ProductModel>? products = snapshot.data;
                      return SingleChildScrollView(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: products!.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            ProductModel product = products[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsDetails(
                                      productId: int.parse(product.id),
                                      productModel: product,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Image container
                                      SizedBox(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            product.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      // Information container
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Price: Kshs ${product.price}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.greenAccent
                                                          .shade700),
                                                  child: IconAndTextWidget(
                                                    icon: Icons.shopping_cart,
                                                    text: 'Buy',
                                                    iconColor: Colors
                                                        .redAccent.shade400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Floating discount banner
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: DownwardArrowContainer(
                                          width: 40,
                                          height: 60,
                                          color: Colors.red,
                                          text: '20% OFF',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here

          Get.defaultDialog(
            textConfirm: "Yes",
            textCancel: "No",
            backgroundColor: Colors.pink.shade50,
            barrierDismissible: false,
            cancelTextColor: Colors.black54,
            buttonColor: Colors.blue.shade100,
            middleText: "Are you sure you want to Chat with our ChatBot ?",
            middleTextStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w100,
              color: Colors.brown.shade100,
            ),
            onConfirm: () => Get.to(ChatScreen()),
            //onCancel: () => ,
          );
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
