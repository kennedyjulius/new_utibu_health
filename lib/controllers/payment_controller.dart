import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

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

  // Method for starting checkout
  Future<void> startCheckout({required String userPhone, required double amount}) async {
    String userPhone = _phoneController.text.trim();
    double amount = double.parse(_amountController.text.trim()).toDouble();

    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
        // using this as a sunbox
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: userPhone,
        partyB: "174379",
        callBackURL: Uri.parse(
            'https://us-central1-miranda-e21e3.cloudfunctions.net/mpesaPostRequest'),
        accountReference: "KennedyCrypto254 Shop",
        phoneNumber: '254$userPhone',
        baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
        transactionDesc: "purchase",
        passKey:
            'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c91',
      );

      print("TRANSACTION RESULT: $transactionInitialisation");

      DocumentReference<Map<String, dynamic>> MpesaData = FirebaseFirestore
          .instance
          .collection('mpesaData')
          .doc(transactionInitialisation['MerchantRequestID']);

      await MpesaData.set({
        'ResponceCode': transactionInitialisation['ResponseCode'],
        'MerchantRequestID': transactionInitialisation['MerchantRequestID'],
        'CheckoutRequestID': transactionInitialisation['CheckoutRequestID'],
        'ResponseDescription': transactionInitialisation['ResponseDescription'],
        'CustomerMessage': transactionInitialisation['CustomerMessage'],
      }).then(
        (value) => print("Payment processing Added"),
      ).catchError(
        (error) => print("Failed to add Payment processing: $error"),
      );
    } catch (e) {
      print("CAUGHT EXCEPTION: $e");
    }
  }
}
