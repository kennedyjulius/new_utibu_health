import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_utibu_health_app/controllers/payment_controller.dart';

class MainhomePage extends StatelessWidget {
  MainhomePage({Key? key});

  TextEditingController _phoneNumbercontroller = TextEditingController();
  TextEditingController _amountcontroller = TextEditingController();

  PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'MPESA FLUTTER',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumbercontroller,
                  decoration: const InputDecoration(
                    hintText: 'Enter your Phone Number',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  paymentController.addCustomer();
                  paymentController.startCheckout(
                    userPhone: _phoneNumbercontroller.text.trim(),
                    amount: double.parse(_amountcontroller.text.trim()).toDouble(),
                  );
                },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
