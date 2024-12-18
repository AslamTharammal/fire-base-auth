import 'package:firbace/application/authendication/controller/aouthendication_controllar.dart';
import 'package:firbace/application/tasks/controller/sign_up_controller.dart';
import 'package:firbace/common/widgets/custom_app_bar.dart';
import 'package:firbace/utilitis/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../tasks/view/home_screen.dart';
import '../login/login_page.dart';

class SignUpPage extends StatelessWidget {
   SignUpPage({super.key});
  TextEditingController firstName =TextEditingController();
  TextEditingController secondName =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();

  final signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthController>(context);
    final signUpController=Provider.of<SignUpController>(context);
    return Scaffold(
      appBar: CustomAppBar(title: 'Sign Up Page',),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top:30 ),
        child: SingleChildScrollView(
          child: Form(
            key: signUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2.25,
                      child: TextFormField(
                        controller:firstName,
                        validator: (value)=> AppValidator.validate(value, "First Name"),
                        decoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('First Name',
                            style: TextStyle(
                                fontSize: 20
                            ),),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/60,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/2.25,
                      child: TextFormField(
                        controller:secondName,
                        validator: (value)=> AppValidator.validate(value, "Second Name"),
                        decoration:const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Second Name',
                            style: TextStyle(
                                fontSize: 20
                            ),),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                TextFormField(
                  controller: phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if(phone.text.isNotEmpty && phone.text.length==10 ){
                      return null;
                    }else if(phone.text.isEmpty){
                      return "phone number cannot empty";
                    }else {
                      return "phone number must have 10 numbers";
                    }
                  },
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Phone',
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                ),
                const SizedBox(height: 20,),
                 TextFormField(
                  controller: email,
                   validator:(value) {
                      if(email.text.isNotEmpty && email.text.endsWith("@gmail.com")){
                       if(signUpController.checkEmail(email.toString())==true){
                         return "email already exist";
                       }
                       return null;
                     }else {
                       return "please enter correct email";
                     }
                   },
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
                  controller: password,
                  decoration:const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password',
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                  validator:(value) {
                    if(password.text.isNotEmpty && password.text.length>8){
                      return null;
                    }else if(password.text.isEmpty){
                      return "password cannot empty";
                    }else{
                      return "password must have 8+ character";
                    }
                  },
                ),
                const SizedBox(height: 60,),

                ElevatedButton(
                    onPressed:() {
                      if(signUpKey.currentState!.validate()){
                        authProvider.createAccount(userEmail: email.text.trim(), userPassword: password.text.trim(),
                            firstName: firstName.text.trim(), phoneNumber: phone.text.trim(), secondName: secondName.text.trim());
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }

                    }, child:const Text('Submit',
                  style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 27
                  ),)),
                const SizedBox(height: 60,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account  ",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                    TextButton(onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage(),));
                    }, child:const Text('SignIn',style: TextStyle(
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
