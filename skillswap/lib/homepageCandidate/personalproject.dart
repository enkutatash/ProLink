import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/project.dart';
import 'package:skillswap/homepageCandidate/createProject.dart';

class MyProjects extends StatefulWidget {
  MyProjects({super.key});

  @override
  State<MyProjects> createState() => _MyProjectsState();
}

class _MyProjectsState extends State<MyProjects> {
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
              return Column(
                children: [
                  Project(projectController.Project[index]),
                  Divider()
                ],
              );
            },
          );
        }
      }),
    );
  }
}
