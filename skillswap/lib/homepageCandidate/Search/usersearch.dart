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
            color: Color.fromARGB(255, 207, 210, 236),
            boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color (with opacity)
        spreadRadius: 2, // Extends the shadow beyond the box
        blurRadius: 5, // Blurs the edges of the shadow
        offset: Offset(0, 3), // Shifts the shadow (x, y)
      ),
    ],
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