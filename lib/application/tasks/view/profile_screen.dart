import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firbace/application/tasks/controller/profile_edit_controll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/sign_up_controller.dart';
import '../../authendication/model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
      body: Consumer<SignUpController>(builder: (context, signUpController, child) {
        return StreamBuilder<UserModel>(
          stream: signUpController.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            if (!snapshot.hasData ) {
              return const Center(child: Text("No user data found."));
            }
            final userData = snapshot.data!;

            return SingleChildScrollView(
              child: Consumer<ProfileEditController>(
                builder:(context, editProfile, child){
                    editProfile.name.text=userData.firstName ?? "No name found";
                    editProfile.phoneNumber.text=userData.phoneNumber ?? "No phone number found";
                    editProfile.email.text=userData.email ?? "No email found";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 60,
                                child: Text(userData.firstName[0].toUpperCase(),style:const TextStyle(
                                    color: Colors.white,fontSize: 60,shadows:[BoxShadow(
                                    color: Colors.black,blurStyle: BlurStyle.inner,blurRadius: 6,spreadRadius: 0.5)] ),),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 3,
                              child: InkWell(
                                onTap: () {
                                  editProfile.editDatas();
                                },
                                radius: 14,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                child: SizedBox(
                                  height: 35,
                                  width: 35,
                                  child: Card(
                                    shape:const CircleBorder(side: BorderSide.none),
                                    color: CupertinoColors.systemBlue,
                                   shadowColor: Colors.grey.shade900,
                                    elevation: 4,
                                    child:const Icon(Icons.edit, color: Colors.white, size: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: Card(
                          color: Colors.yellow,
                          shape: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: editProfile.editable,
                              controller:editProfile.name,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.yellow,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: Card(
                          color: Colors.yellow,
                          shape: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: editProfile.editable,
                              controller:editProfile.phoneNumber,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                //filled: true,
                               // fillColor: Colors.yellow,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 320,
                        child: Card(
                          color: Colors.yellow,
                          shape: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              enabled: false,
                              controller:editProfile.email,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                // filled: true,
                                // fillColor: Colors.yellow,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),
                     Padding(
                        padding: const EdgeInsets.only(left: 28,right: 28),
                        child: Row(
                          mainAxisAlignment: editProfile.editable ?MainAxisAlignment.end :MainAxisAlignment.start,
                          children: [
                            TextButton(
                                style: ButtonStyle(
                                 padding:const MaterialStatePropertyAll(EdgeInsets.only(left: 30,right: 30)),
                                  elevation:const MaterialStatePropertyAll(2.5),
                                  shadowColor:const MaterialStatePropertyAll(Colors.black),
                                  backgroundColor: MaterialStatePropertyAll(editProfile.editable?CupertinoColors.activeBlue : Colors.red)
                                ),
                                onPressed: () {
                                  editProfile.editable ?
                                  editProfile.updateData(
                                    UserModel(firstName: editProfile.name.text, email:editProfile.email.text,
                                        id: userData.id, phoneNumber: editProfile.phoneNumber.text,
                                        secondName: userData.secondName),
                                  ) : editProfile.deleteUser(context: context);
                            }, child: Text(editProfile.editable?"Update" : "Delete Account",style:const TextStyle(
                                color:Colors.white ,
                                fontSize:16,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      )
                    ],
                  );
                },)
            );
          }

        );
      },)
    );
  }
}

