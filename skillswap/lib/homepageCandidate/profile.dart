import 'package:flutter/material.dart';
import 'package:skillswap/Front/signin.dart';
import 'package:skillswap/homepageCandidate/homepage.dart';
import 'package:skillswap/homepageCandidate/newskill.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  ProfilePage(this.userdata, this.userid, {Key? key}) : super(key: key);

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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                    size: 25,
                  ),
                ),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(userdata['profilePic']),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "${userdata['First']} ${userdata['Last']}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                userdata['Email'],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: height * 0.03),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text(
                  "Skills",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                NewSkill(),
              ]),
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
                        height: height * 0.3,
                        child: RawScrollbar(
                          thumbVisibility: true,
                          thumbColor: Colors.black,
                          radius: Radius.circular(20),
                          thickness: 5,
                          child: ListView.builder(
                            itemCount: userdata['Skills'].length,
                            itemBuilder: (context, index) {
                              print(userdata['Skills'][index]);
                              Map<String, dynamic> skill =
                                  userdata['Skills'][index];

                              return Container(
                                padding: const EdgeInsets.all(8.0),
                                height: height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // Set the background color of the container
                                ),
                                child: SkillLevel(
                                    skill['skill']!, skill['level']!),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bio",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.black, // Set the border color here
                  ),
                ),
                constraints: const BoxConstraints(
                  minHeight: 100.0,
                ),
                width: width * 0.9,
                child: Text(userdata['Bio']),
              ),
              SizedBox(height: height * 0.03),
              userdata['Linkedin'] != null && userdata['Linkedin'] != ''
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Linkedin',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: height * 0.03),
              userdata['Linkedin'] != null && userdata['Linkedin'] != ''
                  ? InkWell(
                      onTap: () => _launchInBrowser('https://linkedin.com/in/',userdata['Linkedin']),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.black, // Set the border color here
                          ),
                        ),
                        width: width * 0.9,
                        child: Text(userdata['Linkedin']),
                      ),
                    )
                  : Container(),
              SizedBox(height: height * 0.03),
              userdata['Github'] != null && userdata['Github'] != ''
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Github',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(height: height * 0.03),
              userdata['Github'] != null && userdata['Github'] != ''
                  ? InkWell(
                    onTap: () => _launchInBrowser('https://github.com/',userdata['Github']),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.black, // Set the border color here
                          ),
                        ),
                        width: width * 0.9,
                        child: Text(userdata['Github']),
                      ),
                  )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String app,String url) async {
    final Uri toLaunch =
        Uri.parse('$app$url');
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
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
        border: Border.all(
          width: 1.0,
          color: Colors.black, // Set the border color here
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(widget.skill),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select ${widget.skill} Level'),
                    content: StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          mainAxisSize:
                              MainAxisSize.min, // Prevent excessive space
                          children: [
                            ListTile(
                              title: Text('Beginner'),
                              // Define value property within ListTile
                              leading: Radio(
                                value: 'Beginner',
                                groupValue:
                                    _selectedValue, // Group for radio buttons
                                onChanged: (value) => setState(
                                    () => _selectedValue = value as String),
                              ),
                            ),
                            ListTile(
                              title: Text('Intermediate'),
                              // Define value property within ListTile
                              leading: Radio(
                                value: 'Intermediate',
                                groupValue: _selectedValue,
                                onChanged: (value) => setState(
                                    () => _selectedValue = value as String),
                              ),
                            ),
                            ListTile(
                              title: Text('Advanced'),
                              // Define value property within ListTile
                              leading: Radio(
                                value: 'Advanced',
                                groupValue: _selectedValue,
                                onChanged: (value) => setState(
                                    () => _selectedValue = value as String),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_selectedValue != null) {
                            // Handle selected value and close dialog
                            print(_selectedValue);
                            Navigator.pop(context, _selectedValue);
                          } else {
                            // Show error message if no selection (optional)
                          }
                        },
                        child: Text('OK'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(widget.level),
          ),
        ],
      ),
    );
  }
}
