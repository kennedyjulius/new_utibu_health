// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:new_utibu_health_app/screens/authentication/login_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';




// class OnboardingScreen extends StatelessWidget {
//   //final bool showHome;

//   const OnboardingScreen({Key? key, 
//   //required this.showHome
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: IntroductionScreen(
//           allowImplicitScrolling: true,
//           pages: [
//             commonPageViewModel(
//               "Journey of Love and Care",
//               "Welcome to the MCH clinic, where every mother's journey is celebrated and supported. Together, we embark on a path filled with love, care, and endless possibilities for your child's well-being",
//               "assets/pregnantlady.png",
//             ),
//             commonPageViewModel(
//               "Strength in Motherhood",
//               "In the embrace of our MCH clinic, mothers discover the strength within themselves to nurture and protect their children. Here, we honor the resilience and dedication of every mother",
//               "assets/mothersday.png",
//             ),
//             commonPageViewModel(
//               "Building Healthier Communities",
//               "At MCH clinics, we're not just building healthier families – we're building stronger communities. Join us as we unite mothers in a shared mission to create brighter, healthier futures for all",
//               "assets/babyshower.png",
//             ),
        
//               commonPageViewModel(
//               "Building Healthier Communities",
//               "At MCH clinics, we're not just building healthier families – we're building stronger communities. Join us as we unite mothers in a shared mission to create brighter, healthier futures for all",
//               "assets/babyequipments.png",
//             ),
//           ],
//           dotsDecorator: DotsDecorator(
//             size: Size(15, 10),
//             activeColor: Colors.purple,
//             activeSize: Size(10, 20),
//             activeShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           showDoneButton: true,
//           done: Text(
//             "Done",
//             style: TextStyle(fontSize: 20),
//           ),
//           showNextButton: true,
//           next: Text("Next", style: TextStyle(fontSize: 20),),
//           showSkipButton: true,
//           skip: Text(
//             "Skip",
//             style: TextStyle(fontSize: 20),
//           ),
//           onDone: () async {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) => LoginScreen(),
//             ));
//             final prefs = await SharedPreferences.getInstance();
//             prefs.setBool('showHome', true);
//           },
//           onSkip: () {
//             Navigator.of(context).pushReplacement(MaterialPageRoute(
//               builder: (context) => LoginScreen(),
//             ));
//           },
//         ),
//       ),
//     );
//   }

//   PageViewModel commonPageViewModel(
//       String title, String bodyText, String image) {
//     return PageViewModel(
//       title: title,
//       body: bodyText,
//       image: Image.asset(image),
//       decoration: PageDecoration(
//           pageColor: Colors.white12,
//           titleTextStyle: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//           bodyTextStyle: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w200,
//             color: Colors.black54,
//           )),
//     );
//   }
// }
