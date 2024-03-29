import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/homepageCandidate/message.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';
import 'package:skillswap/homepageCandidate/profile.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageRec/HomeRec.dart';
import 'package:skillswap/homepageRec/message.dart';
import 'package:skillswap/homepageRec/profile.dart';
import 'package:skillswap/homepageRec/searchrec.dart';


class HomepageREC extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  HomepageREC(this.userid,this.userdata, {Key? key}) : super(key: key);

  @override
  State<HomepageREC> createState() => _HomepageRECState();
}

class _HomepageRECState extends State<HomepageREC> {
  late List<Widget> AllScreens;

  int _selectedScreen = 0;

  
  @override
  void initState() {
    super.initState();
   
    AllScreens = [
    HomeRec(),
    SearchRec(),
    MessageRec(),
    ProfileRec(),
      
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
                  icon: Icon(Icons.person),
                  label: "",
                ),
              ],
            ),
          );
  }
}


