import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Platform.isAndroid?await Firebase.initializeApp(options: const FirebaseOptions(
  // apiKey: 'AIzaSyBF0_y7eQkCFTpWqb5-Uc9JI1hMV20ZZdQ', 
  // appId: '1:537163552413:android:2bea0370e24f18f783e674', 
  // messagingSenderId: '537163552413', 
  // projectId: 'soutout-e5349', storageBucket: 'gs://soutout-e5349.appspot.com'),
  // )
  // :await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

