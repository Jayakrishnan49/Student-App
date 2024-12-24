import 'package:database_project_3_sqflite/db/models/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>>studentListNotifier=ValueNotifier([]);
late Database _db;


Future<void>initializeDataBase()async{
_db= await openDatabase(
  'student.db',version: 1,
onCreate: (Database db, int version)async{
  await db.execute(
    'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT,phno TEXT,image TEXT)');
});
}


Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
    'INSERT INTO student (name,age,phno,image) VALUES (?,?,?,?)',[value.name,value.age,value.phno,value.image]);
    getAllStudents();
}


Future<void>getAllStudents()async{
  final values=await _db.rawQuery('SELECT * FROM student');
  studentListNotifier.value.clear();
  for (var value in values) {
    final student= StudentModel.fromMap(value);
    studentListNotifier.value.add(student);   
  }
  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
  studentListNotifier.notifyListeners();
}


Future<void>deleteStudent(int id)async{           
  await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
 await getAllStudents();
}

Future<void>updateStudent(StudentModel value)async{
  await _db.rawUpdate('UPDATE Student SET name = ?,age = ?,image = ?,phno = ? WHERE id = ?',
  [
    value.name,
    value.age,
    value.image,
    value.phno,
    value.id
  ],
  );

  await getAllStudents();
}

Future<void> searchingStudent(String value) async {
  final students = await _db.query(
    'student',
    where: 'LOWER(name) LIKE ?',
    whereArgs: ['%${value.toLowerCase()}%'],
  );
  studentListNotifier.value =
      students.map((element) => StudentModel.fromMap(element)).toList();
}


