import 'package:firbace/common/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/aouthendication_controllar.dart';
import '../../../tasks/view/home_screen.dart';
import '../sign/signup_page.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthController>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Login Page',),
      body: Container(
        alignment: Alignment.center,
       padding:const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (email.text.isNotEmpty && email.text.endsWith("@gmail.com")) {
                      return null;
                    }
                    return "Email can't be empty";
                  },
                  controller:email ,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email',
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                ),
               const SizedBox(height: 20,),
                
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "password is mandatory";
                    }
                    return null;
                  },
                  controller: password,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password',
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                
                ),
                const SizedBox(height: 60,),
                
                ElevatedButton(
                
                  onPressed: (){

                    if(formKey.currentState!.validate()){
                        authProvider.loginAccount(context,email.text.trim(),
                            password.text.trim());
                    }
                    if(authProvider.success==true){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                    }else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("email or password is incorrect"),
                      ));
                    }
                  }
                  , child:const Text('Submit',
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 27
                ),)),
                const SizedBox(height: 60,),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const  Text("Dont Have an Account ",
                    style: TextStyle(
                      fontSize: 20
                    ),),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage(),));
                
                    }, child:const Text('SignUp',style: TextStyle(
                        fontSize: 20,
                      color: Colors.indigoAccent
                    ),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    
    );
  }
}

