import 'package:flutter/material.dart';
import 'package:skillswap/widgets/buttons.dart';
import 'package:skillswap/widgets/skillimg.dart';
class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit',style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

// Implement a multi select on the Home screen

class Dropdown extends StatefulWidget {
  String skill;
  final void Function(List<String> selectedItems) onItemsSelected;
   Dropdown({required this.onItemsSelected, required this.skill, Key? key}) : super(key: key);

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  List<String> _selectedItems = [];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<String> items = [
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

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
      widget.onItemsSelected(_selectedItems);
    }
  }

  void _removeSelectedItem(String item) {
    setState(() {
      _selectedItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // use this button to open the multi-select dialog
       ButtonThree(widget.skill,Color(0XFF2E307A), Color.fromARGB(255, 237, 241, 245), width*0.9, height*0.06,_showMultiSelect),
        const Divider(
          height: 30,
        ),
        // display selected items
        Wrap(
          spacing: 8,
          
          children: _selectedItems
              .map((e) => Chip(
                backgroundColor: Colors.white,
                label: Text(""),
                  avatar: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(logomap[e]!), // Replace with your image URL
                  ),
                  deleteIcon: Icon(Icons.close),
                  deleteIconColor: Colors.red,
                  onDeleted: () {
                    _removeSelectedItem(e); // Remove item from the selected list
                  },
                )

                  )
              .toList(),
        )
      ],
    );
  }
}