import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Detail"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
    );
  }
}
