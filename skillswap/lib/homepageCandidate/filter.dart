import 'package:flutter/material.dart';

final List<String> items = [
  "All",
  'Flutter',
  'Node.js',
  'React Native',
  'Java',
  'Docker',
  'MySQL',
  "UI/UX",
  "Django",
  "React",
  "Machine Learning",
  "Artificial Intelligence",
  "Competitive Programming",
  "Project Management",
];


class Select extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const Select({
    required this.title,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap, // Call onTap callback
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(5),
          width: width * 0.2 + title.length * 3,
          height: height * 0.03,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0XFF2E307A)// Update border color based on selection
            ),
            color: isSelected
                ?Color(0XFF2E307A)
                : Color.fromARGB(255, 237, 241, 245), // Update background color based on selection
          ),
          child: Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,style: TextStyle(color:isSelected
                ?Colors.white
                : Colors.black ),
            ),
          ),
        ),
      ),
    );
  }
}
