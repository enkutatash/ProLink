// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:skillswap/Chat/message.dart';

// class Chat extends ChangeNotifier {
//   final FirebaseAuth _authentication = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Future<void> sendmessage(String recieverid, String message) async {
//     final String senderid = _authentication.currentUser!.uid;
//     final Timestamp timestamp = Timestamp.now();
//     Message newmessage = Message(
//         sendId: senderid,
//         receiverId: recieverid,
//         message: message,
//         timestamp: timestamp);
//     List<String> ids = [senderid, recieverid];
//     ids.sort();
//     String chatroom = ids.join("_");

//     await _firestore
//         .collection("ChatRoom")
//         .doc(chatroom)
//         .collection('messages')
//         .add(newmessage.tomap());
//   }

//   // read from db

//   Stream<QuerySnapshot> getmessage(String firstid, String secondid) {
//     List<String> ids = [firstid, secondid];
//     ids.sort();
//     String chatroom = ids.join("_");

//     return _firestore
//         .collection("ChatRoom")
//         .doc(chatroom)
//         .collection('messages')
//         .orderBy('timestamp', descending: false)
//         .snapshots();
//   }
// }
