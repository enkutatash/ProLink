import 'package:cloud_firestore/cloud_firestore.dart';

class RequestTemp {
  final String sendId;
  final String receiverId;
  final String projectid;
  final String message;
  final Timestamp timestamp;
  List<String> skills;
  Map<String, dynamic> userdata;

  RequestTemp({
    required this.sendId,
    required this.receiverId,
    required this.projectid,
    required this.message,
    required this.timestamp,
    required this.userdata,
    this.skills = const [],
  });
  Map<String, dynamic> tomap() {
    return {
      'senderId': sendId,
      'receiverId': receiverId,
      'projectId': projectid,
      'message': message,
      'timestamp': timestamp,
      'Skill': skills,
      'UserData':userdata
    };
  }
}
