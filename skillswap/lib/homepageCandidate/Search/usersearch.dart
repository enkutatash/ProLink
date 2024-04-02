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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(
              width: 1.0,
              color: Colors.black, // Set the border color here
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(0.0),
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(0.0),
                ),
                child: Image.network(
                    height: height * 0.1,
                    width: width * 0.2,
                    fit: BoxFit.cover,
                    userdata['profilePic']),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print(userdata['Skills']);
                    _dialogBuilder(context, userdata);
                  },
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

Future<void> _dialogBuilder(BuildContext context, userdata) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('${userdata['First']} ${userdata['Last']}'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: userdata['Skills'].length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${userdata['Skills'][index]['skill']}'),
                      Text('${userdata['Skills'][index]['level']}')
                    ],
                  );
                }),
          ));
    },
  );
}