import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/homepageCandidate/createProject.dart';
import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/homepageCandidate/message.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';

class Homepage extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  Homepage(this.userid, this.userdata, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Widget> AllScreens;

  int _selectedScreen = 0;

  @override
  void initState() {
    Get.put(ProjectController(widget.userdata['MyProjects']));
    super.initState();

    AllScreens = [
      HomeScreen(widget.userdata, widget.userid),
      ProjectScreen(widget.userdata, widget.userid),
      ChatPage(),
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
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
