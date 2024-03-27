import 'package:flutter/material.dart';

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
      title: const Text('Select Topics'),
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// Implement a multi select on the Home screen

class Dropdown extends StatefulWidget {
  final void Function(List<String> selectedItems) onItemsSelected;
  const Dropdown({ 
    required this.onItemsSelected,
    Key? key}) : super(key: key);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // use this button to open the multi-select dialog
        ElevatedButton(
          onPressed: _showMultiSelect,
          child: const Text('Select Your Skills'),
        ),
        const Divider(
          height: 30,
        ),
        // display selected items
        Wrap(
          children: _selectedItems
              .map((e) => Chip(
                    label: Text(e),
                    deleteIcon: Icon(Icons.close),
                    deleteIconColor: Colors.red,
                    onDeleted: () {
                      _removeSelectedItem(e); // Remove item from the selected list
                    },
                  ))
              .toList(),
        )
      ],
    );
  }
}