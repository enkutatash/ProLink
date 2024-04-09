import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/Chat/chat.dart';
import 'package:skillswap/Request/requestui.dart';
import 'package:skillswap/Request/sendrequest.dart';
import 'chatDetailPage.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  RequestSend _request = RequestSend();
  final Chat _chat = Chat();
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Expanded(child: _buildRequests()),
    );
  }

  Widget _buildRequests() {
    return StreamBuilder(
        stream: _request.getrequest(_authentication.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error" + snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading ...");
          }

          return SizedBox(
            child: ListView(
              children: snapshot.data!.docs
                  .map((document) => _sendRequest(document))
                  .toList(),
            ),
          );
        });
  }

  Widget _sendRequest(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String requestId = document.id;

    // void removeRequest() async {
    //   print("start");
    //   await _request.removeRequest(_authentication.currentUser!.uid, requestId);
    //   print("end");
    // }

    return Column(
      children: [
        Container(
          width: width * 0.9,
          height: height * 0.15,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: data['UserData']['profilePic'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => Icon(CupertinoIcons.person),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Text(
                        '${data['UserData']['First']} ${data['UserData']['Last']}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              print(document.id);
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
                              .update({'WorkingOnPro': FieldValue.arrayUnion([data['projectId']])})
                              .then((value) {
                            print("Element added to the working list successfully.");
                          }).catchError((error) {
                            print("Failed to add element to the working list: $error");
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
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    ' ${data['message']}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
