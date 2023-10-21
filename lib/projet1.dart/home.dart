 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final CollectionReference donar = FirebaseFirestore.instance.collection('donar');

    void deleteDonar(docId){
      donar.doc(docId).delete();

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donation App'),
        backgroundColor: Colors.red,
        
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/add');
      },
      backgroundColor: const Color.fromARGB(255, 247, 245, 245),
      child: Icon(Icons.add,
      color: Colors.red ,
      size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop ,

      body: StreamBuilder(stream: donar.orderBy('name').snapshots(),
       builder: (context,snanapshot){

if(snanapshot.hasData){
  return ListView.builder(
    itemCount: snanapshot.data!.docs.length,
    itemBuilder: (context,Index){
      final DocumentSnapshot donarsnap = snanapshot.data!.docs[Index];
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow:[
                BoxShadow(
                  color: const Color.fromARGB(255, 236, 230, 230),
                  blurRadius: 10,
                  spreadRadius: 15,
                )
              ] 
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Text(donarsnap['group'],
                    style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(donarsnap['name'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text(donarsnap['phone'].toString(), style: TextStyle(fontSize: 18),),
                ],
               ),
               Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushNamed(context, '/update',
                    arguments: {
                      'name': donarsnap['name'],
                      'phone': donarsnap['phone'].toString(),
                      'group': donarsnap['group'],
                      'id': donarsnap.id,
                    }
                    );
                  },
                   icon:Icon(Icons.edit),
                  iconSize: 30,
                  color: Colors.blue,
                  ),
                  IconButton(onPressed: (){
                    deleteDonar(donarsnap.id);
                  },
                   icon:Icon(Icons.delete),
                  iconSize: 30,
                  color: Color.fromARGB(255, 219, 40, 8),
      
                  ),
                ],
               ) 
            ],
          ),
        ),
      );
    });

}
return Container();
       }),
    );
  }
}