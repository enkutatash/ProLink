import 'package:flutter/material.dart';
import 'package:skillswap/pages/contact.dart';
import 'package:skillswap/pages/setting.dart';



class ProfilePage extends StatelessWidget {
  Map<String, dynamic> userdata;
  final String userid;
  ProfilePage(this.userdata, this.userid,{super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(userdata['profilePic']),
                  ),
                    SizedBox(width: 16),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${userdata['First']} ${userdata['Last']}",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${userdata['Bio']}',
                          style: TextStyle(fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text('Edit Profile'),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.settings),
              title: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingsPage(userdata: userdata,userid: userid,)));
                  },
                  child: Text('Settings')),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactPage()));
                  },
                  child: Text('Contact')),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Create Project'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 170, 5.0, 40.0),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white),
                  ),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
