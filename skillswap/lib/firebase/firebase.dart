import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Firebase{
   FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference dbrefuser =
      FirebaseFirestore.instance.collection('Users');
  late BuildContext _context;

  Firebase(BuildContext context) {
    _context = context;
  }

    void _showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
  

      Future<User?> signUpWithEmailAndPassword(
       String firstName,String lastName,String email, String password, String profilePic,String linkedin,String github,String bio) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? userid = user.user?.uid;
      adduser(userid!, firstName,lastName,email, password, profilePic,linkedin,github,bio);
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The email address is already in use.');
        _showSnackBar('The email address is already in use.');
      } else {
        print('An error occurred: ${e.code}');
        _showSnackBar('An error occurred: ${e.code}');
      }
    }
    return null;
  }


  Future adduser(String userid,String firstName,String lastName, String email, String password,String profilePic,String linkedin,String github,String bio) {
      return dbrefuser.doc(userid).set({
      'Email': email,
      'First':firstName,
      'Last':lastName,
      'password': password,
      'profilePic': profilePic,
      'Bio':bio,
    });
  }


  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print('Invalid email or password.');
        _showSnackBar('Invalid email or password.');
      } else {
        print('An error occurred: ${e.code}');
        _showSnackBar('An error occurred: ${e.code}');
      }
    }
    return null;
  }


   Future<Map<String, dynamic>> userData(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbrefuser.doc(docid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userdata = snapshot.data() as Map<String, dynamic>;
        return userdata;
      } else {
        return {}; // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {}; // Return empty map if there's an error
    }
  }

  void signout() {
    FirebaseAuth.instance.signOut();
  }


}