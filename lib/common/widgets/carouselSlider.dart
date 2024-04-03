import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:new_utibu_health_app/screens/other_screens/homescreen.dart';



class Carouselslider extends StatelessWidget {
  final List<String> bannerCards = [
    'assets/profile.jpg', // Example image path
    'assets/star.gif',
    'assets/fingerprint.gif' // Example image path
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: bannerCards.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            height: 140,
            margin: EdgeInsets.only(left: 0, right: 0, bottom: 20),
            padding: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: GestureDetector(
              onTap: () {
                index == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return BottomSheet(
                            onClosing: () => HomeScreen(),
                            builder: (context) {
                              return Container(
                                height: 100,
                                width: 100,
                                color: Colors.amber,
                                child: Text("You clicked me"),
                              );
                            },
                          );
                        }),
                      )
                    : Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Text("You Clicked ME");
                        }),
                      );
              },
              child: Stack(
                children: [
                  Image.asset(
                    bannerCards[index],
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7, right: 5),
                    alignment: Alignment.topRight,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Check Disease', // You can customize this text
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.lightBlue[900],
                            )),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.lightBlue[900],
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          scrollPhysics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
