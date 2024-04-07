import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Show splash screen first
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to NavigationPage after a certain duration
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
  'assets/spla.png', // Replace 'splash_image.png' with the actual image file name
  height: 200,
  width: 200,
),

            const SizedBox(height: 20),
            const Text(
              'Welcome to MyApp',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
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
        title: const Text(''),
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
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color.fromARGB(255, 18, 162, 245),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/anime3.json',
              height: 200,
              width: 200,
              repeat: true,
              reverse: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Vertex',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Begin your journey',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Revolutionize your education with\npersonalized learning. Track progress\nengage in AI mock interviews, and\naccess resources offline.',
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
                  backgroundColor: Colors.blue,
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
                    backgroundColor: Colors.blue,
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
    );
  }
}

class Onboarding2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color.fromARGB(255, 18, 162, 245),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/anim2.json',
              height: 200,
              width: 200,
              repeat: true,
              reverse: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'AI-based Behavioral',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Interviews',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tailored and realistic behavioral interview\nsimulations powered by artificial\nintelligence, enhancing your interview\nskills and readiness.',
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
                  backgroundColor: Colors.blue,
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
                    backgroundColor: Colors.blue,
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
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
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
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Color.fromARGB(255, 18, 162, 245),
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/anim1.json', // Adjust this if needed
              height: 200,
              width: 200,
              repeat: true,
              reverse: false,
            ),
            const SizedBox(height: 20),
            const Text(
              'Immersive Courses Content', // Adjust text if needed
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            // Text(
            //   'Begin your journey', // Adjust text if needed
            //   style: TextStyle(
            //     fontSize: 20,
            //     color: Colors.blue,
            //   ),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Dive in to comprehensive notes,\nenlightening videos, and vivid slides that\npaint a clear picture of your technical\nvoyage.', // Adjust text if needed
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
                  backgroundColor: Colors.blue,
                ),
                const SizedBox(width: 20), // Adjust spacing between circles and arrow
                GestureDetector(
                  onTap: () {
                    // Handle tap on arrow button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onboarding2()),
                    );
                  },
                  child: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
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
    );
  }
}
