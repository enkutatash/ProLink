import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/Search/projectsearch.dart';
import 'package:skillswap/homepageCandidate/Search/usersearch.dart';

class Search_Screen extends StatefulWidget {
  Map<String, dynamic> userdata;
  String userid;
  Search_Screen(this.userdata,this.userid,{super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  final TextEditingController _search = TextEditingController();
  late final Firebase_Service _auth;
  bool _searchInProjects = false;
  List _allUser = [];
  List _allProject = [];
  List _searchResult = [];

  allUser() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('First')
        .get();
    setState(() {
      _allUser = data.docs;
    });
    _allUser.removeWhere((doc) => doc.id == widget.userid);
    searchResult(); 
  }

  allproject() async {
    var data = await FirebaseFirestore.instance
        .collection('Project')
        .orderBy('TimeStamp')
        .get();
    setState(() {
      _allProject = data.docs;
    });
       _allProject = data.docs;
    // Remove unwanted elements from _allProject
    _allProject.removeWhere((doc) => widget.userdata['MyProjects'].contains(doc.id));
    searchResult(); // Move this inside setState
  }

  searchResult() {
    var showResult = [];
    if (_search.text.isNotEmpty) {
      if (_searchInProjects == false) {
        // Search in users
        for (var u in _allUser) {
          List<Map<String, dynamic>> skills =
              List<Map<String, dynamic>>.from(u['Skills']);
          for (var skill in skills) {
            if (skill['skill']
                .toLowerCase()
                .contains(_search.text.toLowerCase())) {
              showResult.add(u);
              break;
            }
          }
        }
      } else {
        // Search in projects
        for (var project in _allProject) {
          var name = project['ProjectTitle'].toString().toLowerCase();
          if (name.contains(_search.text.toLowerCase())) {
            showResult.add(project);
          }
        }
      }
    } else {
      // Reset search result based on current search mode
      showResult =
          _searchInProjects ? List.from(_allProject) : List.from(_allUser);
    }
    setState(() {
      _searchResult = showResult;
    });
  }

  @override
  void initState() {
    super.initState();
    _search.addListener(_onSearch);
    allUser();
    _auth = Firebase_Service(context);
  }

  _onSearch() {
    searchResult();
  }

  @override
  void dispose() {
    _search.removeListener(_onSearch);
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          controller: _search,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _searchInProjects = false;
                      });
                      allUser();
                    },
                    child: Text("Users"),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _searchInProjects = true;
                      });
                      allproject();
                    },
                    child: Text("Projects"),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResult.length,
                itemBuilder: (context, index) {
                  if (_searchInProjects == false) {
                    Map<String, dynamic> userdata =
                        _searchResult[index].data() as Map<String, dynamic>;
                    String userid = _allUser[index].id;
                    return UserSearch(userdata, userid);
                  } else {
                    Map<String, dynamic> projectdata =
                        _searchResult[index].data() as Map<String, dynamic>;
                    return ProjectSearch(projectdata);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
