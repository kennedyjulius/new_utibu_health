
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/screens/authentication/login_screen.dart';
import 'package:new_utibu_health_app/screens/other_screens/homescreen.dart';


class AuthController extends GetxController {
  static AuthController instance = Get.find();
 late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  void register(String username, String email, String password) async {
    if (username.isEmpty) {
      Get.snackbar(
        "Empty Field",
        "Please enter username  ",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }
    if (email.isEmpty) {
      Get.snackbar(
        "Error: Empty Field",
        "Please enter email",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }
    if (password.isEmpty) {
      Get.snackbar(
        "Error: Empty Field",
        "Please enter password",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Registering...');

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(username);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({'username': username});

      EasyLoading.dismiss();

      Get.snackbar(
        "Registered",
        "You have successfully registered",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Registration successful',
          style: TextStyle(color: Colors.white),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      Get.offAll( HomeScreen());
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Account creation failed',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void login(String email, String password) async {
    if (email.isEmpty) {
      Get.snackbar(
        "Error: Empty Field",
        "Please enter email",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }
    if (password.isEmpty) {
      Get.snackbar(
        "Error: Empty Field",
        "Please enter password",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Authenticating...');

      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      EasyLoading.dismiss();

      Get.snackbar(
        "Authenticated",
        "You have successfully logged in",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Login successful',
          style: TextStyle(color: Colors.white),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));

      Get.off( HomeScreen());
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Login Failed",
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Login failed',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
  }

  // Function to reset the user's password
  void resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar(
        "Empty Field",
        "Please enter email",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error: Empty field',
          style: TextStyle(color: Colors.white),
        ),
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Sending reset email...');

      await auth.sendPasswordResetEmail(email: email);

      EasyLoading.dismiss();

      Get.snackbar(
        "Password Reset Email Sent",
        "Check your email to reset your password",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Success',
          style: TextStyle(color: Colors.white),
        ),
      );

      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(LoginScreen());
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Password Reset Failed",
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          'Error',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
