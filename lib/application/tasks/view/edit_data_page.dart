
import 'package:firbace/application/tasks/controller/data_controller.dart';
import 'package:firbace/application/tasks/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditDataPage extends StatelessWidget {
   EditDataPage({super.key,required this.title,required this.description,required this.item});
  String title;
  String description;
  DataModel item;



  @override
  Widget build(BuildContext context) {
    final editProvider=Provider.of<DataController>(context);
    TextEditingController title2=TextEditingController(text: item.title);
    TextEditingController description2=TextEditingController(text: item.description);
    return AlertDialog(
      backgroundColor: Colors.white,
      title:const Text('Edit'),
      actions: [
        SizedBox(
          height: 50,
          child: TextField(
            decoration:const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller:title2 ,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: TextField(
            maxLines: 4,
            decoration:const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: description2,
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(onPressed: () {
          final task = DataModel(title: title2.text, description: description2.text);
          editProvider.editData(task, item.documentId!);
          Navigator.pop(context);

        },
            style:const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)
            ),
            child:const Text('Update',style: TextStyle(color: Colors.white,fontSize: 18),)),
      ],
    );
  }
}
