import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu), // Hamburger icon
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: const Text(''), // Empty title
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/R.jpg'), // Add your profile picture asset here
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello, recruiter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Users with Specific Skills',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), // Bold text style
              ),
              const SizedBox(height: 10),
              _buildUserRow('assets/images/R.jpg', 'Username 1', 'Skill Description 1', context),
              _buildUserRow('assets/images/R.jpg', 'Username 2', 'Skill Description 2', context),
              _buildUserRow('assets/images/R.jpg', 'Username 3', 'Skill Description 3', context),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  // Add functionality for home button here
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Add functionality for search button here
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  // Add functionality for profile button here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserRow(String profileImage, String username, String skillDescription, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(profileImage),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    skillDescription,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Add onPressed functionality for contact button here
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Contact'),
          ),
        ],
      ),
    );
  }
}
