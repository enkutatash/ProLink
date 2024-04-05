import 'package:flutter/material.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/homepageCandidate/homepage.dart';
import 'package:skillswap/homepageCandidate/newskill.dart';
import 'package:skillswap/widgets/skillimg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skillswap/firebase/firebase.dart';

class PersonalDetail extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  PersonalDetail(this.userdata, this.userid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                    child: Image.network(
                        height: height * 0.15,
                        width: width * 0.3,
                        fit: BoxFit.cover,
                        userdata['profilePic']),
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userdata['First']} ${userdata['Last']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      GestureDetector(
                        onTap:()=>_launchInEmailApp(userdata['Email']),
                        child: Text(
                          userdata['Email'],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: height * 0.03),
              Container(
                padding: const EdgeInsets.all(10),
                width: width * 0.9,
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Skills",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: RawScrollbar(
                                thumbVisibility: true,
                                thumbColor: Color(0XFF2E307A),
                                radius: Radius.circular(20),
                                thickness: 5,
                                child: Wrap(
                                  spacing:
                                      8, // Adjust the spacing between items as needed
                                  runSpacing:
                                      8, // Adjust the spacing between lines as needed
                                  children: List.generate(
                                      userdata['Skills'].length, (index) {
                                    Map<String, dynamic> skill =
                                        userdata['Skills'][index];

                                    if (logomap.containsKey(skill['skill'])) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(skill['skill']),
                                                      Text(skill['level'])
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Image.asset(
                                          logomap[skill['skill']]!,
                                          width: width * 0.2,
                                          height: height * 0.05,
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(skill['skill']),
                                                      Text(skill['level'])
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 237, 241, 245),
                                          radius: 30,
                                          child: Text(
                                            skill['skill'],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 237, 241, 245),
                ),
                constraints: const BoxConstraints(
                  minHeight: 100.0,
                ),
                width: width * 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(userdata['Bio']),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              userdata['Linkedin'] != null && userdata['Linkedin'] != ''
                  ? Row(
                    children: [
                       Image.asset(
                      logomap['linkedin']!,
                      width: width * 0.12,
                      height: height * 0.04,
                    ),
                    InkWell(
                      onTap: () => _launchInBrowser(
                          'https://linkedin.com/in/', userdata['Linkedin']),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                         color: Color.fromARGB(255, 237, 241, 245),
                        ),
                        width: width * 0.76,
                        child: Text(userdata['Linkedin']),
                      ),
                    )
                    ],
                  )
                  : Container(),
             
              SizedBox(height: height * 0.03),

userdata['Github'] != null && userdata['Github'] != ''
                  ? Row(
                    children: [
                       Image.asset(
                      logomap['github']!,
                      width: width * 0.12,
                      height: height * 0.04,
                    ),
                    InkWell(
                      onTap: () => _launchInBrowser(
                          'https://github.com/',userdata['Github']),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                         color: Color.fromARGB(255, 237, 241, 245),
                        ),
                        width: width * 0.76,
                        child: Text(userdata['Github']),
                      ),
                    )
                    ],
                  )
                  : Container(),

              
             
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String app, String url) async {
    final Uri toLaunch = Uri.parse('$app$url');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
   Future<void> _launchInEmailApp(String email) async {
  final Uri toLaunch = Uri.parse('mailto:$email');
  if (!await launchUrl(
    toLaunch,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch email to $email');
  }
}
}

class SkillLevel extends StatefulWidget {
  final String skill;
  final String level;

  SkillLevel(this.skill, this.level, {Key? key}) : super(key: key);

  @override
  _SkillLevelState createState() => _SkillLevelState();
}

class _SkillLevelState extends State<SkillLevel> {
  String? _selectedValue; // To store the selected radio button value

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 207, 210, 236),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Text(widget.skill), Text(widget.level)],
      ),
    );
  }
}
