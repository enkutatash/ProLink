import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skillswap/Front/recruiterORuser.dart';
import 'package:skillswap/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
    debugShowCheckedModeBanner: false,
    home: WelcomePage()));
}

