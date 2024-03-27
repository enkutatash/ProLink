import 'package:flutter/material.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/homepage/homepage.dart';

class ProfilePage extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  ProfilePage(this.userdata, this.userid, {super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 70, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
              },icon: Icon(Icons.logout_rounded,color: Colors.red,size: 30,),),
            ),
            Stack(children: [
              CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(userdata['profilePic'])),
              
            ]),
            const SizedBox(height: 20.0),
            Text(
              "${userdata['First']} ${userdata['Last']}",
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              userdata['Email'],
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            NavigationButton(
              move: Homepage(userid, userdata),
              text: 'Profile',
              icon: Icons.person,
              showArrowIcon: true,
            ),
            NavigationButton(
              move: Homepage(userid, userdata),
              text: 'Settings',
              icon: Icons.settings,
              showArrowIcon: true,
            ),
            NavigationButton(
              move: Homepage(userid, userdata),
              text: 'Contact',
              icon: Icons.mail,
              showArrowIcon: true,
            ),
            NavigationButton(
              move: Homepage(userid, userdata),
              text: 'Share App',
              icon: Icons.share,
              showArrowIcon: true,
            ),
            NavigationButton(
              move: Homepage(userid, userdata),
              text: 'Help',
              icon: Icons.help,
              showArrowIcon: true,
            ),
          
          ],
        ),
      ),
    );
  }
}

class BottomIconButton extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onPressed;

  const BottomIconButton({
    Key? key,
    required this.icon,
    required this.isActive,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: isActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool showArrowIcon;
  Widget move;
  NavigationButton({
    Key? key,
    required this.move,
    required this.text,
    required this.icon,
    required this.showArrowIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => move));
      },
      leading: Icon(icon),
      title: Text(text),
      trailing: showArrowIcon ? Icon(Icons.arrow_forward_ios) : null,
    );
  }
}