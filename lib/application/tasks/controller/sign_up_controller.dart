import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/authendication/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignUpController extends ChangeNotifier {
final FirebaseFirestore db = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

Stream<UserModel> fetchUserData() {
  final userId = auth.currentUser!.uid;
  return FirebaseFirestore.instance
      .collection("tasks")
      .doc(userId)
      .snapshots()
      .map((snapshot) => UserModel.fromJson(snapshot.data() ?? {}));
}

Future<bool> checkIfEmailExists(String email) async {
  try {
    List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);
    notifyListeners();
    if (signInMethods.isNotEmpty) {
      print("Email exists: $signInMethods");
      return true;
    } else {
      print("Email does not exist");
      return false;
    }
  } catch (e) {
    print("Error checking email: $e");
    return false;
  }
}

 Future<bool> checkEmail(String email) async{
  bool emailExists =await checkIfEmailExists(email);
  notifyListeners();
  if(emailExists ){
    return true;
  }else {
    return false;
  }
}
}