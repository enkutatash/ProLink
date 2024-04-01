import 'package:flutter/material.dart';

class NewSkill extends StatefulWidget {
  final Function(String,String) onSkillAdded;
  NewSkill({ required this.onSkillAdded, Key? key})
      : super(key: key);

  @override
  _NewSkillState createState() => _NewSkillState();
}

class _NewSkillState extends State<NewSkill> {
  final TextEditingController newskill = TextEditingController();
  String level = "Beginner";

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New Skill'),
                content: StatefulBuilder(builder: (context, setState) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: newskill,
                      ),
                      ListTile(
                        title: Text('Beginner'),
                        // Define value property within ListTile
                        leading: Radio(
                          value: 'Beginner',
                          groupValue: level, // Group for radio buttons
                          onChanged: (value) =>
                              setState(() => level = value as String),
                        ),
                      ),
                      ListTile(
                        title: Text('Intermediate'),
                        // Define value property within ListTile
                        leading: Radio(
                          value: 'Intermediate',
                          groupValue: level,
                          onChanged: (value) =>
                              setState(() => level = value as String),
                        ),
                      ),
                      ListTile(
                        title: Text('Advanced'),
                        // Define value property within ListTile
                        leading: Radio(
                          value: 'Advanced',
                          groupValue: level,
                          onChanged: (value) =>
                              setState(() => level = value as String),
                        ),
                      ),
                    ],
                  );
                }),
                actions: [
                  TextButton(
                    onPressed: () {
                      print(newskill.text);
                      if (!newskill.text.isEmpty) {
                        _addSkill(newskill.text, level);
                        newskill.text = '';
                        level = "Beginner";
                      }
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(
          Icons.add_circle_outline_outlined,
          size: 30,
        ));
  }

  void _addSkill(String newSkill, String level) {
    // Add the new skill to the user's profile
    // Example: Call Firestore API to add skill
    // Assuming the skill is successfully added, call the callback
    widget.onSkillAdded(
      newSkill,level
    );
  }
}
