import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/homepageCandidate/createProject.dart';
import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/homepageCandidate/message.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageCandidate/recentproject.dart';
import 'package:skillswap/homepageCandidate/sidebar.dart';

class Homepage extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;

  Homepage(this.userid, this.userdata, {Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _pageController;
  late final ProjectController projectController;
  late final UserController usercontroller;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    projectController =
        Get.put(ProjectController(widget.userdata['MyProjects']));
    _pageController = PageController();
    usercontroller = Get.put(UserController(widget.userid));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      drawer: SideBar(widget.userdata, widget.userid),
      body: SafeArea(
        bottom: false,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          children: [
            HomeScreen(),
            ProjectScreen(widget.userdata, widget.userid),
            ChatPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 237, 241, 245),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0, // Adjust the margin as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _onItemTapped(0);
              },
              color: _currentPageIndex == 0 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.task),
              onPressed: () {
                _onItemTapped(1);
              },
              color: _currentPageIndex == 1 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                _onItemTapped(2);
              },
              color: _currentPageIndex == 2 ? Color(0XFF2E307A) : Colors.grey,
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                _onItemTapped(3);
              },
              color: _currentPageIndex == 3 ? Color(0XFF2E307A) : Colors.grey,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateProjectPage(),
            ),
          );
        },
        child: Icon(Icons.add, color: Color(0XFF2E307A), size: 30),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
