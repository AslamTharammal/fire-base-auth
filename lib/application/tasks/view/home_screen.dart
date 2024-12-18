import 'package:firbace/application/authendication/controller/aouthendication_controllar.dart';
import 'package:firbace/application/tasks/controller/data_controller.dart';
import 'package:firbace/application/tasks/view/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/data_model.dart';
import 'edit_data_page.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthController>(context);
    final dataProvider=Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>const ProfileScreen(),)),
        icon:const Icon(Icons.person,color: Colors.white,),),
        actions: [
          TextButton(onPressed:(){
            authProvider.logOut(context);
          },
              child:const Text('Log out',style: TextStyle(color: Colors.white),)),
        ],
      ),
      body:Padding(
        padding:const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: dataProvider.title,
              decoration:const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Title'),

              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              maxLines: 4,
              controller:dataProvider. description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Description'),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            MaterialButton(onPressed: (){
              final userdata = DataModel(title:dataProvider. title.text, description:dataProvider. description.text);
              if(dataProvider.title!=null && dataProvider. description!=null){
                dataProvider.saveData(userdata);
              }else{
                return ;
              }
              dataProvider.title.clear();
              dataProvider.description.clear();
            },
              color: Colors.blueAccent,
            child:const Text('Save Data'),),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: StreamBuilder<List<DataModel>>
              (stream: dataProvider.getData(),builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator() ,
                  );
                }if(!snapshot.hasData || snapshot.data!.isEmpty){
                  return const Center(
                    child: Text('no data'),
                  );
                }
                final data=snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder:(context, index) {
                    final item=data[index];
                    return Container(
                      margin:const EdgeInsets.all(3),
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.title,style:const TextStyle(fontSize: 18),),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    item.description,
                                    maxLines: 3, // Limit lines for description
                                    overflow: TextOverflow.ellipsis,
                                    style:const TextStyle(fontSize: 18),),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditDataPage(title: item.title,description: item.description,item: item,);
                                    },
                                  );

                                },
                                style:const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
                                  shape: MaterialStatePropertyAll(LinearBorder()),
                                ), child:const Text('Edit'),),
                                TextButton(onPressed: () {
                                  dataProvider.delete(item.documentId!);

                                },
                                  style:const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                                    shape: MaterialStatePropertyAll(LinearBorder()),
                                  ), child:const Text('Delete',style: TextStyle(color: Colors.white),),)
                              ],
                            )
                          ],

                        ),
                      ),
                    );
                  },



                );
            }
            ),
            ),

          ],
        ),
      ),
    );
  }
}
