import 'package:flutter/material.dart';
import 'package:notesapp/local_db.dart';
import 'package:notesapp/screens/edite_notes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Sqldb sqldb = Sqldb();
  List notes = [];

  Future getdatafromdb() async {
    List<Map> response = await sqldb.getdata("SELECT * FROM notes");
    notes.addAll(response);
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getdatafromdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff023047),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffffb703),
          onPressed: () {
            Navigator.pushNamed(context, "addnotes");
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        backgroundColor: Color(0xffffb703),
        title: Text("notes with sqldb"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            MaterialButton(
                height: 40,
                color: Color(0xff8ecae6),
                onPressed: () async {
                  await sqldb.deletemydatabase();
                },
                child: Text("delete data base")),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xff8ecae6),
                  child: ListTile(
                    title: Text(
                      "${notes[index]['note']}",
                      style: TextStyle(color: Color(0xff023047)),
                    ),
                    subtitle: Text(
                      "${notes[index]['color']}",
                      style: TextStyle(color: Color(0xff023047)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              int response = await sqldb.deletedata(
                                  "DELETE FROM notes WHERE id = ${notes[index]['id']}");
                              if (response > 0) {
                                setState(() {
                                  notes.removeWhere((element) =>
                                      element['id'] == notes[index]['id']);
                                });
                              }
                            },
                            icon: Icon(Icons.delete, color: Color(0xfffb8500))),
                        IconButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Editenote(
                                    color: notes[index]['color'],
                                    note: notes[index]['note'],
                                    id: notes[index]['id'],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit, color: Colors.blue)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
