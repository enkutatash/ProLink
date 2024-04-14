import 'package:flutter/material.dart';
import 'package:skillswap/homepageCandidate/home/Job/application.dart';
import 'package:skillswap/widgets/buttons.dart';

class JobDetail extends StatefulWidget {
  const JobDetail({super.key});

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  List<bool> _isSelected = [true, false]; // Track button selection

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.jumpToPage(index);

      // Update button selection
      _isSelected = List.generate(_isSelected.length, (i) => i == index);
    });
  }

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
          Icon(
            Icons.bookmark_border,
            size: 30,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('asset/man.png'),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text("Silverstro Studio"),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Full Time"),
              SizedBox(
                width: width * 0.02,
              ),
              Text("Place")
            ],
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonOne(
                  "Description",
                  _isSelected[0] ? Colors.white : Color(0XFF2E307A),
                  _isSelected[0] ? Color(0XFF2E307A) : Colors.white,
                  width * 0.4,
                  height * 0.05,
                  14, () {
                _onItemTapped(0);
              }),
              SizedBox(
                width: width * 0.02,
              ),
              ButtonOne(
                  "Requirement",
                  _isSelected[1] ? Colors.white : Color(0XFF2E307A),
                  _isSelected[1] ? Color(0XFF2E307A) : Colors.white,
                  width * 0.4,
                  height * 0.05,
                  14, () {
                _onItemTapped(1);
              }),
            ],
          ),
          SizedBox(
            height: height*0.45,
            child: Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                    _isSelected =
                        List.generate(_isSelected.length, (i) => i == index);
                  });
                },
                children: [
                  buildDescription("description"),
                  buildRequirement("requirement"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(
                  "Salary Range",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: width * 0.03,
                ),
                Text("3000", style: TextStyle(fontSize: 20))
              ],
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          ButtonOne("Apply Now", Colors.white, Color(0XFF2E307A), width * 0.8,
              height * 0.07, 16, () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => JobApplication()));
          })
        ],
      ),
    );
  }
  Widget buildDescription(String description) {
  return Expanded(
    child: Container(
      // height:MediaQuery.of(context).size.height*0.6 ,
      child: Center(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black, // Customize bullet color here
                  radius: 4, // Adjust bullet size as needed
                ),
                title: Text("description"),
              );
            }),
      ),
    ),
  );
}

Widget buildRequirement(String requirement) {
  return Expanded(
    child: Container(
      //  height:MediaQuery.of(context).size.height*0.6 ,
      child: Center(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black, // Customize bullet color here
                  radius: 4, // Adjust bullet size as needed
                ),
                title: Text("requirement"),
              );
            }),
      ),
    ),
  );
}
}




