
import 'dart:io';

import 'package:database_project_3_sqflite/about_student.dart';
import 'package:database_project_3_sqflite/db/functions/db_functions.dart';
import 'package:database_project_3_sqflite/db/models/data_model.dart';
import 'package:database_project_3_sqflite/update_student.dart';
import 'package:flutter/material.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (BuildContext ctx, List<StudentModel>studentList, Widget?child){
        if(studentList.isEmpty){
          return const Center(child: Text('Add student'),);
        }
        return ListView.separated(itemBuilder: (ctx, index){
          final data=studentList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:(context)=>AboutStudent(data: data)));
            },
            child: ListTile(
            title: Text(data.name),
            subtitle: Text(data.age),
            leading:CircleAvatar(
              backgroundImage:FileImage(File(data.image)) ,
            ) ,
            trailing:
            
            
             SizedBox(
              width: 100,
               child: Row(children: [
                IconButton(onPressed: (){
                      showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure want to update'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateStudent(
                                                              data: data,
                                                            )));
                                              },
                                              child: const Text('yes')),
                                        
                                      
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'))
                                          ],
                                          ),
                                    ],
                                  );
                                });
                }, icon: const Icon(Icons.edit))
                  , IconButton
                             (onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Are you sure want to delete'),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                               deleteStudent(data.id!);
                                               Navigator.pop(context);
                                              },
                                              child: const Text('yes')),
                                      
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'))
                                            ],
                                      ),
                                    ],
                                  );
                                });
                  
                 },
                 icon: const Icon(Icons.delete,
                 color: Colors.red,
                 )
                 ),
                 
               ]
             
               ),
             ),
            
                    ),
          );
      },
       separatorBuilder:(ctx, index){
        return const Divider();
      }, 
      itemCount: studentList.length,
      );
      },
  
    );
  }
}