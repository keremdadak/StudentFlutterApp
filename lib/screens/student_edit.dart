import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/student.dart';
import 'package:flutter_application_1/validation/student_validator.dart';

class StudentEdit extends StatefulWidget {
  Student selectedstudents;
  StudentEdit(Student selectedstudents){
    this.selectedstudents=selectedstudents;
  }
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState(selectedstudents);
  }
}

class _StudentAddState extends State<StudentEdit> with StudentValidationMixin {
 Student selectedstudents;
  
  var formKey=GlobalKey<FormState>();

  _StudentAddState(Student selectedstudents){
    this.selectedstudents=selectedstudents;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle"),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              buildFirstNameField(),
               buildLastNameField(),
                buildGradeField(),
                buildSubmitButton(),
              ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      initialValue: selectedstudents.firstName,
      decoration: InputDecoration(labelText: "Öğrenci Adı", hintText: "Kerem"),
      validator: validateFirstName,
      onSaved: (String value) {
        selectedstudents.firstName = value;
      },
    );
  }
   Widget buildLastNameField() {
    return TextFormField(
      initialValue: selectedstudents.lastName,
      decoration: InputDecoration(labelText: "Öğrenci Soyadı", hintText: "Dadak"),
      validator: validateLastName,
      onSaved: (String value) {
        selectedstudents.lastName = value;
      },
    );
  }
   Widget buildGradeField() {
    return TextFormField(
       initialValue: selectedstudents.grade.toString(),
      decoration: InputDecoration(labelText: "Aldığı Not", hintText: "65"),
      validator: validateGrade,
      onSaved: (String value) {
        selectedstudents.grade = int.parse(value);
      },
    );
  }

 Widget buildSubmitButton() {
   return RaisedButton(
     child: Text("Kaydet"),
     onPressed: (){
       if(formKey.currentState.validate()){
         formKey.currentState.save();
         saveStudent();
         
         Navigator.pop(context);
       }
     },
   );
  }

  void saveStudent() {
    print(selectedstudents.firstName);
    print(selectedstudents.lastName);
    print(selectedstudents.grade);

  }
}
