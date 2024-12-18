import 'package:firbace/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});


   setInt()async{
     final prefs = await SharedPreferences.getInstance();
     await prefs.setInt('number', 120);
     print("successfull");
   }

   getInt()async{
     final prefs = await SharedPreferences.getInstance();
     int? number = await prefs.getInt('number');
     print(number);
   }

   storeString()async{
     final prefs = await SharedPreferences.getInstance();
     await prefs.setString('name', 'Aslam');
     print("name stored");
   }

   fetchString() async{
     final prefs = await SharedPreferences.getInstance();
     String? myName = await prefs.getString('name');
     print(myName);
   }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sample Page'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {
                    setInt();
                }, child: Text('Set int')),
                TextButton(onPressed: () {
                     getInt();
                }, child: Text('Get int')),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                TextButton(onPressed: () {

                }, child: Text('Set bool')),
                TextButton(onPressed: () {

                }, child: Text('Get bool')),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                TextButton(onPressed: () {
                          storeString();
                }, child: Text('Set String')),
                TextButton(onPressed: () {
                   fetchString();
                }, child: Text('Get String')),
              ],
            ),
            SizedBox(height: 50,),

          ],
        ),
      ),
    );
  }
}
