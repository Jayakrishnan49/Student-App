// import 'package:database_project_2_hive/db/functions/db_functions.dart';
// import 'package:database_project_2_hive/db/models/data_model.dart';
import 'dart:io';

import 'package:database_project_3_sqflite/db/functions/db_functions.dart';
import 'package:database_project_3_sqflite/db/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateStudent extends StatefulWidget {
  final StudentModel data;
  const UpdateStudent({super.key, required this.data});

  @override
  State<UpdateStudent> createState() => _UpdateStudentstate();
}

class _UpdateStudentstate extends State<UpdateStudent> {
  var _nameController=TextEditingController();

  var _ageController=TextEditingController();

  var _phnocontroller=TextEditingController();
  
   String? image;
   String? newImage;
   int? id;
   final formKey=GlobalKey<FormState>();
   
   @override
   void initState(){
    _nameController=TextEditingController(text: widget.data.name);
    _ageController= TextEditingController(text: widget.data.age);
    _phnocontroller= TextEditingController(text: widget.data.phno);
    image=widget.data.image;
    id= widget.data.id;
    super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Update student details',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SafeArea(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                    height: 250,
                    width: 250,
                    child:image!=null
                    ?Image.file(File(image!))
                    :const Center(
                      child: Text('Upload image'),
                    ),
                    ),
        
                  ),
                
                const SizedBox(
                  height:20,
                  width: 20,
                ),
                ElevatedButton.icon(onPressed: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(onPressed: (){
                              cameraImage();
                              Navigator.pop(context);
                            }, icon:const Icon(Icons.camera ,size:50,)),
                            IconButton(onPressed: (){
                              galleryImage();
                               Navigator.pop(context);
                            }, icon: const Icon(Icons.image,size: 50,))
                          ],
        
                        ),
        
                      );
                    }
                 
                   );
                }, label: const Text('upload image'),
                icon: const Icon(Icons.add_a_photo),),
               const SizedBox(
                  height:20,
                  width: 20,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                  ),
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
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(onPressed: (){
                onupdateStudentButtonClicked();
                Navigator.pop(context);
                  
                },
                label: const Text('Update'),
                icon: const Icon(Icons.update),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void>onupdateStudentButtonClicked()async{
    final name= _nameController.text.trim();
    final age= _ageController.text.trim();
     final phno= _phnocontroller.text.trim();
    if(name.isEmpty || age.isEmpty ||phno.isEmpty){
      return;
    }
    // print('$_name $_age');
    else{
      final student= StudentModel(id:id,name: name, age: age, phno: phno ,image: image!,);
      updateStudent(student);
    }
  }
            // ----------------------------image getting functions------------------------------------

  Future galleryImage()async{
    final imageTaken= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageTaken==null){
      return;
    }
    else{
      setState(() {
        image=imageTaken.path;
      }); 
    }
  }

  Future cameraImage()async{
    final imageTaken= await ImagePicker().pickImage(source: ImageSource.camera);
    if(imageTaken==null){
      return;
    }
    else{
      setState(() {
        image=imageTaken.path;
      });
    }
  }

}