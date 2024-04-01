import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF264653), // Set background color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content left
          children: [
            const Text(
              'Skill Link isn\'t just a platform, it\'s your partner in professional development. We believe collaboration is key to unlocking potential. That\'s why we connect you with the people and resources you need to elevate your skillset. Search our vast network using specific skill tags to find collaborators for your next project, or connect with mentors who can provide expert guidance. Recruiters can leverage the same powerful search to discover qualified candidates with proven experience – making the perfect match effortless. Join the Skill Link community and embark on a collaborative journey towards professional mastery. ',
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Meet the Skill Link Team!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We are passionate about building a platform that empowers individuals and organizations to unlock their full potential.',
            ),
            const SizedBox(height: 20.0),
            ListView.builder(
              // Constrain list view width for better layout
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: teamMembers.length,
              itemBuilder: (context, index) {
                final teamMember = teamMembers[index];
                return Center(
                  child: Card(
                    // Increase width for better card size
                    child: Container(
                      width: 250.0, // Adjust width as needed
                      padding: const EdgeInsets.all(16.0),
                      color: Color(0xFF83C5BE), // Set card background color
                      // Add padding for content
                      child: Column(
                        // Center card content
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage(teamMember.profilePicture),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            teamMember.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(teamMember.position),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center email icon
                            children: [
                              Text(teamMember.email),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFEDF6F9), // Set body background color
    );
  }
}

class TeamMember {
  final String profilePicture;
  final String name;
  final String position;
  final String email;

  TeamMember(
      {required this.profilePicture,
      required this.name,
      required this.position,
      required this.email});
}

final List<TeamMember> teamMembers = [
  TeamMember(
    profilePicture: 'assets/images/alice.jpg',
    name: 'Alice',
    position: 'Software Engineer',
    email: 'Alice@gmail.com',
  ),
  TeamMember(
    profilePicture: 'assets/images/bob.jpg',
    name: 'Bob',
    position: 'UX Designer',
    email: 'Bob@gmail.com',
  ),
  TeamMember(
    profilePicture: 'assets/images/bob.jpg',
    name: 'Randy',
    position: 'Firebase',
    email: 'Randy@gmail.com',
  ),
  TeamMember(
    profilePicture: 'assets/images/bob.jpg',
    name: 'Alicia',
    position: 'project manager',
    email: 'Alicia@gmail.com',
  ),
  TeamMember(
    profilePicture: 'assets/images/bob.jpg',
    name: 'True',
    position: 'flutter',
    email: 'True@gmail.com',
  ),

 
];
