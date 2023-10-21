
import 'package:firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'projet1.dart/home.dart';
import 'projet1.dart/add.dart';
import 'projet1.dart/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo App',
      routes: {
        '/':(context) => HomePage(),
        '/add':(context) => AddUser(),
        '/update':(context) => UpdateUser(),
      },
      initialRoute: '/',
  
    );
  }
}