import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?await Firebase.initializeApp(options: const FirebaseOptions(
  apiKey: 'AIzaSyCFqoVzMUpU6Pw66lGybl_TtVUxfw-OTHI', 
  appId: '1:781724808430:android:bfc746b14f4804488b6fff', 
  messagingSenderId: '781724808430', 
  projectId: 'shoutout-app-b7c4f', storageBucket: 'gs://shoutout-app-b7c4f.appspot.com'),
  )
  :await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

