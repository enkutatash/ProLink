import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Front/recruiterORuser.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/pages/contact.dart';
import 'package:skillswap/pages/setting.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    ProjectController projectController = Get.put(ProjectController());
    final UserController userController = Get.find();
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
                      CachedNetworkImage(
                        imageUrl: userController.userdata['profilePic'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Text(
                        '${userController.userdata['First']} ${userController.userdata['Last']} ',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading:  Icon(CupertinoIcons.house,size: 30,),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading:  Icon(CupertinoIcons.gear,size: 30,),
                  title: Text('Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(CupertinoIcons.phone,size: 30,),
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
            leading: Icon(
              Icons.logout,
              color: Color(0XFF2E307A),
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Color(0XFF2E307A)),
            ),
            onTap: () {
              projectController.clearProjects();
              userController.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
