import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/firebase/firebase.dart';
import 'package:skillswap/homepageCandidate/Search/usersearch.dart';

class Search_Screen extends StatefulWidget {
  Search_Screen({super.key});

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  final TextEditingController _search = TextEditingController();
  late final Firebase_Service _auth;
  List _allUser = [];
  List _searchResult = [];
  allUser() async {
    var data = await FirebaseFirestore.instance
        .collection('Users')
        .orderBy('First')
        .get();
    setState(() {
      _allUser = data.docs;
    });
    searchResult();
  }

  searchResult() {
  var showResult = [];
  if (_search.text.isNotEmpty) {
    for (var u in _allUser) {
      List<Map<String, dynamic>> skills = List<Map<String, dynamic>>.from(u['Skills']);
      for (var skill in skills) {
        if (skill['skill'].toLowerCase().contains(_search.text.toLowerCase())) {
          showResult.add(u);
          break; // Exit the loop once a match is found for efficiency
        }
      }
    }
  } else {
    showResult = List.from(_allUser);
  }
  setState(() {
    _searchResult = showResult;
  });
}


  @override
  void initState() {
    // TODO: implement initState
    _search.addListener(_onSearch);
    allUser();
    _auth = Firebase_Service(context);
    super.initState();
  }

  _onSearch() {
    searchResult();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _search.removeListener(_onSearch);
    _search.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    allUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          controller: _search,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(child: Text("Users")),
                  InkWell(child: Text("Projects"))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> userdata =
                        _searchResult[index].data() as Map<String, dynamic>;
                    String userid = _allUser[index].id;
                    return UserSearch(userdata, userid);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
