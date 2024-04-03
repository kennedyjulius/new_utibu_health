// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:new_utibu_health_app/common/utils/colors.dart';
import 'package:new_utibu_health_app/common/widgets/custom_button.dart';
import 'package:new_utibu_health_app/common/widgets/custom_textwidget.dart';
import 'package:new_utibu_health_app/common/widgets/myform_field.dart';
import 'package:new_utibu_health_app/controllers/auth_controller_firebase.dart';



class ResetPassword extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
 

 

  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsContants.textColor3,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 160,),
              CustomTextWidget(
                  text: " Reset your password ",
                  size: 22,
                  color: ColorsContants.textColor4,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomTextWidget(
                        text: "Reset password",
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

              
              CustomButton(
                text: "Reset Password",
                ontap: (){
                AuthController.instance.resetPassword(emailcontroller.text.trim());
              },
              ),
              SizedBox(
                height: 10,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
