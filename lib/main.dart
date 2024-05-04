import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:new_utibu_health_app/controllers/auth_controller_firebase.dart';
import 'package:new_utibu_health_app/controllers/payment_controller.dart';
import 'package:new_utibu_health_app/firebase_data_services/firebase_service.dart';
import 'package:new_utibu_health_app/firebase_options.dart';
import 'package:new_utibu_health_app/screens/authentication/login_screen.dart';
import 'package:new_utibu_health_app/screens/authentication/signup_screen.dart';
import 'package:new_utibu_health_app/screens/onboarding_screens/onboardingscreen.dart';
import 'package:new_utibu_health_app/screens/onboarding_screens/splash_page.dart';
import 'package:new_utibu_health_app/screens/other_screens/homescreen.dart';
import 'package:new_utibu_health_app/screens/payments/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  Get.lazyPut(() => PaymentController());
  WidgetsFlutterBinding.ensureInitialized();
  MpesaFlutterPlugin.setConsumerKey(
      'VoWX6ucu9KjlLJG0wTfqAh1A6GgEF2SI6VJWHf3L61z1cCGk');
  MpesaFlutterPlugin.setConsumerSecret(
      'lHmOrXbih8L5qbsIi2NhLvvOATGxctILqUxUJM6sPCJpSnVqe1sK6fnGOkWRunD3');
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MainhomePage(),
      // initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => SplashScreen()),
      //   GetPage(name: '/login', page: () => LoginScreen()),
      //   GetPage(name: '/signup', page: () => SignupScreen()),
      //   GetPage(name: '/home', page: () => HomeScreen()),
      // ],
      // Bind the UserDataService to the GetMaterialApp
      // initialBinding: BindingsBuilder(() {
      //   Get.lazyPut<UserDataService>(() => UserDataService());
      // }),
    );
  }
}
