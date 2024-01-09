import 'package:flutter/material.dart';
import 'package:notesapp/local_db.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Sqldb sqldb = Sqldb();

  Future<List<Map>> getdatafromdb() async {
    List<Map> response = await sqldb.getdata("SELECT * FROM notes");
    return response;
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
                onPressed: () async{
                 await sqldb.deletemydatabase();
                },
                child: Text("delete data base")),
            FutureBuilder(
              future: getdatafromdb(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${snapshot.data![index]['note']}"),
                          subtitle: Text("${snapshot.data![index]['color']}"),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
