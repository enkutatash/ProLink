import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/widgets/buttons.dart';
import 'package:file_picker/file_picker.dart';

class RequestPage extends StatefulWidget {
  Map<String, dynamic> projectdata;
  RequestPage(this.projectdata, {super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final UserController userController = Get.find();
  List<String> selectedSkills = [];
  late File _file;
  late String _filePath;
  late String _downloadUrl;
  PlatformFile? pickedfile;
  UploadTask? uploadTask;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          File file = File(result.files.single.path!);
        } else {
          // User canceled the picker
        }
  }

  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List skills = widget.projectdata['SkillReq'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(CupertinoIcons.arrow_left, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('${widget.projectdata['ProjectTitle']}'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const FormText(
                text: "Why do you want to apply?",
                alignment: Alignment.centerLeft),
            CustomTextFormFieldTwo(
              width: width * 0.9,
              height: height * 0.06,
              hintText: "Message",
              controller: message,
              maxLine: null,
            ),
            const FormText(
                text: "Upload your CV here", alignment: Alignment.centerLeft),
            Row(
              children: [
                Upload(
                    Icons.upload,
                    "Send",
                    Color(0XFF2E307A),
                    Color.fromARGB(255, 237, 241, 245),
                    width * 0.4,
                    height * 0.05,
                    17, () {
                  pickFile();
                }),
                pickedfile != null
                    ? Text(pickedfile!.name)
                    : Text("No file selected")
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Apply for',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final item = skills[index];
                  return CheckboxListTile(
                    title: Text(item),
                    value: selectedSkills.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedSkills.add(item);
                        } else {
                          selectedSkills.remove(item);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonTwo("Send", Colors.white, Color(0XFF2E307A),
                  width * 0.45, height * 0.05, 17, () {
                print(selectedSkills);
                print(message.text);
                Navigator.pop(context);
              }),
            )
          ],
        ),
      ),
    );
  }
}
