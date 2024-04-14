import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillswap/widgets/buttons.dart';
import '../Project/projectcontroller.dart';
import 'package:get/get.dart';

class PostJobForm extends StatefulWidget {
  final String initialId;
  final dynamic initialImage;
  final String initialTitle;
  final String initialDescription;
  final String initialRequirements;
  final String initialLocation;
  final String initialSalaryRange;

  const PostJobForm({
    Key? key,
    required this.initialId,
    required this.initialImage,
    required this.initialTitle,
    required this.initialDescription,
    required this.initialRequirements,
    required this.initialLocation,
    required this.initialSalaryRange,
  }) : super(key: key);

  @override
  State<PostJobForm> createState() => _PostJobFormState();
}

class _PostJobFormState extends State<PostJobForm> {
  ProjectController projectController = Get.put(ProjectController());
  String? imagePath;
  File? _image;
  String? downloadUrl;
  List<String> _requiredSkills = [];
  bool _isLoading = false;

  final _jobtitleController = TextEditingController();
  final _jobdescriptionController = TextEditingController();
  final _requirementcontroller = TextEditingController();
  final _locationcontroller = TextEditingController();
  final _salaryrangecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _jobtitleController.text = widget.initialTitle;
    _jobdescriptionController.text = widget.initialDescription;
    _requirementcontroller.text = widget.initialRequirements;
    _locationcontroller.text = widget.initialLocation;
    _salaryrangecontroller.text = widget.initialSalaryRange;
    super.initState();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemp = File(image.path);
    setState(() {
      _image = imageTemp;
    });

    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now()}.jpg');

    try {
      await storageReference.putFile(_image!);
      downloadUrl = await storageReference.getDownloadURL();

      print('Download URL: $downloadUrl');

      _postJob();
    } catch (e) {
      print('Error uploading image: $e');
    }
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
            key: _formKey, // Added key for form validation
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Edit Job Post Detail',
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
                  child: Stack(children: [
                    CircleAvatar(
                      radius: 40.0,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : (widget.initialImage != null
                              ? NetworkImage(widget.initialImage)
                              : null),
                      child: _image == null && widget.initialImage == null
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
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                        ),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                const FormText(
                    text: "Job Title", alignment: Alignment.centerLeft),
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
                    text: "Job Description", alignment: Alignment.centerLeft),
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
                    text: "Requirements", alignment: Alignment.centerLeft),
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
                    text: "Location", alignment: Alignment.centerLeft),
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
                    text: "Salary Range", alignment: Alignment.centerLeft),
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
                ButtonTwoLoading("Update", Colors.white, Color(0XFF2E307A),
                    width * 0.8, height * 0.07, 16, () {
                  if (_formKey.currentState!.validate()) {
                    _postJob();
                  }
                }, _isLoading),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _postJob() {
    // Update Firestore document with new values
    Map<String, dynamic> dataToUpdate = {
      'title': _jobtitleController.text,
      'description': _jobdescriptionController.text,
      'requirements': _requirementcontroller.text,
      'location': _locationcontroller.text,
      'salaryRange': _salaryrangecontroller.text,
    };

    if (downloadUrl != null) {
      dataToUpdate['image'] = downloadUrl!;
    }

    FirebaseFirestore.instance
        .collection('JobPosts')
        .doc(widget.initialId)
        .update(dataToUpdate)
        .then((_) {
      // Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Job post updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }).catchError((error) {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update job post: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
