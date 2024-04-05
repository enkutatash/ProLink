import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Firebase_Service {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference dbrefuser =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference dbrefREC =
      FirebaseFirestore.instance.collection('Recruiter');
  final CollectionReference dbrefproject =
      FirebaseFirestore.instance.collection('Project');
  late BuildContext _context;

  Firebase_Service(BuildContext context) {
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
      String firstName,
      String lastName,
      String email,
      String password,
      String profilePic,
      String linkedin,
      String github,
      String bio,
      List<String> skills) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? userid = user.user?.uid;
      adduser(userid!, firstName, lastName, email, profilePic, linkedin, github,
          bio, skills);
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

  Future<User?> signUpWithEmailAndPasswordREC(
      String firstName,
      String lastName,
      String email,
      String password,
      String profilePic,
      String linkedin,
      String companyName,
      List<String> skills) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? userid = user.user?.uid;
      addREC(userid!, firstName, lastName, email, profilePic, linkedin,
          companyName, skills);
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

  Future addREC(
      String userid,
      String firstName,
      String lastName,
      String email,
      String profilePic,
      String linkedin,
      String companyName,
      List<String> skills) {
    List<Map<String, String>> skillsWithLevel =
        skills.map((skill) => {'skill': skill, 'level': 'Beginner'}).toList();
    return dbrefREC.doc(userid).set({
      'Email': email,
      'First': firstName,
      'Last': lastName,
      'profilePic': profilePic,
      'Skills': skillsWithLevel,
      'Linkedin': linkedin,
      'CompanyName': companyName
    });
  }

  Future adduser(
      String userid,
      String firstName,
      String lastName,
      String email,
      String profilePic,
      String linkedin,
      String github,
      String bio,
      List<String> skills) {
    List<Map<String, String>> skillsWithLevel =
        skills.map((skill) => {'skill': skill, 'level': 'Beginner'}).toList();
    return dbrefuser.doc(userid).set({
      'Email': email,
      'First': firstName,
      'Last': lastName,
      'profilePic': profilePic,
      'Bio': bio,
      'Skills': skillsWithLevel,
      'Linkedin': linkedin,
      'Github': github,
      'MyProjects': [],
      'WorkingOnPro': []
    });
  }

  Future createProject(
      String projectimg,
      String projectTitle,
      String projectDescription,
      String userid,
      List<String> skillReq,
      List<String> teams) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    DocumentReference docref = await dbrefproject.add({
      'Projectimg': projectimg,
      'ProjectTitle': projectTitle,
      'ProjectDes': projectDescription,
      'Owner': userid,
      'SkillReq': skillReq,
      'Teams': teams,
      'TimeStamp': formattedDate
    });
    addProjectToUser(userid, docref.id);
    _showSnackBar("Project successfully created");
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
        snapshot = await dbrefREC.doc(docid).get();
        if (snapshot.exists) {
          Map<String, dynamic> userdata =
              snapshot.data() as Map<String, dynamic>;
          return userdata;
        }

        return {}; // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {}; // Return empty map if there's an error
    }
  }

  
 Future<Map<String, dynamic>> userdataTwo(String docid) async {
  try {
    DocumentSnapshot snapshot = await dbrefuser.doc(docid).get();
    if (snapshot.exists) {
      Map<String, dynamic> userData = {
        'First': snapshot.get('First'),
        'Last': snapshot.get('Last'),
        'profilePic': snapshot.get('profilePic'),
      };
      return userData;
    } else {
      return {}; // Return empty map if the document doesn't exist
    }
  } catch (e) {
    print("Error fetching user data: $e");
    return {}; // Return empty map if there's an error
  }
}


    Future<Map<String, dynamic>> ProjectData(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbrefproject.doc(docid).get();
      if (snapshot.exists) {
        Map<String, dynamic> userdata = snapshot.data() as Map<String, dynamic>;
        return userdata;
      } else {
        snapshot = await dbrefREC.doc(docid).get();
        if (snapshot.exists) {
          Map<String, dynamic> userdata =
              snapshot.data() as Map<String, dynamic>;
          return userdata;
        }

        return {}; // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {}; // Return empty map if there's an error
    }
  }

  Future<void> addProjectToUser(String userid, String projectid) async {
    DocumentSnapshot userSnapshot = await dbrefuser.doc(userid).get();

    if (userSnapshot.exists) {
      print("start");
      List currentPProj = userSnapshot.get('MyProjects');

      currentPProj.add(projectid);

      await dbrefuser.doc(userid).update({
        'MyProjects': currentPProj,
      });
      print("project added");
    } else {
      throw Exception('User document not found');
    }
  }

  

  void signout() {
    FirebaseAuth.instance.signOut();
  }
}
