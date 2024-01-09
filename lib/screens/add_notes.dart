import 'package:flutter/material.dart';
import 'package:notesapp/local_db.dart';
import 'package:notesapp/screens/home_screen.dart';

class AddNotes extends StatelessWidget {
  AddNotes({super.key});
  final Sqldb sqldb = Sqldb();
  final GlobalKey formstate = GlobalKey();
  final TextEditingController color = TextEditingController();
  final TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add notes"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formstate,
          child: Column(
            children: [
              SizedBox(height: 100),
              TextFormField(
                controller: color,
                decoration: InputDecoration(hintText: "color"),
              ),
              TextFormField(
                controller: note,
                decoration: InputDecoration(hintText: "note"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.orange),
                ),
                onPressed: () async {
                  int response = await sqldb.insertdata(
                      "INSERT INTO notes ('note' , 'color') VALUES ('${color.text}','${note.text}')");

                  if (response > 0) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homescreen(),
                        ),
                        (route) => false);
                  }
                },
                child: Text("add note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
