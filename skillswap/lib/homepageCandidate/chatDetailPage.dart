import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String timestamp;
  final bool isOnline;
  final bool isMessageSeen;

  ChatDetailPage({
    this.avatar = 'asset/image 1.png',
    this.name = 'John Doe',
    this.message = 'Hello, how are you doing?',
    this.timestamp = '12:00 PM',
    this.isOnline = false,
    this.isMessageSeen = true, required String currentUserUid, required String chatRoomId, required String recipientUid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(avatar),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isOnline ? Colors.green : Colors.grey,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        timestamp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Your message",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            timestamp,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                          isMessageSeen
                              ? Row(
                                  children: [
                                    Icon(Icons.done_all, color: Colors.black),
                                  ],
                                )
                              : Icon(Icons.done, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.emoji_emotions),
              onPressed: () {
                // Handle emoji selector action
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                // Handle voice input action
              },
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Handle send action
              },
            ),
          ],
        ),
      ),
    );
  }
}
