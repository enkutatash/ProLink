import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/chatDetailPage.dart';

List<Map<String, dynamic>> messages = [
  {
    'avatar': 'assets/avatar.png',
    'name': 'John Doe',
    'message': 'Hello, how are you doing?',
    'timestamp': '12:00 PM',
    'online': true,
  },
  {
    'avatar': 'assets/avatar2.png',
    'name': 'Jane Smith',
    'message': 'Can we meet tomorrow?',
    'timestamp': '10:00 AM',
    'online': false,
  },
];

class  MessageRec extends StatefulWidget {
  @override
  _MessageRecState createState() => _MessageRecState();
}

class _MessageRecState extends State< MessageRec> {
  // Function to handle message deletion
  void deleteMessage(int index) {
    setState(() {
      messages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int collaborationRequestsCount = 1;
    int incomingMessagesCount = messages.length;

    int totalNotifications = collaborationRequestsCount + incomingMessagesCount;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              Text(
                'Messages',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        totalNotifications.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collaboration Requests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(color: Colors.black, offset: Offset(1.0, 1.0))
                  ],
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
                            Text(
                              'John Doe',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  child: Text(
                                    'Accept',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                MaterialButton(
                                  color: Colors.black,
                                  onPressed: () {},
                                  child: Text(
                                    'Decline',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Can we collaborate on web design?',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Incoming Messages',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ChatDetailPage(
                      //       avatar: messages[index]['avatar'] ?? 'Unknown',
                      //       name: messages[index]['name'] ?? 'Unknown',
                      //       message: messages[index]['message'] ?? 'Unknown',
                      //       timestamp:
                      //           messages[index]['timestamp'] ?? 'Unknown',
                      //       isOnline: messages[index]['online'] ?? false,
                      //     ),
                      //   ),
                      // ).then((value) {
                      //   deleteMessage(index);
                      // });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        width: width*0.9,
                        padding: EdgeInsets.all(16.0),
                        height: height*0.12,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 71, 67, 67),
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 32.0,
                                  // image: AssetImage('assets/avatar1.png'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: messages[index]['online']
                                          ? Colors.green
                                          : Colors.grey,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index]['name'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  messages[index]['message'] ?? '',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                messages[index]['timestamp'] ?? '12:00 PM',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
