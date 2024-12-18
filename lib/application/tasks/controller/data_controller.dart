import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/tasks/model/data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authendication/model/user_model.dart';

class DataController extends ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController title=TextEditingController();
  TextEditingController description=TextEditingController();

  // Save Data
  Future<void> saveData(DataModel dataModel) async {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      print('no user');
      return;
    }
    try {
      await db
          .collection('tasks')
          .doc(userId)
          .collection('entries')
          .add(dataModel.toJson());
    } catch (e) {
      print(e);
    }
  }

//method to fetch data

  Stream<List<DataModel>> getData() {
    final userId = auth.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }
    return db
        .collection('tasks')
        .doc(userId)
        .collection('entries')
        .orderBy('time', descending: true)
        .snapshots()
        .map((query) => query.docs
            .map((doc) => DataModel.fromJson(doc.data() as Map<String, dynamic>,docId: doc.id))
            .toList());
  }

  delete(String docId)async{
   final userId=auth.currentUser?.uid;
   await db.collection("tasks").doc(userId).collection('entries').doc(docId).delete();
   notifyListeners();
  }

  Future<void> editData(DataModel dataModel, String docid) async {
    final userId=auth.currentUser?.uid;
    try {
      await db.collection('tasks').doc(userId).collection('entries').doc(docid).update(dataModel.toJson());
      notifyListeners();

      print('User updated successfully!');
    } catch (e) {
      print('Error updating user: $e');
    }
    notifyListeners();
  }
}
