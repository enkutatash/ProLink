// Import required libraries
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // Three-line button icon at the top of the page
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add your menu button onPressed logic here
          },
        ),
        // Remove title from the app bar
        title: null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  // Profile picture on the left side of "Hello, user"
                  CircleAvatar(
                    radius: 50, // Adjust the size of the CircleAvatar
                    backgroundImage: AssetImage('asset/profile_img.jpg'),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    'Hello, user',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Connect with peers container as a button
              ElevatedButton(
                onPressed: () {
                  // Add your logic here for when the container is tapped
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 12, 12, 12)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Connect with peers for growth',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    const SizedBox(width: 10.0),
                    // Picture on the right side with larger size
                    Container(
                      width:width*0.1 , // Adjust the width of the container
                      height: height*0.1, // Adjust the height of the container
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: const DecorationImage(
                          image: NetworkImage('asset/image 1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 10.0), // Add some space between the two texts
              const Text(
                'Challenge your knowledge', // Text below the div
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              // Second div with white background, black border, and text
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Exchange Skills', // Text in bold
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              'Join a global community', // Text in normal font
                              style: TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 10.0),
                            // Connect button
                            ElevatedButton(
                              onPressed: () {
                                // Add your connect button onPressed logic here
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              child: const Text(
                                'Join now',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 100, // Adjust the width of the container
                        height: 80, // Adjust the height of the container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: NetworkImage('https://edukitapp.com/img/blog/blog-23.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Third div with white background, black border, and text
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(15.0),
                child: const Row(
                  children: [
                    // Profile picture
                    CircleAvatar(
                      radius: 30, // Adjust the size of the CircleAvatar
                      backgroundImage: NetworkImage('https://edukitapp.com/img/blog/blog-23.jpg'),
                    ),
                    SizedBox(width: 10.0),
                    // Project name and online icon
                    Expanded(
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Project Name', // Project name text
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 12.0,
                                        color: Colors
                                            .green, // Online status indicator color
                                      ),
                                      SizedBox(width: 2.0),
                                      Text(
                                        '1 hour ago', // Time text
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Fourth div with an image
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.network(
                    'https://edukitapp.com/img/blog/blog-23.jpg', // Placeholder image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Developing a website', // Text on the left corner
                  //   style: TextStyle(fontSize: 16.0),
                  // ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Developing a website', // Text on the left corner
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Collaborate', // Text in bold on the right side
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
