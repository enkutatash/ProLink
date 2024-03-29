import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillswap/Front/homepage.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Front/signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.13,
              ),
              const Text(
                "Welcome to Skill Swap ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Center(
                child: Lottie.asset('asset/animation.json'),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              const Text(
                "Discover,Connect,Exchange skills effortlessly",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: height * 0.09,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.handshake),
                  Icon(Icons.people_rounded),
                  Icon(Icons.speaker_phone_outlined),
                  Icon(Icons.message)
                ],
              ),
              SizedBox(
                height: height * 0.07,
              ),
              Row(
                children: [
                  Button("Recuiter", Colors.black, Colors.white, () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => SignInPage()));
                  }),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Button("Candidate", Colors.white, Colors.red, () {
                     Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FrontPage()));
                  }),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Explore as a guest",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              )
            ],
          ),
        ));
  }
}

class Button extends StatelessWidget {
  final String text;
  final Color btnclr;
  final Color textclr;
  final void Function() click;
  Button(this.text, this.textclr, this.btnclr, this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: click,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Set border radius
          ),
        ),
        minimumSize: MaterialStateProperty.all(
            Size(width * 0.45, height * 0.07)), // Set width and height
        backgroundColor:
            MaterialStateProperty.all<Color>(btnclr), // Set color to red
      ),
      child: Text(
        text,
        style: TextStyle(color: textclr),
      ),
    );
  }
}
