import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/home.dart';
import 'package:flutter_app1/pages/login.dart';
import 'package:flutter_app1/pages/registre.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner:false ,  
      home: Home() , 
    );
  }
}










