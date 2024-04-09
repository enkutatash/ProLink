import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/homepageCandidate/Search/projectsearch.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageCandidate/filter.dart';

import 'package:cached_network_image/cached_network_image.dart';

List<String> items = [
  'Flutter',
  'Node.js',
  'React Native',
  'Java',
  'Docker',
  'MySQL',
  "UI/UX",
  "Django",
  "React",
  "Machine Learning",
  "Artificial Intelligence",
  "Competitive Programming",
  "Project Management",
];

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserController userController = Get.find();
  List _allProject = [];
  List _Project = [];
  bool _isLoading = false;
  int fetchedCount = 0;
  DocumentSnapshot? lastDocument;
  List<String> selectedItems = [];

  allproject() async {
    setState(() {
      _isLoading = true;
    });
    var data = await FirebaseFirestore.instance
        .collection('Project')
        .orderBy('TimeStamp', descending: true)
        .get();
    setState(() {
      _allProject = data.docs;
      // Remove unwanted elements from _allProject
      _allProject.removeWhere(
          (doc) => userController.userdata['MyProjects'].contains(doc.id));
      _Project = List.from(_allProject);
      _isLoading = false;
    });
  }

  searchResult() {
    var showResult = [];
    List<String> filter = [];
    for (var skill in selectedItems) {
      filter.add(skill.toLowerCase());
    }

    if (filter.length != 0) {
      for (var project in _allProject) {
        List<String> skills = List<String>.from(project['SkillReq'] ?? []);
        List<String> skillNames = [];

        for (var skill in skills) {
          skillNames.add(skill.toLowerCase());
        }

        if (filter.every((skill) => skillNames.contains(skill.toLowerCase()))) {
          showResult.add(project);
        }
      }
    } else {
      // Reset search result based on current search mode
      showResult = List.from(_allProject);
    }
    setState(() {
      _Project = showResult;
      _isLoading = false;
    });
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
                    child: CachedNetworkImage(
                      imageUrl: userController.userdata['profilePic'],
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => Icon(Icons.person),
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
                                builder: (context) => Search_Screen()));
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
                              'Search Users and Projects',
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
              Container(
                height: height * 0.07,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = items[index];
                    final isSelected = selectedItems.contains(item);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedItems.remove(item);
                            
                          } else {
                            selectedItems.add(item);
                            
                          }
                          searchResult();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width * 0.2 + item.length * 3,
                          height: height * 0.03,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Color(0XFF2E307A)
                                  : Colors.transparent,
                            ),
                            color: isSelected
                                ? Color(0XFF2E307A)
                                : Color.fromARGB(255, 237, 241, 245),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: height*6,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: _Project.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic>? projectdata =
                          _Project[index].data() as Map<String, dynamic>?;
                      if (projectdata!['ProjectTitle'] == null) {
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
                        children: [ProjectSearch(projectdata), Divider()],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
