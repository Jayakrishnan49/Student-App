


class StudentModel{

  int? id;

  final String name;

  final String age;

  final String phno;

  final String image;
  // final String parent;

  StudentModel({required this.name, required this.age, required this.phno, required this.image, this.id});

  static StudentModel fromMap(Map<String, Object?>map){
    final id=map['id'] as int;
    final name=map['name'] as String;
    final age=map['age'] as String;
    final phno=map['phno'] as String;
    final image=map['image'] as String;
    // final parent=map['parent'] as String;

    return StudentModel(id: id, name: name, age: age, phno: phno, image:image);
  }
}