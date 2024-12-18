import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/authendication/model/user_model.dart';
import 'package:firbace/application/authendication/view/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/data_model.dart';

class ProfileEditController extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController name =TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController email=TextEditingController();

  bool editable=false;
  void editDatas(){
    // editable=true;
    // notifyListeners();
    if(editable==false){
      editable=true;
      notifyListeners();
    }else{
      editable=false;
      notifyListeners();
    }
  }
  Future<void> updateData(UserModel userModel,) async {
    final userId=auth.currentUser?.uid;
    try {
      await db.collection('tasks').doc(userId).update(userModel.toJson());
      notifyListeners();

      print('User updated successfully!');
    } catch (e) {
      print('Error updating user: $e');
    }
    notifyListeners();
    editable=false;
    notifyListeners();
  }
  Future<void>deleteUser({required context})async{
    try{
      final User? user=auth.currentUser;
      if(user!=null){
        await user.delete();
        notifyListeners();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage(),),(route) => false,);
        print("User account deleted successfully");
      }else {
        print("No user signed in");
      }
    }
    catch (error){
      print("Error deleting user: $error");
    }

  }
}