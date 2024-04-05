import 'package:flutter/material.dart';
import 'package:skillswap/widgets/buttons.dart';

class Projects {
  final String name;
  final String imagePath;
  final double rating;
  final String personName;
  final String personImage;

  Projects({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.personName,
    required this.personImage,
  });
}

class ProjectsPage extends StatelessWidget {
  final List<Projects> projects = [
    Projects(
      name: "Project 1",
      imagePath: "asset/image 1.png",
      rating: 4.5,
      personName: "John Doe",
      personImage: "asset/image 2.png",
    ),
    Projects(
      name: "Project 2",
      imagePath: "asset/image 2.png",
      rating: 3.8,
      personName: "Sam Smith",
      personImage: "asset/image 2.png",
    ),
    Projects(
      name: "Project 3",
      imagePath: "asset/image 3.png",
      rating: 3.8,
      personName: "Alexa Doyer",
      personImage: "asset/image 2.png",
    ),
    Projects(
      name: "Project 4",
      imagePath: "asset/image 4.png",
      rating: 3.8,
      personName: "James Rocker",
      personImage: "asset/image 2.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return _buildProjectItem(context, projects[index]);
        },
      ),
    );
  }
}

Widget _buildProjectItem(BuildContext context, Projects project) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    color: Color.fromARGB(255, 237, 241, 245),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Image.asset(
                project.imagePath,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: -5,
                left: 8,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                      BoxShadow(
                        color: Colors.grey.withOpacity(1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          project.personImage,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        project.personName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.hourglass_empty),
                      SizedBox(width: 4),
                      Text("Time"),
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 4),
                      Text("${project.rating}"),
                    ],
                  ),
                  ButtonTwo("Join", Colors.white, Color(0XFF2E307A),
                      width * 0.2, height * 0.05, 12, () {})
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
