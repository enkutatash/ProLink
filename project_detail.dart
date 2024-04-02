import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  final String profileId;

  
  const ProjectDetailPage({ super.key,  required this.profileId});

  // Fetch project details based on the profileId here

  @override
  Widget build(BuildContext context) {
    // Fetch project details based on the profileId here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/personal_picture.png'),
              ),
            ),

            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 80,
                    height: 2,
                  //  color: Colors.black,
                  ),


                  const SizedBox(height: 20),
                  const Text(
                    'Project Title',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                         color: const Color.fromARGB(255, 250, 248, 244),
                    ),
                  child:  SizedBox(
                    height: 40,
                    child: TextFormField(
                     // initialValue: 'Project Title', // Replace with fetched data
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                  ),
                ),


                  Container(
                    height: 2,
                  //  color: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Project Duration',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 250, 248, 244),
                    ),
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                     // initialValue: 'Project Duration', // Replace with fetched data
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                  ),
                  ),
                  Container(
                    height: 2,
                 //   color: Colors.black,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Project Description',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                       color: const Color.fromARGB(255, 250, 248, 244),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextFormField(
                      //  initialValue: 'Project Description', // Replace with fetched data
                        readOnly: true,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    //color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}