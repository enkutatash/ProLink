import 'package:flutter/material.dart';

class UserSearch extends StatelessWidget {
  const UserSearch({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: height * 0.1,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Color(0XFF393939),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ),
              child: Image.network(
                  height: height * 0.1,
                  width: width * 0.2,
                  fit: BoxFit.cover,
                  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            ),
            SizedBox(width: width*0.02,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ana bob",style: TextStyle(color: Colors.white,fontSize: 20,),),
                  Text("I am passionate software engineer.I am passionate software engineer",style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
