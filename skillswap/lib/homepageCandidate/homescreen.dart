import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/Search/projectsearch.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageCandidate/recentproject.dart';
import 'package:skillswap/homepageCandidate/sidebar.dart';
import 'package:skillswap/widgets/buttons.dart';

class HomeScreen extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  HomeScreen(this.userdata, this.userid, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _allProject = [];
  List _Project = [];
  bool _isLoading = false;

  allproject() async {
    setState(() {
      _isLoading = true;
    });
    var data = await FirebaseFirestore.instance
        .collection('Project')
        .orderBy('TimeStamp')
        .limit(10) // Limit to only fetch the top 10 projects
        .get();
    setState(() {
      _allProject = data.docs;
      // Remove unwanted elements from _allProject
      _allProject
          .removeWhere((doc) => widget.userdata['MyProjects'].contains(doc.id));
      _Project = List.from(_allProject);
      _isLoading = false;
    });
    print(_Project);
  }

  @override
  void initState() {
    // TODO: implement initState
    allproject();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(widget.userdata['profilePic']),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search_Screen(
                                    widget.userdata, widget.userid)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Text(
                              "Search Project and user",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Container(
                height: height,
                child: ListView.builder(
                  itemCount: _Project.length,
                  itemBuilder: (context, index) {
                   Map<String, dynamic> projectdata = _Project[index]
                                  .data() as Map<String, dynamic>;
                              if (projectdata['ProjectTitle'] == null) {
                                // Show a loading indicator
                                if (_isLoading == true) {
                                  return Container();
                                } else {
                                  _isLoading = true;
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }
                              return Column(
                                children: [
                                  ProjectSearch(projectdata),
                                  Divider()
                                ],
                              );
                            },
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
