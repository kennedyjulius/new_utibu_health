import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  get username => null;

  Future<void> initialize() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      // Check if user document exists in Firestore
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(user.uid).get();

      if (!snapshot.exists) {
        // User document does not exist, create new document
        await _firestore.collection('users').doc(user.uid).set({
          'username': user.displayName,
          // Add any additional user data here
        });
      }
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      // Fetch user data from Firestore
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').doc(user.uid).get();

      return snapshot;
    } else {
      throw Exception('User not logged in');
    }
  }
}
