import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Front/signup.dart';
import 'package:skillswap/firebase/firebase_options.dart';
import 'package:skillswap/Front/homepage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
        primaryColor: Colors.white, 
        scaffoldBackgroundColor: Colors.black, 
        iconTheme: IconThemeData(color: Colors.white,size: 15),
      ),
    home: FrontPage()));
}

