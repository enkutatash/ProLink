import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/Search/search.dart';
import 'package:skillswap/homepageCandidate/recentproject.dart';
import 'package:skillswap/homepageCandidate/sidebar.dart';
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

class HomeScreen extends StatelessWidget {
  Map<String, dynamic> userdata;
  final String userid;
  HomeScreen(this.userdata, this.userid,{super.key});

  @override
  Widget build(BuildContext context) {
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
        imagePath: "asset/image 2.png",
        rating: 3.8,
        personName: "James Rocker",
        personImage: "asset/image 2.png",
      ),
    ];
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
                      backgroundImage: NetworkImage(userdata['profilePic']),
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
                                builder: (context) =>
                                    Search_Screen(userdata, userid)));
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
              SizedBox(
                height: height, // Define a specific height for the SizedBox
                child: ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _buildProjectItem(context, projects[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectItem(BuildContext context, Projects project) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
            spreadRadius: 1, // Extends the shadow beyond the box
            blurRadius: 1, // Blurs the edges of the shadow
            offset: Offset(0, 1), // Shifts the shadow (x, y)
          ),
        ],
        color: Color.fromARGB(255, 237, 241, 245),
      ),
      width: width,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Image.asset(
                  project.imagePath,
                  width: width,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -8,
                  left: 8,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 237, 241, 245),
                        shape: BoxShape.rectangle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 3,
                            offset: Offset(0, -2),
                          ),
                        ]),
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
                    ButtonTwo(
                      "Join",
                      Colors.white,
                      Color(0XFF2E307A),
                      width * 0.2,
                      height * 0.05,
                      12,
                      () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
