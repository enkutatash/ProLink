import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/Project/userdata.dart';
import 'package:skillswap/homepageCandidate/home/homepage.dart';
// import 'package:skillswap/homepageCandidate/homepage.dart';
// import 'package:skillswap/homepageCandidate/homescreen.dart';
import 'package:skillswap/widgets/buttons.dart';

class CompleteProject extends StatefulWidget {
  String title;
  List<dynamic> teams;
  String projectid;
  CompleteProject(this.title, this.teams, this.projectid, {super.key});

  @override
  State<CompleteProject> createState() => _CompleteProjectState();
}

class _CompleteProjectState extends State<CompleteProject> {
  UserController userController = UserController();
  Map<String, int> ratings = {};
  final FirebaseAuth _authentication = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.teams.length,
                itemBuilder: (context, index) {
                  String teamMemberId = widget.teams[index];
                  return StreamBuilder<DocumentSnapshot>(
                    stream: userController.getuserdata(teamMemberId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        if (snapshot.hasData && snapshot.data!.exists) {
                          // Document exists, use its data
                          var userData = snapshot.data!.data();
                          return Rate(
                              userData as Map<String, dynamic>, teamMemberId);
                        } else {
                          return Text('User data not found');
                        }
                      }
                    },
                  );
                },
              ),
            ),
            ButtonTwo("Rate", Colors.white, Color(0XFF2E307A), 100, 40, 20, () {
              rateTeams();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Homepage(_authentication.currentUser!.uid)),
                (route) => false,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget Rate(final Map<String, dynamic> userdata, final String teamMemberId) {
    int selectedStars =
        ratings[teamMemberId] ?? 0; // Use stored rating or default to 0
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: userdata['profilePic'],
              imageBuilder: (context, imageProvider) => Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => Icon(Icons.person),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Row(
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    setState(() {
                      selectedStars = index + 1;
                      ratings[teamMemberId] = selectedStars;
                    });
                  },
                  icon: Icon(
                    index < selectedStars ? Icons.star : Icons.star_border,
                    color: index < selectedStars ? Colors.amber : null,
                  ),
                ),
              ),
            ),
          ],
        ),
        Text('${userdata['First']} ${userdata['Last']}'),
      ],
    );
  }

  void rateTeams() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final proRef = firestore.collection('Project').doc(widget.projectid);
  final userRef = firestore.collection('Users');
  final completedRef = firestore.collection('CompletedProjects'); 

  final docSnapshot = await proRef.get();
  final data = docSnapshot.data();

  await firestore.collection("CompletedProjects").doc(widget.projectid).set(data!);
  firestore.collection('Project').doc(widget.projectid).delete(); 

  ratings.forEach((key, value) async {
    await userRef.doc(key).update({
      'WorkingOnPro': FieldValue.arrayRemove([widget.projectid])
    });

    await userRef.doc(key).update({
      'CompletedProject': FieldValue.arrayUnion([
        {
          'projectId': widget.projectid,
          'rate': value
        }
      ])
    });
  });

  // Remove from the owner's WorkingOnPro list
  await userRef.doc(_authentication.currentUser!.uid).update({
    'MyProjects': FieldValue.arrayRemove([widget.projectid])
  });

  // Add to the owner's CompletedProject list
  await userRef.doc(_authentication.currentUser!.uid).update({
    'CompletedProject': FieldValue.arrayUnion([
      {
        'projectId': widget.projectid,
        'rate': 6 // Assuming 6 is the owner's rating
      }
    ])
  });
}

}
