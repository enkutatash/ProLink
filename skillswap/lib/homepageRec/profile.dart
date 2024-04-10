import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Datas/userdata.dart';
import 'package:skillswap/widgets/buttons.dart';
import 'package:skillswap/widgets/skillimg.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfileRec extends StatelessWidget {
  const ProfileRec({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final UserController userController = Get.find();
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
                        onTap:()=>_launchInEmailApp(userController.userdata['Email']),
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
              
              const FormText(text: "Company Name", alignment: Alignment.centerLeft),
               Align(
                alignment: Alignment.centerLeft,
                 child: Text(
                          "${userController.userdata['CompanyName']}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                         
                        ),
               ),
              userController.userdata['Linkedin'] != null && userController.userdata['Linkedin'] != ''
                  ? Row(
                    children: [
                       Image.asset(
                      logomap['linkedin']!,
                      width: width * 0.12,
                      height: height * 0.04,
                    ),
                    InkWell(
                      onTap: () => _launchInBrowser(
                          'https://linkedin.com/in/', userController.userdata['Linkedin']),
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

userController.userdata['Github'] != null && userController.userdata['Github'] != ''
                  ? Row(
                    children: [
                       Image.asset(
                      logomap['github']!,
                      width: width * 0.12,
                      height: height * 0.04,
                    ),
                    InkWell(
                      onTap: () => _launchInBrowser(
                          'https://github.com/',userController.userdata['Github']),
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

