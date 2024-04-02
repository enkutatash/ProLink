import 'package:flutter/material.dart';
import 'package:skillswap/firebase/firebase.dart';

class Project extends StatefulWidget {
  String projectid;
 Project(this.projectid,{super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  late final  Map<String, dynamic> projectdetail;
  late final Firebase_Service _auth;

 @override
void initState() {
  super.initState();
  _fetchProjectData();
}

Future<void> _fetchProjectData() async {
  _auth = Firebase_Service(context);
  projectdetail = await _auth.ProjectData(widget.projectid);
  setState(() {}); // Update the UI after fetching data
}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width,
        height: height*0.23,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1.0, 
              color: Colors.black, // Set the border color here
            ),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
              child: Image.network(
                  height: height * 0.13,
                  width: width ,
                  fit: BoxFit.cover,
                  projectdetail['Projectimg']),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Expanded(
                  child:   Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       SizedBox(height: height*0.01,),
                      Text('${projectdetail['ProjectTitle']}',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: height*0.02,),
                  Text('${projectdetail['ProjectDes']}',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black),)
                    ],),
                ),
                
                  Button("Detail", Colors.white, Colors.black, (){}),
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}


class Button extends StatelessWidget {
  final String text;
  final Color btnclr;
  final Color textclr;
  final void Function() click;
  Button(this.text, this.textclr, this.btnclr, this.click, {super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: click,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Set border radius
          ),
        ),
        minimumSize: MaterialStateProperty.all(
            Size(width * 0.2, height * 0.04)), // Set width and height
        backgroundColor:
            MaterialStateProperty.all<Color>(btnclr), // Set color to red
      ),
      child: Text(
        text,
        style: TextStyle(color: textclr),
      ),
    );
  }
}

