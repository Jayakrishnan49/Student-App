import 'dart:io';
import 'package:database_project_3_sqflite/db/functions/db_functions.dart';
import 'package:database_project_3_sqflite/db/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phnocontroller = TextEditingController();
  // final _parentNamecontroller= TextEditingController();

  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Add student details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      height: 250,
                      width: 250,
                      child: image != null
                          ? Image.file(File(image!))
                          : const Center(
                              child: Text('Upload image'),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cameraImage();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.camera,
                                        size: 50,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        galleryImage();
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        size: 50,
                                      ))
                                ],
                              ),
                            );
                          }
                          );
                    },
                    label: const Text('upload image'),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter the name';
                      }
                      return null;
                    },
                    
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter the age';
                      }
                      return null;
                    },
                     inputFormatters: [
                    LengthLimitingTextInputFormatter(2),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _phnocontroller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ph no:',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'enter the phone  Number';
                      }
                      return null;
                      
                    },
                    inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    
                  ),
                  // TextFormField(
                  //   controller: _parentNamecontroller,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'parent name:',
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'enter parent name';
                  //     }
                  //     return null;
                      
                  //   },
                  // //   inputFormatters: [
                  // //   LengthLimitingTextInputFormatter(10),
                  // //   FilteringTextInputFormatter.digitsOnly,
                  // // ],
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if(formKey.currentState!.validate() &&
                      _imageValidation()){
                        
                        onAddStudentButtonClicked();
                        Navigator.pop(context);
                      }
                    },
                    label: const Text('Add student'),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked() async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final phno = _phnocontroller.text.trim();
    // final parent=_parentNamecontroller.text.trim();
    if (name.isEmpty || age.isEmpty || phno.isEmpty) {
      return;
    }
    else {
      final student =
          StudentModel(name: name, age: age, phno: phno, image: image!);
      addStudent(student);
    }
  }
  // ----------------------------image getting functions------------------------------------

  Future galleryImage() async {
    final imageTaken =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageTaken == null) {
      return;
    } else {
      setState(() {
        image = imageTaken.path;
      });
    }
  }

  Future cameraImage() async {
    final imageTaken =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageTaken == null) {
      return;
    } else {
      setState(() {
        image = imageTaken.path;
      });
    }
  }
  bool _imageValidation() {
    if (image == null || image!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'please select an image',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }
}
