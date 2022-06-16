import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in/screens/login_screen.dart';
import 'package:sign_in/store_binding.dart';

void main() {
  StoreBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // initialBinding: StoreBinding(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

