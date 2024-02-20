import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_demo/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late var db;

  @override
  void initState() {
    super.initState();
    db = FirebaseFirestore.instance;

    final user = <String, dynamic>{
      "userAge": 25,
      "userGender": "Female",
      "userHeight": 161,
      "userName": "Florance",
    };

    db
        .collection("users")
        .add(user)
        .then((DocumentReference doc) => print('DocumentSnapshot added with ID: ${doc.id}'));

    testGetData();
  }

  void testGetData() async {
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
