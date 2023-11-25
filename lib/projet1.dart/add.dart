import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {

  final  bloodGroups = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ? selectedbloodgroups;
      final CollectionReference donar = FirebaseFirestore.instance.collection('donar');

      TextEditingController donarname = TextEditingController();
      TextEditingController donarphone = TextEditingController();

void addDonar(){
  final data = {    
    'name': donarname.text,
    'phone' :donarphone.text,
    'group' :selectedbloodgroups
  } ;
  donar.add(data);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(' Add Donors'),
        backgroundColor: Color.fromARGB(255, 54, 231, 244), 
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
                    decoration: InputDecoration(
                      label: Text('select Blood groups'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    items: bloodGroups.map((e) =>  DropdownMenuItem(
                    child: Text(e),
                    value: e,
                    )).toList(), onChanged: (val){
                      selectedbloodgroups = val;
                    }),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: ElevatedButton(onPressed: (){
                    addDonar();
                    Navigator.pop(context); 
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                   child: Text('submit',style: TextStyle(fontSize: 30),)),
                ),
          ],
        ),
      ),
    );
  }
}