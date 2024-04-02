import 'package:flutter/material.dart';

class UserSearch extends StatelessWidget {
  Map<String, dynamic> userdata;
  String userid;

   UserSearch(  this.userdata,this.userid,
{super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: height * 0.1,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.white,
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
              SizedBox(width: width*0.02,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${userdata['First']} ${userdata['Last']}',style: TextStyle(fontSize: 20,),),
                    Text('${userdata['Bio']}',overflow: TextOverflow.ellipsis,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
