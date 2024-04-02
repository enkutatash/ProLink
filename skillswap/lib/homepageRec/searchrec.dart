
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/Search/projectsearch.dart';
import 'package:skillswap/homepageCandidate/Search/usersearch.dart';


class SearchRec extends StatefulWidget {
  const SearchRec({super.key});

  @override
  State<SearchRec> createState() => _SearchRecState();
}

class _SearchRecState extends State<SearchRec> {
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  controller: _search,
                ),
                SizedBox(height: height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child:const Text(
                        "User",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Projects", style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
                UserSearch(),
                UserSearch(),
                ProjectSearch(),
                ProjectSearch()
              ],
            ),
          ),
        ));
  }
}
