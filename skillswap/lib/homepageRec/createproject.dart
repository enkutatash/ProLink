import 'package:flutter/material.dart';
class CreateProjectPage extends StatefulWidget {
  const CreateProjectPage({super.key}) ;
  @override
  State<CreateProjectPage> createState() => _CreateProjectPageState();
}

class _CreateProjectPageState extends State<CreateProjectPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  List<String> _requiredSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed:() {},
              icon:const  Icon( Icons.arrow_back, ),),
              const SizedBox(width: 20,),
          const  Text("Create Project"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/createproject.png.png",
              width: double.infinity,
              fit:BoxFit.fill,),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Project Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a project title";
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _title = value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Project Description",
                  
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a project description";
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _description = value!),
              ),
              const SizedBox(height: 36.0),
              const Text("Required Skills (Optional)"),
              const SizedBox(height: 16.0),
              ChipFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Add Skills",
                ),
                initialValue: _requiredSkills,
                onChanged: (value) => setState(() {
                  _requiredSkills = value;
                }),
                validator: (value) => null,
                onDeleted: (chip) {
                  setState(() {
                    _requiredSkills.remove(chip);
                  });
                },
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("Project Title: $_title");
                    print("Project Description: $_description");
                    print("Required Skills: $_requiredSkills");
                    _formKey.currentState!.reset();
                    setState(() {
                      _title = "";
                      _description = "";
                      _requiredSkills = [];
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: const Color.fromARGB(255, 40, 42, 43),
              minimumSize: const Size(400.0, 50.0),
            ),
            
            child: const Text(
              'Create Project',
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromARGB(255, 230, 229, 227)),
            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChipFormField<T> extends FormField<List<T>> {
  ChipFormField({
    Key? key,
    required InputDecoration decoration,
    required List<T> initialValue,
    required ValueChanged<List<T>> onChanged,
    FormFieldValidator<List<T>>? validator,
    ValueChanged<T>? onDeleted,
  }) : super(
          key: key,
          initialValue: initialValue,
          validator: validator,
          onSaved: (value) => onChanged(value!),
          builder: (FormFieldState<List<T>> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(decoration.labelText ?? ""),
                Wrap(
                  children: [
                    for (var chip in state.value!)
                      Chip(
                        label: Text(chip.toString()),
                        onDeleted: onDeleted != null ? () => onDeleted(chip) : null,
                      ),
                    ActionChip(
                      label: const Text("Add"),
                      onPressed: () async {
                        // Show dialog to add a new chip
                        final newChip = await showDialog<T>(
                          context: state.context,
                          builder: (context) {
                            final _chipFormKey = GlobalKey<FormState>();
                            String newChipValue = "";
                            return SimpleDialog(
                              title: const Text("Add Skill"),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Form(
                                    key: _chipFormKey,
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        labelText: "Skill Name",
                                      ),
                                      onSaved: (value) {
                                        newChipValue = value ?? "";
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please enter a skill name.";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                ButtonBar(
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_chipFormKey.currentState!.validate()) {
                                          _chipFormKey.currentState!.save();
                                          Navigator.of(context).pop(newChipValue);
                                        }
                                      },
                                      child: const Text("Add"),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                        
                        if (newChip != null && newChip.toString().isNotEmpty) {
                          
                          state.setValue([...state.value!, newChip]);
                        }
                      },
                    ),
                  ],
                ),
                if (state.errorText != null)
                  Text(
                    state.errorText!,
                    style: TextStyle(color: Theme.of(state.context).colorScheme.error),
                  ),
              ],
            );
          },
        );
}
