import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({super.key});

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text("Job Detail"),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Icon(Icons.bookmark_border,size: 30,)
        ],
      ),
      body: SafeArea(
        child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50, 
              backgroundColor: Colors.white, 
              backgroundImage: AssetImage('asset/man.png'), ),
          ),
          Text("Silverstro Studio"),


        ],
      ),),
    );
  }
}
