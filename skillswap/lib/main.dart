import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:skillswap/Front/recruiterORuser.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Front/signup.dart';
import 'package:skillswap/firebase/firebase_options.dart';
import 'package:skillswap/Front/candidatefront.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white, // Set scaffold background color
        // Other theme configurations...
      ),
    debugShowCheckedModeBanner: false,
    home: WelcomePage()));
}

