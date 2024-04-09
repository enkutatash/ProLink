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

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int _selected = 0;

  void setSelected(int index) {
    setState(() {
      _selected = index;
    });
    print(items[_selected]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return 
         Container(
          height: height * 0.07,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Select(
                title: items[index],
                isSelected: _selected == index,
                onTap: () => setSelected(index), // Pass callback function
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 5,
              );
            },
            itemCount: items.length,
          ),
    );
  }
}

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
