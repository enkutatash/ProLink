import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateProjectPage extends StatefulWidget {
  @override
  _CreateProjectPageState createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _itemsNeededController;
  String? _backgroundImagePath;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Project'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () async {
                  PermissionStatus status = await Permission.photos.request();
                  if (status.isGranted) {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        _backgroundImagePath = pickedFile.path;
                        print("Background Image Path: $_backgroundImagePath");
                      });
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Permission denied'),
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _backgroundImagePath != null
                            ? null
                            : Colors.grey[300],
                        image: _backgroundImagePath != null
                            ? DecorationImage(
                                image: FileImage(File(_backgroundImagePath!)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _backgroundImagePath == null
                          ? Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey[600],
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[600],
                        ),
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              _backgroundImagePath = pickedFile.path;
                              print(
                                  "Background Image Path: $_backgroundImagePath");
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Project Title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter project title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Project Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter project description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 29, 58, 84),
              ),
            ),
            child: Text(
              'Create Project',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreateProjectPage(),
  ));
}
