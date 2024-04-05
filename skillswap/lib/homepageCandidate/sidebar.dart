import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/pages/contact.dart';
import 'package:skillswap/pages/setting.dart';

class SideBar extends StatelessWidget {
  final Map<String, dynamic> userdata;
  final String userid;

  SideBar(this.userdata, this.userid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Color.fromARGB(255, 237, 241, 245),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0XFF2E307A),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(userdata['profilePic']),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        '${userdata['First']} ${userdata['Last']} ',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          userdata: userdata,
                          userid: userid,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactPage()));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout,color: Color(0XFF2E307A),),
            title: Text('Logout',style: TextStyle(color: Color(0XFF2E307A)),),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
