import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/project.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Projects"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Project(),
            Project(),
            Project(),
            Project(),
            Project(),
            Project(),
          ],
        ),
      ),
    );
  }
}