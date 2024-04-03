import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  Map<String, dynamic> projectdata;
  ProjectDetailPage({super.key, required this.projectdata});

  @override
  Widget build(BuildContext context) {
    // Fetch project details based on the profileId here
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text('${projectdata['ProjectTitle']}'),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.circular(0.0),
                  bottomRight: Radius.circular(0.0),
                ),
                child: Image.network(
                    height: height * 0.2,
                    width: width,
                    fit: BoxFit.cover,
                    projectdata['Projectimg']),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 80,
                      height: 2,
                      //  color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Project Title',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 207, 210, 236),
                      ),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          // initialValue: 'Project Title', // Replace with fetched data
                          initialValue: '${projectdata['ProjectTitle']}',
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      //  color: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Time Stamp',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 207, 210, 236),
                      ),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          // initialValue: 'Project Duration', // Replace with fetched data
                          initialValue: '${projectdata['TimeStamp']}',
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      //   color: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Project Description',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 207, 210, 236),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextFormField(
                          //  initialValue: 'Project Description', // Replace with fetched data
                          initialValue: '${projectdata['ProjectDes']}',
                          readOnly: true,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 80,
                            height: 2,
                            //  color: Colors.black,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Required Skill',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                        height: 100,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 207, 210, 236),
                        ),
                        child: ListView.builder(
                          itemCount: projectdata['SkillReq'].length,
                          itemBuilder: (context, index) {
                          return Text('${projectdata['SkillReq'][index]}');
                        })),
                  ],
                ),
              ),
            ])));
  }
}
