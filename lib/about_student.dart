import 'dart:io';

import 'package:database_project_3_sqflite/db/models/data_model.dart';
import 'package:flutter/material.dart';

class AboutStudent extends StatelessWidget {
  final StudentModel data;
  const AboutStudent({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('About',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
        // centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            CircleAvatar(
              backgroundImage: FileImage(File(data.image)),
              radius: 150,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(data.name,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
             const SizedBox(
              height: 20,
            ),
            Text(data.age,style: const TextStyle(fontSize: 20),),
             const SizedBox(
              height: 10,
            ),
            Text(data.phno,style: const TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}