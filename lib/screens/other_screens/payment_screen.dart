// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:new_utibu_health_app/common/widgets/custom_textwidget.dart';
import 'package:new_utibu_health_app/common/widgets/myform_field.dart';

class PaymentScreen extends StatelessWidget {
  
  PaymentScreen({super.key});
  TextEditingController _amountController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextWidget(
              text: "Make Payment with us",
              size: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          SizedBox(
            height: 30,
          ),
          TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30,),
         TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
          SizedBox(height: 30),

          OutlinedButton(onPressed: () {
            
          }, child: Text("Pay", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pinkAccent),))

          
        ],
      ),
    );
  }
}
