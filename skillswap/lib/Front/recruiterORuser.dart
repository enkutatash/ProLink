import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skillswap/Front/candidatefront.dart';
import 'package:skillswap/Front/recruiterfront.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Front/signup.dart';
import 'package:skillswap/Front/signup2.dart';
import 'package:skillswap/widgets/buttons.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                const Text(
                  "Welcome to Skill Swap ",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Lottie.asset('asset/animation.json'),
                ),
                
               SizedBox(height: height*0.08,),
                const Text(
                  "Discover,Connect,Exchange skills effortlessly",
                  style: TextStyle(
                     
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height*0.02,),

                
                SizedBox(
                  height: height * 0.07,
                ),
                Column(
                  children: [
                   ButtonTwo("Find Talent",  Color(0XFF2E307A), Colors.white, width*0.8,height*0.07,16,() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpRecPage()));
                    }),
                    SizedBox(height: height*0.02,),
                   ButtonOne("Join as Collaborators", Colors.white, Color(0XFF2E307A),width*0.8,height*0.07, 16,() {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUpPage()));
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
                    style: TextStyle(color: Color(0XFF2E307A), fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


