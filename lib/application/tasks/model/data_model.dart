import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DataModel{
  final String title;
  final String description;
  final DateTime? time;
  String? documentId;

  DataModel({ this.documentId, required this.title,required this.description,this.time});

  //methode to convert firebase object to dart map
factory DataModel.fromJson(Map<String,dynamic> json, {String? docId}){
  return DataModel(documentId: docId,
      title: json['title']??"",
      description: json['description']??"",
  time:(json['time'] as Timestamp?)?.toDate());
}
//convert data models to json
Map<String,dynamic> toJson(){
  return {
    'title':title,
    'description':description,
    'time':time ??FieldValue.serverTimestamp(),
  };
}

}