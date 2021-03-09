import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/student_add.dart';
import 'package:flutter_application_1/screens/student_edit.dart';
import 'models/student.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState(); 
}
class _MyAppState extends State<MyApp> {
  String mesaj = "Öğrenci Takip Sistemi";

  Student selectedStudent=Student.withId(0,"","",0);

  List<Student> students = [
    new Student.withId(1,"Kerem", "Dadak", 70),
    Student.withId(2,"Kuzey", "Efe", 25),
    Student.withId(3,"İsim", "Soyad", 40)
  ];

 // var ogrenciler = ["Kerem Dadak", "Uğur Soyad", "Mehmet Soyad", "Murat Soyad"];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(mesaj),
        ),
        body: buildBody(context));
  }

  // String sinavHesapla(int puan) {
  //   String mesaj2 = "";
  //   if (puan >= 50) {
  //     mesaj2 = "Geçti";
  //   } else if (puan >= 40) {
  //     mesaj2 = "Büte Kaldı";
  //   } else {
  //     mesaj2 = "Kaldı";
  //   }
  //   return mesaj2;
  // }

  void mesajGoster(BuildContext context, String mesaj2) {
    var alert = AlertDialog(
      title: Text("İşlem Sonucu"),
      content: Text(mesaj2),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  //return Text(students[index].firstName);
                  return ListTile(
                    leading: CircleAvatar(backgroundImage:NetworkImage("https://cdn.pixabay.com/photo/2016/01/19/17/53/writing-1149962_960_720.jpg") ,
                    ),             
                    title: Text(students[index].firstName + " " + students[index].lastName),
                    subtitle: Text("Sınavdan aldığı not :" +students[index].grade.toString()+"["+students[index].getStatus+"]"),
                    trailing: buildStatusIcon(students[index].grade),   
                    onTap: (){
                      setState(() {
                      selectedStudent=students[index];
                                              
                                            });
                      print(selectedStudent.firstName);
                    },
                  );                
                })
            // child: ListView(
            //   children: <Widget>[
            //     Text("Kerem Dadak"),
            //     Text("İsim Soyisim"),
            //     Text("Soyisim İsim"),
            //   ],
            // ),
            ),
        Text("Seçili Öğrenci:"+selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color:Colors.amberAccent,
            child: Row(
              children: [
                Icon(Icons.add),
                SizedBox(width: 5.0,),
                Text("Yeni Öğrenci"),
              ],
            ),
            onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentAdd(students)));
            },
            ),
            ),
              Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color:Colors.greenAccent,
            child: Row(
              children:<Widget> [
                Icon(Icons.update),
                SizedBox(width: 5.0,),
                Text("Güncelle"),
              ],
            ),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>StudentEdit(selectedStudent)));
            },
            ),
            ),
              Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: RaisedButton(
                color:Colors.cyanAccent,
            child: Row(
              children: [
                Icon(Icons.delete),
                SizedBox(width: 5.0,),
                Text("Sil"),
              ],
            ),
            onPressed: () {
              setState(() {
              students.remove(selectedStudent);
                            });
                var mesajj = "Silindi : "+selectedStudent.firstName;
              mesajGoster(context, mesajj);
            },
            ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }
}
