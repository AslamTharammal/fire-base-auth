
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/authendication/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../tasks/view/home_screen.dart';
import '../view/login/login_page.dart';

class AuthController extends ChangeNotifier{
  final FirebaseAuth auth =FirebaseAuth.instance;
  final FirebaseFirestore db=FirebaseFirestore.instance;
  bool? success;

  Future<void>createAccount(
      {required String userEmail,
        required String userPassword,
        required String phoneNumber,
        required String firstName,
        required String secondName})async{
    final authPrefs = await SharedPreferences.getInstance();
    try{
      final userCreds =await auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword,);
      final userId=userCreds.user!.uid;
      UserModel userModel=UserModel(firstName: firstName, email: userEmail, id: userId, phoneNumber: phoneNumber, secondName: secondName);

      await db.collection("tasks").doc(userId).set(userModel.toJson());
      if(userId!=null){
        await authPrefs.setString('id', userId);
      }else {
        authPrefs.clear();
        success=false;
      }
      print('User Created with User Id $userId');
      notifyListeners();
    }catch(e){
      print(e);
    }
  }
  Future<void>loginAccount(context,String userEmail, String userPassword)async{
    final authPrefs=await SharedPreferences.getInstance();
    try{
      final userCreds=await auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      final userId=userCreds.user!.uid;
      print('User Loged in using $userId');

      if(userId!=null){
        await authPrefs.setString('id', userId);
        success=true;
        notifyListeners();
      }else {
        authPrefs.clear();
        success=false;
      };

    }catch(e){
      print(e);

    }
  }
  Future<void> logOut (BuildContext context)async{
    final authLogOut=await SharedPreferences.getInstance();
    
    await authLogOut.remove('id');
    notifyListeners();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
  }



}