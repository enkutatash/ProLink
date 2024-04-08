import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillswap/Front/recruiterORuser.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool showOnboarding1 = true;

  void goToNextPage() {
    // Update to navigate to Onboarding2
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding2()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: showOnboarding1 ? Onboarding1(goToNextPage) : Onboarding2(),
      ),
    );
  }
}

class Onboarding1 extends StatelessWidget {
  final VoidCallback onNextPage;

  Onboarding1(this.onNextPage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                // Navigate to Sign Up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color:Color(0XFF2E307A),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'asset/animation.json',
                height: 200,
                width: 200,
                repeat: true,
                reverse: false,
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to SkillSwap!",
                style: TextStyle(
                  fontSize: 22,
                  color:Color(0XFF2E307A),
                ),
              ),
        
              const SizedBox(height: 20),
              const Text(
                "SkillSwap serves as a dynamic platform connecting recruiters with individuals possessing various talents, as well as facilitating collaborations for those seeking project partners.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor:Color(0XFF2E307A),
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 20), // Adjust spacing between circles and arrow
                  GestureDetector(
                    onTap: onNextPage,
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0XFF2E307A),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
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

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                // Navigate to Sign Up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color(0XFF2E307A),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'asset/animation.json',
                height: 200,
                width: 200,
                repeat: true,
                reverse: false,
              ),
              const SizedBox(height: 20),
              const Text(
                'The recruiter',
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0XFF2E307A),
                ),
              ),
              
              const SizedBox(height: 20),
              const Text(
                "Recruiter page acts as a tool to assist recruiters in connecting with individuals who possess a diverse range of talents, enabling them to find the ideal candidates for their needs.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor:Color(0XFF2E307A),
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey, // Shaded in blue indicating second page
                  ),
                  const SizedBox(width: 20), // Adjust spacing between circles and arrow
                  GestureDetector(
                    onTap: () {
                      // Handle tap on arrow button
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NextPage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor:Color(0XFF2E307A),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
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



class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                // Navigate to Sign Up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color:Color(0XFF2E307A),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'asset/animation.json', // Adjust this if needed
                height: 200,
                width: 200,
                repeat: true,
                reverse: false,
              ),
              const SizedBox(height: 20),
              const Text(
                'Collaborators ', // Adjust text if needed
                style: TextStyle(
                  fontSize: 22,
                  color:Color(0XFF2E307A),
                ),
              ),
              // const Text(
              //   'Begin your journey', // Adjust text if needed
              //   style: TextStyle(
              //     fontSize: 20,
              //     color: Colors.blue,
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text(
                'Collaborater page serves as a gateway for users to connect with potential collaborators for a wide array of projects, fostering partnerships across various fields and endeavors', // Adjust text if needed
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.grey,
                  ),
                  const SizedBox(width: 5),
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: Color(0XFF2E307A),
                  ),
                  const SizedBox(width: 20), // Adjust spacing between circles and arrow
                  GestureDetector(
                    onTap: () {
                      // Handle tap on arrow button
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0XFF2E307A),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
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

