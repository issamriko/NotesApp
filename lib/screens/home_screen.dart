import 'package:flutter/material.dart';
import 'package:notesapp/local_db.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Sqldb sqldb = Sqldb();
  bool isloading = true;
  List notes = [];

  Future getdatafromdb() async {
    List<Map> response = await sqldb.getdata("SELECT * FROM notes");
    notes.addAll(response);
    isloading = false;
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
      backgroundColor: Colors.blue.shade400,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "addnotes");
          },
          child: Icon(Icons.add)),
      appBar: AppBar(
        title: Text("notes with sqldb"),
      ),
      body: Container(
        child: ListView(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await sqldb.deletemydatabase();
                },
                child: Text("delete data base")),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${notes[index]['note']}"),
                    subtitle: Text("${notes[index]['color']}"),
                    trailing: IconButton(
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
                        icon: Icon(Icons.delete, color: Colors.red)),
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
