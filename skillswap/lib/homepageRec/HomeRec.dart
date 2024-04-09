import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Project/userdata.dart';

class HomeRecruiter extends StatefulWidget {
  const HomeRecruiter({super.key});

  @override
  State<HomeRecruiter> createState() => _HomeRecruiterState();
}

class _HomeRecruiterState extends State<HomeRecruiter> {
    final UserController userController = Get.find();


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(CupertinoIcons.text_justify,size: 30,)
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: width * 0.01,
                              ),
                              Text(
                                'Search Users and Projects',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                     CachedNetworkImage(
                        imageUrl: userController.userdata['profilePic'],
                        imageBuilder: (context, imageProvider) => Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => Icon(Icons.person),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                  ],
                ),
              const SizedBox(height: 20),
              const Text(
                'Users with Specific Skills',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18), // Bold text style
              ),
              const SizedBox(height: 10),
              _buildUserRow('asset/image 1.png', 'Username 1',
                  'Skill Description 1', context),
              _buildUserRow('asset/image 2.png', 'Username 2',
                  'Skill Description 2', context),
              _buildUserRow('asset/image 3.png', 'Username 3',
                  'Skill Description 3', context),
            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildUserRow(String profileImage, String username, String skillDescription, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(profileImage),
                radius: 25,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    skillDescription,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              // Add onPressed functionality for contact button here
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Text('Contact'),
          ),
        ],
      ),
    );
  }

