// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_utibu_health_app/common/utils/colors.dart';
import 'package:new_utibu_health_app/common/widgets/custom_button.dart';
import 'package:new_utibu_health_app/common/widgets/custom_textwidget.dart';
import 'package:new_utibu_health_app/common/widgets/myform_field.dart';
import 'package:new_utibu_health_app/controllers/auth_controller_firebase.dart';
import 'package:new_utibu_health_app/screens/authentication/reset%20password.dart';
import 'package:new_utibu_health_app/screens/authentication/signup_screen.dart';



class LoginScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool _obsecureText = true;

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 160,),
                CustomTextWidget(
                    text: "We missed you ",
                    size: 22,
                    color: ColorsContants.textColor3,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomTextWidget(
                          text: "Welcome back",
                          size: 17,
                          color: ColorsContants.textColorsubtitle,
                          fontWeight: FontWeight.bold),
                      SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset("assets/star.gif"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
            
               
                MyformField(
                  labelText: "email",
                  hintText: "email address",
                  controller: emailcontroller,
                  obscureText: false,
                  suffixIcon: IconButton(
                      onPressed: () {
                        emailcontroller.clear();
                      },
                      icon: Icon(Icons.clear)),
                  prefixIcon: Icon(Icons.email),
                ),
                SizedBox(
                  height: 10,
                ),
            
                //password field
                MyformField(
                  labelText: "password",
                  hintText: "Enter Password",
                  controller: passwordcontroller,
                  obscureText: _obsecureText,
                  suffixIcon: IconButton(
                      onPressed: () {
                        _obsecureText = !_obsecureText;
                      },
                      icon: Icon(_obsecureText
                          ? Icons.visibility_off
                          : Icons.visibility)),
                  prefixIcon: Icon(Icons.password),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(ResetPassword());
                  },
                  child: Text("Forgot Password? ..."),
                ),
            
                // TextButton(onPressed: () {
            
                // }, child: Text("Forgot Password? ...")
                // ),
                // SizedBox(height: 10,),
            
                //custom button
                CustomButton(
                  text: "Login",
                  ontap: (){
                  AuthController.instance.login(emailcontroller.text.trim(), passwordcontroller.text.trim());
                },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomTextWidget(
                        text: "Don't have account yet ?",
                        size: 14,
                        color: ColorsContants.textColorsubtitle,
                        fontWeight: FontWeight.w200),
                    SizedBox(
                      width: 2,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
                        },
                        child: Text("Register here...")
                        ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
