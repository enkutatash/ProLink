import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Chat/chat.dart';
import 'package:skillswap/Chat/chatpage.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/Request/sendrequest.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestDetail extends StatelessWidget {
  Map<String, dynamic> data;
  String requestId;
  RequestDetail(this.data, this.requestId,{super.key});

  ProjectController projectController = Get.find();
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  RequestSend _request = RequestSend();
  final Chat _chat = Chat();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: data['UserData']['profilePic'],
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data['UserData']['First']} ${data['UserData']['Last']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      GestureDetector(
                        onTap: () =>
                            _launchInEmailApp(data['UserData']['Email']),
                        child: Text(
                          data['UserData']['Email'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: height * 0.03),
              SizedBox(height: height * 0.03),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 237, 241, 245),
                ),
                constraints: const BoxConstraints(
                  minHeight: 100.0,
                ),
                width: width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${data['Title']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "Application letter",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(data['message']),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Position",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                  // padding: EdgeInsets.all(10),
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.builder(
                      itemCount: data['Skill'].length,
                      itemBuilder: (context, index) {
                        return Text('${data['Skill'][index]}');
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Requests")
                          .doc(_authentication.currentUser!.uid)
                          .collection('messages')
                          .doc(requestId)
                          .delete();
                      // send rejection message
                      _chat.sendmessage(
                          data['senderId'], "User request has rejected");
                    },
                    icon: Icon(
                      CupertinoIcons.clear_circled,
                      size: 45,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Requests")
                          .doc(_authentication.currentUser!.uid)
                          .collection('messages')
                          .doc(requestId)
                          .delete();
                      FirebaseFirestore.instance
                          .collection("Requests")
                          .doc(_authentication.currentUser!.uid)
                          .collection('messages')
                          .doc(requestId)
                          .delete();
                      // send rejection message
                      _chat.sendmessage(
                          data['senderId'], "User request has Accepted");
                      // add project to working on projects
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(data['senderId'])
                          .update({
                        'WorkingOnPro':
                            FieldValue.arrayUnion([data['projectId']])
                      }).then((value) {
                        print(
                            "Element added to the working list successfully.");
                      }).catchError((error) {
                        print(
                            "Failed to add element to the working list: $error");
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.check_mark_circled,
                      size: 45,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatPage(
                                recieverid:data['senderId'] , userdata: data['UserData'])));
                  },
                  icon: Image.asset(width: 30, height: 30, "asset/send.png"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String app, String url) async {
    final Uri toLaunch = Uri.parse('$app$url');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchInEmailApp(String email) async {
    final Uri toLaunch = Uri.parse('mailto:$email');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch email to $email');
    }
  }
}
