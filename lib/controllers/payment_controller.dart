import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  final CollectionReference customers =
      FirebaseFirestore.instance.collection("customers");
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> addCustomer() async {
    try {
      await customers.add({
        'phonenumber': _phoneController.text.trim(),
        'amount': _amountController.text.trim(),
      });
      Get.snackbar("Success", "Customer Created Successfully");
    } catch (error) {
      print("An error occurred: $error");
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
