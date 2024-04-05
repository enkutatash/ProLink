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
  late PageController _pageController;
  late final ProjectController projectController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    projectController = Get.put(ProjectController(widget.userdata['MyProjects']));
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            HomeScreen(widget.userdata, widget.userid),
            ProjectScreen(widget.userdata, widget.userid),
            ChatPage(),
            ProfilePage(widget.userdata, widget.userid),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 237, 241, 245),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0, // Adjust the margin as needed
        child: BottomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (index) {
            setState(() {
              _currentPageIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          selectedItemColor: Color(0XFF2E307A),
          unselectedItemColor: Colors.grey,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateProjectPage(widget.userdata, widget.userid),
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
