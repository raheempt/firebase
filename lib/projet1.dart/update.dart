import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {

  final  bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ? selectedbloodgroups;
      final CollectionReference donar = FirebaseFirestore.instance.collection('donar');

      TextEditingController donarname = TextEditingController();
      TextEditingController donarphone = TextEditingController();

      void UpdateUser(docId){
        final data = {
          'name':donarname.text,
          'phone':donarphone.text,
          'group':selectedbloodgroups,
          
        };
        donar.doc(docId).update(data).then((value) => Navigator.pop(context));

      }


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donarname.text = args['name'];
    donarphone.text = args['phone'];
    selectedbloodgroups = args['group'];
    final dovId = args['id'];
    return Scaffold(
       appBar: AppBar(
        title: Text(' Update user'),
        backgroundColor: Color.fromARGB(255, 54, 244, 117), 
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          
          children: [
            TextField(
              controller: donarname,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                label: Text('Donor Name'),
              ),
            ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: donarphone,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                   decoration: InputDecoration(   
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  label: Text('ph.no'),
                              ),
                            ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: DropdownButtonFormField(
                    value: selectedbloodgroups,

                    decoration: InputDecoration(
                      label: Text('select Blood groups'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    items: bloodGroups.map((e) =>  DropdownMenuItem(
                    child: Text(e),
                    value: e,
                    )).toList(), onChanged: (val){
                      selectedbloodgroups = val;
                    }),
                ),
                ElevatedButton(onPressed: (){
                  UpdateUser(dovId);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                 child: Text('update',style: TextStyle(fontSize: 30),)),
          ],
        ),
      ),
    );
  }
}