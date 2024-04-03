import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:skillswap/firebase/firebase.dart';

class ProjectController extends GetxController {
  final CollectionReference dbrefproject =
      FirebaseFirestore.instance.collection('Project');
  var _Projects = <Map<String, dynamic>>[].obs;
  
  ProjectController(List<dynamic> projectids) {
    _initializeProjects(projectids);
  }

  Future<void> _initializeProjects(List<dynamic> projectids) async {
    for (var p in projectids) {
      final projectData = await ProjectData(p);
      _Projects.add(projectData);
    }
  }

  Future<Map<String, dynamic>> ProjectData(String docid) async {
    try {
      DocumentSnapshot snapshot = await dbrefproject.doc(docid).get();
      if (snapshot.exists) {
        Map<String, dynamic> projectdata = snapshot.data() as Map<String, dynamic>;
        return projectdata;
      } else {
        return {}; // Return empty map if the document doesn't exist
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return {}; // Return empty map if there's an error
    }
  }

  get Project => _Projects;
}
