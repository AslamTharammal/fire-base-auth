import 'package:firbace/application/authendication/controller/aouthendication_controllar.dart';
import 'package:firbace/application/tasks/controller/data_controller.dart';
import 'package:firbace/application/tasks/controller/profile_edit_controll.dart';
import 'package:firbace/application/tasks/controller/sign_up_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/tasks/view/home_screen.dart';
import 'application/authendication/view/login/login_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
final authPref =await SharedPreferences.getInstance();
final String? userId= authPref.getString('id');

  runApp( MyApp(uid: userId,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key, required this.uid});

  final String? uid;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => AuthController(),),
        ChangeNotifierProvider(create: (context) => DataController(),),
        ChangeNotifierProvider(create: (context) => SignUpController(),),
        ChangeNotifierProvider(create: (context) =>ProfileEditController(),),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (uid != null && uid!.isNotEmpty)? HomeScreen():LoginPage(),
      ),
    );
  }
}
