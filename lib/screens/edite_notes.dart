import 'package:flutter/material.dart';
import 'package:notesapp/local_db.dart';
import 'package:notesapp/screens/home_screen.dart';

class Editenote extends StatefulWidget {
  final color;
  final note;
  final id;

  Editenote({super.key, this.color, this.note, this.id});

  @override
  State<Editenote> createState() => _EditenoteState();
}

class _EditenoteState extends State<Editenote> {
  Sqldb sqldb = Sqldb();
  GlobalKey formstate = GlobalKey();
  TextEditingController color = TextEditingController();
  TextEditingController note = TextEditingController();
  @override
  void initState() {
    color.text = widget.color;
    note.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edite note"),
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
                  int response = await sqldb.updatedata('''
                      UPDATE notes SET 
                      note = "${note.text}" ,
                      color ="${color.text}"
                      WHERE id = ${widget.id}
                      ''');
                  if (response > 0) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homescreen(),
                        ),
                        (route) => false);
                  }
                },
                child: Text("edite note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
