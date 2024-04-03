import 'package:flutter/material.dart';
import 'chatDetailPage.dart';

List<Map<String, dynamic>> messages = [
  {
    'avatar': 'asset/image 1.png',
    'name': 'John Doe',
    'message': 'Hello, how are you doing?',
    'timestamp': '12:00 PM',
    'online': true,
  },
  {
    'avatar': 'asset/image 2.png',
    'name': 'Jane Smith',
    'message': 'Can we meet tomorrow?',
    'timestamp': '10:00 AM',
    'online': false,
  },
];

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
    return 
      
    Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
          title: Text("Messages"),
          centerTitle: true,
          actions: <Widget>[
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
        body: Container(
          padding: EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Collaboration Requests',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color:Color(0XFF2E307A),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 207, 210, 236),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
        spreadRadius: 1, // Extends the shadow beyond the box
        blurRadius: 1,
        offset: Offset(0, 3), // Shifts the shadow (x, y)
      ),
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  color: Colors.green.shade500,
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
                                  color: Colors.red.shade500,
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
                  fontSize: 16,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailPage(
                            avatar: messages[index]['avatar'] ?? 'Unknown',
                            name: messages[index]['name'] ?? 'Unknown',
                            message: messages[index]['message'] ?? 'Unknown',
                            timestamp:
                                messages[index]['timestamp'] ?? 'Unknown',
                            isOnline: messages[index]['online'] ?? false,
                          ),
                        ),
                      ).then((value) {
                        deleteMessage(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        width: width*0.9,
                        padding: EdgeInsets.all(16.0),
                        height: height*0.12,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 207, 210, 236),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
        spreadRadius: 1, // Extends the shadow beyond the box
        blurRadius: 1,
        offset: Offset(0, 3), // Shifts the shadow (x, y)
      ),
    ],
                        ),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
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
                            SizedBox(width: width*0.01,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index]['name'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Container(
                                  width: width*0.5,
                                  child: Text(
                                    messages[index]['message'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
      )
    ;
  }
}
