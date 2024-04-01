import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/project.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("My Projects"),
        centerTitle: true,
      ),
      body:const SingleChildScrollView(
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
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add,color: Colors.black,size: 30),
      // mini:true,
       shape: CircleBorder(),
      backgroundColor: Colors.white,),
    );
  }
}