import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/project.dart';
import 'package:skillswap/homepageCandidate/createProject.dart';

class ProjectScreen extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  ProjectScreen(this.userdata, this.userid, {super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Projects"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.userdata['MyProjects'].length,
        itemBuilder: (context, index) {
          return Project(widget.userdata['MyProjects'][index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateProjectPage(widget.userdata, widget.userid)));
        },
        child: Icon(Icons.add, color: Colors.black, size: 30),
        // mini:true,
        shape: CircleBorder(),
        backgroundColor: Colors.white,
      ),
    );
  }
}
