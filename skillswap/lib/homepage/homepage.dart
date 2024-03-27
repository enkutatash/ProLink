

import 'package:flutter/material.dart';
import 'package:skillswap/homepage/homescreen.dart';
import 'package:skillswap/homepage/message.dart';
import 'package:skillswap/homepage/personalproject.dart';
import 'package:skillswap/homepage/profile.dart';
import 'package:skillswap/homepage/search.dart';


class Homepage extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  Homepage(this.userid,this.userdata, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _General_ScreenState();
}

class _General_ScreenState extends State<Homepage> {
  late List<Widget> AllScreens;

  int _selectedScreen = 0;

  
  @override
  void initState() {
    super.initState();
   
    AllScreens = [
      HomeScreen(),
      SearchScreen(),
      Message(),
      ProjectScreen(),
      ProfilePage(widget.userdata, widget.userid),
      
    ];
  }

  void _currentScreen(int index) {
    setState(() {
      _selectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            body: AllScreens[_selectedScreen],
            bottomNavigationBar: BottomNavigationBar(
              onTap: _currentScreen,
              currentIndex: _selectedScreen,
              selectedItemColor:  Colors.red,
              unselectedItemColor: Colors.grey,
              iconSize: 30,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message_rounded),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper_rounded),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "",
                ),
              ],
            ),
          );
  }
}