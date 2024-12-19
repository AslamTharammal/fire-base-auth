import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/authendication/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/home_screen.dart';

class SignUpController extends ChangeNotifier {
final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
List mails=[];

Stream<UserModel> fetchUserData() {
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection("tasks")
      .doc(userId)
      .snapshots()
      .map((snapshot) => UserModel.fromJson(snapshot.data() ?? {}));
}
Future<bool> checkEmailExists(String email) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("tasks")
        .where("email", isEqualTo: email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      print("Email $email exists in the collection.");
      return true;
    } else {
      print("Email $email does not exist in the collection.");
      return false;
    }
  } catch (e) {
    print("Error checking email: $e");
    return false;
  }
}

void checkUserEmail(context,String userEmail) async {
  bool exists = await checkEmailExists(userEmail);
  if (exists==false) {
    print("This email is not registered.");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));;
  } else {
    print("This email is already registered.");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This email is already registered.")));
    return null;

  }
}

}