import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Datas/projectcontroller.dart';
import 'package:skillswap/Datas/userdata.dart';
import 'package:skillswap/pages/contact.dart';
import 'package:skillswap/pages/setting.dart';
import 'package:skillswap/widgets/skillimg.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final UserController userController = Get.find();
    final FirebaseAuth _authentication = FirebaseAuth.instance;
    Future<Widget> workingonProject(String projectid) async {
      ProjectController projectController = Get.find();

      Map<String, dynamic> projectdata =
          await projectController.ProjectData(projectid);
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      return Container(
        width: width * 0.4,
        height: height * 0.1,
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
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(
              projectdata['ProjectTitle'],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      );
    }

Future<Widget> completedProject(String projectid, int rate) async {
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('CompletedProjects')
      .doc(projectid)
      .get();
  Map<String, dynamic> projectdata =
      snapshot.data() as Map<String, dynamic>;
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    width: width * 0.4,
    height: height * 0.1,
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
              image:
                  DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Text(
          projectdata['ProjectTitle'],
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        rate != 6?Row(
          children: List.generate(5, (index) {
            if (index < rate) {
              // Render golden star
              return Icon(
                Icons.star,
                color: Colors.amber,
                size: 24,
              );
            } else {
              // Render empty star
              return Icon(
                Icons.star_border,
                color: Colors.grey,
                size: 24,
              );
            }
          }),
        ):Text("Owner")

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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: userController.userdata['profilePic'],
                    imageBuilder: (context, imageProvider) => Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    width: width * 0.08,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${userController.userdata['First']} ${userController.userdata['Last']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      GestureDetector(
                        onTap: () =>
                            _launchInEmailApp(userController.userdata['Email']),
                        child: Text(
                          userController.userdata['Email'],
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
                                      userController.userdata['Skills'].length,
                                      (index) {
                                    Map<String, dynamic> skill = userController
                                        .userdata['Skills'][index];

                                    if (logomap.containsKey(skill['skill'])) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(skill['skill']),
                                                      Text(skill['level'])
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 237, 241, 245),
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
                    Text(userController.userdata['Bio']),
                  ],
                ),
              ),
              SizedBox(height: height * 0.03),
              userController.userdata['Linkedin'] != null &&
                      userController.userdata['Linkedin'] != ''
                  ? Row(
                      children: [
                        Image.asset(
                          logomap['linkedin']!,
                          width: width * 0.12,
                          height: height * 0.04,
                        ),
                        InkWell(
                          onTap: () => _launchInBrowser(
                              'https://linkedin.com/in/',
                              userController.userdata['Linkedin']),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //  color: Color.fromARGB(255, 237, 241, 245),
                            // ),
                            width: width * 0.76,
                            child: Text(userController.userdata['Linkedin']),
                          ),
                        )
                      ],
                    )
                  : Container(),
              SizedBox(height: height * 0.03),
              userController.userdata['Github'] != null &&
                      userController.userdata['Github'] != ''
                  ? Row(
                      children: [
                        Image.asset(
                          logomap['github']!,
                          width: width * 0.12,
                          height: height * 0.04,
                        ),
                        InkWell(
                          onTap: () => _launchInBrowser('https://github.com/',
                              userController.userdata['Github']),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //  color: Color.fromARGB(255, 237, 241, 245),
                            // ),
                            width: width * 0.76,
                            child: Text(userController.userdata['Github']),
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
              //
              RawScrollbar(
                thickness: 5,
                thumbColor: Color(0XFF2E307A),
                child: SizedBox(
                  height: 300,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(_authentication.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      Map<String, dynamic> data =
                          snapshot.data!.data()! as Map<String, dynamic>;
                      var projects = data['WorkingOnPro'] as List<dynamic>?;

                      if (projects == null || projects.isEmpty) {
                        return const Text('No projects available');
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: workingonProject(projects[index]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(); // Or any loading indicator
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return snapshot.data!;
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.02,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Completed Projects",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              RawScrollbar(
                thickness: 5,
                thumbColor: Color(0XFF2E307A),
                child: SizedBox(
                  height: 300,
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .doc(_authentication.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      Map<String, dynamic> data =
                          snapshot.data!.data()! as Map<String, dynamic>;
                      var projects = data['CompletedProject'] as List<dynamic>?;

                      if (projects == null || projects.isEmpty) {
                        return const Text('No projects available');
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future:
                                completedProject(projects[index]['projectId'],projects[index]['rate']),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Container(); // Or any loading indicator
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return snapshot.data!;
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              SizedBox(
                height: height * 0.02,
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
