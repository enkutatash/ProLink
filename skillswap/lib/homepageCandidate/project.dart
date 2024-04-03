import 'package:flutter/material.dart';

class Project extends StatelessWidget {
  Map<String, dynamic> projectdata;
  Project(this.projectdata, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width,
        height: height * 0.23,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 207, 210, 236),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
              spreadRadius: 2, // Extends the shadow beyond the box
              blurRadius: 5, // Blurs the edges of the shadow
              offset: Offset(0, 3), // Shifts the shadow (x, y)
            ),
          ],
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
                  width: width,
                  fit: BoxFit.cover,
                  projectdata['Projectimg']),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          '${projectdata['ProjectTitle']}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Text(
                          '${projectdata['ProjectDes']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Button("Detail", Colors.white, Color(0XFF2E307A), () {}),
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
