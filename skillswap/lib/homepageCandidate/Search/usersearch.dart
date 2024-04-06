import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/Search/persondetail.dart';

class UserSearch extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

  UserSearch(this.userdata, this.userid, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PersonalDetail(userdata, userid)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height * 0.1,
          width: width,
          child: Row(
            children: [
            
              CachedNetworkImage(
                          imageUrl:  userdata['profilePic'],
                          imageBuilder: (context, imageProvider) => Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          placeholder: (context, url) => Icon(Icons.person),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
              SizedBox(
                width: width * 0.02,
              ),
              Expanded(
                child: InkWell(
                  // onTap: () {
                  //  _dialogBuilder(context, userdata);
                  // },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${userdata['First']} ${userdata['Last']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${userdata['Bio']}',
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

