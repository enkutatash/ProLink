import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/Search/projectdetailtojoin.dart';
import 'package:skillswap/widgets/buttons.dart';


class ProjectSearch extends StatelessWidget {
  Map<String, dynamic> projectdata;
  ProjectSearch(this.projectdata, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final UserController userController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProjectDetailJoin(projectdata: projectdata)));
        },
        child: Container(
            width: width,
            height: height * 0.45,
            decoration: BoxDecoration(
                // color: Color.fromARGB(255, 247, 248, 249),
                // borderRadius: BorderRadius.circular(20),
                // boxShadow: [
                //   BoxShadow(
                //     color:
                //         Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
                //     spreadRadius: 1, // Extends the shadow beyond the box
                //     blurRadius: 1, // Blurs the edges of the shadow
                //     offset: Offset(0, 1), // Shifts the shadow (x, y)
                //   ),
                // ],
                ),
            child: Stack(children: [
              Column(
                children: [
                  // ClipRRect(
                  //   borderRadius: const BorderRadius.only(
                  //     topLeft: Radius.circular(15.0),
                  //     topRight: Radius.circular(15.0),
                  //     bottomLeft: Radius.circular(0.0),
                  //     bottomRight: Radius.circular(0.0),
                  //   ),
                  //   child: Image.network(
                  //       height: height * 0.3,
                  //       width: width,
                  //       fit: BoxFit.cover,
                  //       projectdata['Projectimg']),
                  // ),

                  CachedNetworkImage(
                    imageUrl: projectdata['Projectimg'],
                    imageBuilder: (context, imageProvider) => Container(
                     height: height * 0.28,
                        width: width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  CachedNetworkImage(
                          imageUrl:  projectdata['Owner']['profilePic'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 30.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${projectdata['Owner']['First']} ${projectdata['Owner']['Last']}',
                                    //  "Alice Bob",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                '${projectdata['ProjectDes']}',
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        ButtonTwo("Join", Colors.white, Color(0XFF2E307A),
                            width * 0.08, height * 0.05, 12, () {}),
                      ],
                    ),
                  )
                ],
              ),
            ])),
      ),
    );
  }
}
