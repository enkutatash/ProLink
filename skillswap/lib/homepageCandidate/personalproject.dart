import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:skillswap/Project/projectcontroller.dart';
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
    final ProjectController projectController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Projects"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (projectController.Project.isEmpty) {
          return const Center(
            child: Text("No project"),
          );
        } else {
          return ListView.builder(
            itemCount: projectController.Project.length,
            itemBuilder: (context, index) {
              return Project(projectController.Project[index]);
            },
          );
        }
      }),
    );
  }
}
