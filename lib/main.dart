import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shoutout_shop_app/controllers/categories_controller.dart';
import 'package:shoutout_shop_app/views/screens/auth/login_screen.dart';
import 'package:shoutout_shop_app/views/screens/auth/welcome_screens/welcome_register_screen.dart';
import 'package:shoutout_shop_app/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 239, 129, 12)),
        useMaterial3: true,
      ),
      home: MainScreen(),
      initialBinding: BindingsBuilder((){
        Get.put<CategoryController>(CategoryController());
      }),
    );
  }
}

