import 'package:flutter/material.dart';

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _UpdatesState();
}

class _UpdatesState extends State<Jobs> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data for each page
  final List<Map<String, dynamic>> pagesData = [
    {
      'title': "New Job Post",
      'subtitle': "React",
      'description': "Apply",
      
    },
    {
      'title': "New Job Post",
      'subtitle': "Django",
      'description': "Apply",
      
    },
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SizedBox(
          height: height * 0.2,
          width: width * 0.9,
          child: PageView.builder(
            controller: _pageController,
            itemCount: pagesData.length, // Number of items in the PageView
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0XFF2E307A),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            pagesData[index]['title'],
                            style:const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            pagesData[index]['subtitle'],
                            style:const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            pagesData[index]['description'],
                            style:const TextStyle(color: Colors.white, fontSize: 20)
                          ),
                        ],
                      ),
                      // Image.asset(
                      //   pagesData[index]['imagePath'],
                      //   height: height * 0.18,
                      //   width: width*0.4,
                      //   fit: BoxFit.cover,
                      // ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
       
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pagesData.length, // Number of pages
            (index) => Container(
              margin:const EdgeInsets.all(4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? const Color(0XFF6055D8) : Colors.grey,
              ),
            ),
          ),
        ),
         Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: (){},
            child: Text("Show More..."))),
      ],
    );
  }
}