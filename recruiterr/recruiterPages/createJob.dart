import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/firebase.dart';
import '../Project/userdata.dart';
import '../Project/projectcontroller.dart';
import '../widgets/buttons.dart';

class PostJobForm extends StatefulWidget {
  const PostJobForm({Key? key}) : super(key: key);

  @override
  State<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends State<PostJobForm> {
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final _jobtitleController = TextEditingController();
  final _jobdescriptionController = TextEditingController();
  final _requirementcontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _salaryrangecontroller = TextEditingController();
  late final UserController usercontroller;
  late final ProjectController projectController;
  late final Firebase_Service _auth;
  List<String> _selectedSkills = [];
  bool _isLoading = false;

  bool _obscureText = true;
  String? imagePath;
  File? _image;
  String? downloadUrl;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    setState(() {
      imagePath = imageTemp.path;
      _image = imageTemp;
    });
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}.jpg');

    try {
      await storageReference.putFile(_image!);

      downloadUrl = await storageReference.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _auth = Firebase_Service(context);
    usercontroller = Get.put(UserController());
    projectController = Get.put(ProjectController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Create Job Posting',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        backgroundImage: imagePath != null
                            ? FileImage(File(imagePath!))
                            : null,
                        child: imagePath == null
                            ? Icon(
                                Icons.person,
                                size: 50,
                              )
                            : null,
                      ),
                      Positioned(
                        top: 45,
                        right: -10,
                        child: IconButton(
                          onPressed: pickImage,
                          icon: Image.asset(
                            "asset/camera.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                  text: "Job Title",
                  alignment: Alignment.centerLeft,
                ),
                CustomTextFormField(
                  width: width * 0.9,
                  height: height * 0.06,
                  hintText: "Job Title",
                  controller: _jobtitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Job Title';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                  text: "Job Description",
                  alignment: Alignment.centerLeft,
                ),
                CustomTextFormField(
                  width: width * 0.9,
                  height: height * 0.06,
                  hintText: "Job Description",
                  controller: _jobdescriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Job Description';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                  text: "Requirements",
                  alignment: Alignment.centerLeft,
                ),
                CustomTextFormField(
                  width: width * 0.9,
                  height: height * 0.06,
                  hintText: "Requirements",
                  controller: _requirementcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Requirements';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                  text: "Location",
                  alignment: Alignment.centerLeft,
                ),
                CustomTextFormField(
                  width: width * 0.9,
                  height: height * 0.06,
                  hintText: "Location",
                  controller: _locationcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Location';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                  text: "Salary Range",
                  alignment: Alignment.centerLeft,
                ),
                CustomTextFormField(
                  width: width * 0.9,
                  height: height * 0.06,
                  hintText: "Salary Range",
                  controller: _salaryrangecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Salary Range';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                ButtonTwoLoading(
                  "Post",
                  Colors.white,
                  Color(0XFF2E307A),
                  width * 0.8,
                  height * 0.07,
                  16,
                  () {
                    if (_formKey.currentState!.validate() && !_isLoading) {
                      // form is valid, submit the form
                      _postJob();
                    }
                  },
                  _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postJob() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String userId = _authentication.currentUser!.uid;

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Recruiter')
          .doc(userId)
          .get();

      String companyName = userSnapshot.get('CompanyName');

      await _auth.addJobPost(
        _jobtitleController.text,
        _jobdescriptionController.text,
        _requirementcontroller.text,
        _locationcontroller.text,
        _salaryrangecontroller.text,
        downloadUrl ?? "",
        userId,
        companyName,
      );

      _formKey.currentState!.reset();
      setState(() {
        _isLoading = false;
        imagePath = null;
        _image = null;
        downloadUrl = null;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Job post created successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error posting job: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error posting job. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        _isLoading = false;
      });
    }
  }
}
