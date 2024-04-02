import 'package:flutter/material.dart';

class Recruiter extends StatelessWidget {
  const Recruiter({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              size: 40,
            ),
            Icon(
                Icons.notifications,
              size: 30,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    AssetImage('assets/recruiter_images/image 1.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Hello , Recruiter",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              )
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Users with specific skills",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          Expanded(
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  UsersListing(
                    username: 'user 1',
                    skilldescription: 'skill description 1',
                    imageUrl: 'assets/recruiter_images/image 1.png',
                  ),
                  UsersListing(
                    username: 'user 2',
                    skilldescription: 'skill description 2',
                    imageUrl: 'assets/recruiter_images/image 2.png',
                  ),
                  UsersListing(
                    username: 'user 3',
                    skilldescription: 'skill description 3',
                    imageUrl: 'assets/recruiter_images/image 3.png',
                  ),
                ]),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavigation(),
    );
  }
}

class UsersListing extends StatelessWidget {
  final String username;
  final String skilldescription;
  final String imageUrl;
  const UsersListing(
      {required this.username,
      required this.skilldescription,
      required this.imageUrl,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(imageUrl),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  skilldescription,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                  const ButtonStyle(
                      foregroundColor:MaterialStatePropertyAll(
                          Color.fromARGB(255, 249, 248, 245)),
                      backgroundColor:MaterialStatePropertyAll(
                          Color.fromARGB(255, 24, 21, 12)),
                    );
                    // Add your code for contacting
                  },
                  child: const Text('contact'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

