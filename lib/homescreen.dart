import 'package:database_project_3_sqflite/add_student_widget.dart';
import 'package:database_project_3_sqflite/db/functions/db_functions.dart';
import 'package:database_project_3_sqflite/grid_student_widget.dart';
import 'package:database_project_3_sqflite/list_student_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    getAllStudents();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Student Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: searchcontroller,
                onChanged: (value) {
                  searchingStudent(value);
                },
                decoration: const InputDecoration(
                    hintText: 'search',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(icon:Icon(Icons.list),),
                Tab(icon: Icon(Icons.grid_view),)
      
            ]),
            const Expanded(
              child: TabBarView(children: [
                ListStudentWidget(),
                // Center(child: Text('grid'),)
                GridStudentWidget()
              ]),
            )
            // const Expanded(child: ListStudentWidget()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddStudentWidget()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
