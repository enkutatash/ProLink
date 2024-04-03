import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart';
import 'package:skillswap/Front/recruiterORuser.dart';
import 'package:skillswap/firebase/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "RobotoMono"
      ),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}

