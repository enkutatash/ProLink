import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skillswap/Project/projectcontroller.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/widgets/buttons.dart';
import 'package:skillswap/widgets/skillsdropdown.dart';
import 'package:skillswap/homepageCandidate/personalproject.dart';

class CreateProjectPage extends StatefulWidget {
  Map<String, dynamic> userdata;
  final String userid;
  CreateProjectPage(this.userdata, this.userid, {Key? key}) : super(key: key);

  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _itemsNeededController;
  late final Firebase_Service _auth;
  ProjectController projectController = Get.put(ProjectController.empty());
  String? imagePath;
  File? _image;
  String? downloadUrl;
  List<String> _requiredSkills = [];

  @override
  void initState() {
    super.initState();
    _auth = Firebase_Service(context);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _itemsNeededController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _itemsNeededController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    // For mobile platforms, set the image directly
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
      // Upload the image to Firebase Storage
      await storageReference.putFile(_image!);

      // Retrieve the download URL of the uploaded image
      downloadUrl = await storageReference.getDownloadURL();
    } catch (e) {
      // Handle any errors that occur during the upload process
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Project'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Stack(children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: imagePath != null
                      ? FileImage(File(imagePath!))
                      :null,
                  child: imagePath == null ? Icon(Icons.person) : null,
                ),
                Positioned(
                    top: 45,
                    right: -10,
                    child:IconButton(
                              onPressed: pickImage,
                              icon: Image.asset(
                                width: 30,
                                height: 30
                                ,"asset/camera.png")
                              )
                        )
              ])),
              SizedBox(height: 20),

              FormText(text: "Project Title", alignment: Alignment.centerLeft),
              CustomTextFormField(width: width*0.9, height: height*0.06, hintText: 'Enter project title', controller: _titleController ),
              
              SizedBox(height: 20),
              FormText(text: "Project Description", alignment: Alignment.centerLeft),
              CustomTextFormFieldTwo(width: width*0.9, height: height*0.06, hintText: "Enter Project Description", controller: _descriptionController,keyboardType: TextInputType.emailAddress,maxLine: null,),
              
              SizedBox(height:5,),
              Dropdown(onItemsSelected:  (selectedItems) {
                    setState(() {
                      _requiredSkills = selectedItems;
                    });
                  }, skill: "Required Skills")
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ButtonTwo("Create Project", Colors.white, Color(0XFF2E307A), width*0.9, height*0.06, 15,  () {
              _auth.createProject(
                downloadUrl!,
                _titleController.text,
                _descriptionController.text,
                widget.userid,
                _requiredSkills,
                [],
              );
              projectController.addProject(
                  downloadUrl!,
                  _titleController.text,
                  _descriptionController.text,
                  widget.userid,
                  _requiredSkills,
                  []);
              Navigator.pop(context);
            },)
        ),
      ),
    );
  }
}
