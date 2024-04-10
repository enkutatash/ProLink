import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/Project/projectcontroller.dart';
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
    Future workingonProject(String projectid) async {
  ProjectController projectController = Get.find();
  Map<String, dynamic> projectdata =
      await projectController.ProjectData(projectid);
      final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
  return Container(
    width: width*0.4 ,
    height: height*0.1,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: projectdata['Projectimg'],
          imageBuilder: (context, imageProvider) => Container(
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        
            Text(projectdata['ProjectTitle'],style: TextStyle(fontSize: 20),),
        
      ],
    ),
  );
}
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
                 CachedNetworkImage(
                          imageUrl:  userdata['profilePic'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Icon(Icons.person),
                          errorWidget: (context, url, error) => Icon(Icons.error),
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
                        child: Row(
                          children: [
                             Image.asset(
                      logomap['email']!,
                      width: width * 0.1,
                      height: height * 0.02,
                    ),
                            Text(
                              userdata['Email'],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //  color: Color.fromARGB(255, 237, 241, 245),
                        // ),
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
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10),
                        //  color: Color.fromARGB(255, 237, 241, 245),
                        // ),
                        width: width * 0.76,
                        child: Text(userdata['Github']),
                      ),
                    )
                    ],
                  )
                  : Container(),
                SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Working On Projects",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: 300,
                child: Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                        itemCount:
                            userdata['WorkingOnPro'].length,
                        itemBuilder: (context, index){
                           return FutureBuilder(
                              future: workingonProject(userdata['WorkingOnPro'][index]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Or any loading indicator
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return snapshot.data;
                                }
                              },
                            );
                        })),
              ),
              
             
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
