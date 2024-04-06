import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/widgets/buttons.dart';

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
             CachedNetworkImage(
                          imageUrl:  projectdata['Projectimg'],
                          imageBuilder: (context, imageProvider) => Container(
                            height: height * 0.4,
                            width: width,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) =>CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 80,
                      height: 2,
                      //  color: Colors.black,
                    ),
                    const SizedBox(height: 8),
                    Text("${projectdata['ProjectTitle']}",style: TextStyle(fontSize: 30),),
                   
                    const SizedBox(height: 8),
                 Text('${projectdata['TimeStamp']}',style: TextStyle(fontSize: 13),),
                 const SizedBox(height: 8),
                 Text('${projectdata['ProjectDes']}',style: TextStyle(fontSize: 15),),
                    const SizedBox(height: 8),
                  
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
                    Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          "Required Skills",
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
                    Container(
                      padding: EdgeInsets.all(10),
                        height: 100,
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          
                        ),
                        child: ListView.builder(
                          itemCount: projectdata['SkillReq'].length,
                          itemBuilder: (context, index) {
                          return Text('${projectdata['SkillReq'][index]}');
                        })),
                  ],
                ),
              ),
            ]
            )
            )
                ]
            )
            ));
  }
}
