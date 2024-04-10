import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          actions: [
            IconButton(
              icon: const Icon(Icons.contact_support),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/contback.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(100.0), // Increased padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Centered "Contact us" text
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100), // Oval shape
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: const Text(
                        'Contact us',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // Decreased height between sections
                  // Other containers with oval corners
                  _buildOvalContainer(
                    Icons.phone,
                    '+011-123-4567',
                    const Color.fromARGB(255, 3, 74, 141),
                    const Color.fromARGB(255, 0, 0, 0),
                  ),
                  const SizedBox(height: 10),
                  _buildOvalContainer(
                    Icons.language,
                    'www.prolink.com',
                    const Color.fromARGB(255, 3, 74, 141),
                    const Color.fromARGB(255, 2, 2, 2),
                  ),
                  const SizedBox(height: 10),
                  _buildOvalContainer(
                    Icons.mail,
                    'contact@prolink.com',
                    const Color.fromARGB(255, 3, 74, 141),
                    const Color.fromARGB(255, 0, 0, 0),
                  ),
                  const SizedBox(height: 10),
                  _buildOvalContainer(
                    Icons.location_pin,
                    'Addis Ababa Science and Technology\n Addis Ababa, Ethiopia',
                    const Color.fromARGB(255, 3, 74, 141),
                    const Color.fromARGB(255, 0, 0, 0),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build oval-shaped containers
  Widget _buildOvalContainer(IconData icon, String text, Color iconColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100), // Oval shape
      ),
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          // Handle link navigation
        },
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 20),
            Flexible(
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
