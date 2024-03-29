

import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/homepageCandidate/message.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';


class Homepage extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  Homepage(this.userid,this.userdata, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Widget> AllScreens;

  int _selectedScreen = 0;

  
  @override
  void initState() {
    super.initState();
   
    AllScreens = [
      HomeScreen(),
      SearchScreen(),
      ProjectScreen(),
      Message(),
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
                  icon: Icon(Icons.newspaper_rounded),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.message_rounded),
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