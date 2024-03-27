import 'package:flutter/material.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/homepage/homepage.dart';

class ProfilePage extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  ProfilePage(this.userdata, this.userid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(userdata['profilePic']),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              "${userdata['First']} ${userdata['Last']}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              userdata['Email'],
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: height * 0.03),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Skills",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // Set the background color of the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.75),
                    offset: Offset(0, 5),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.002),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      height: height * 0.3,
                      child: ListView.builder(
                        itemCount: userdata['Skills'].length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> skill =
                              userdata['Skills'][index];
                          return SkillLevel(skill['skill']!, skill['level']!);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillLevel extends StatelessWidget {
  String skill, level;
  SkillLevel(this.skill, this.level, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text(skill),
       GestureDetector(onTap: (){},child: Text(level))],
    );
  }
}
