import 'package:flutter/material.dart';
import 'package:notesapp/screens/add_notes.dart';
import 'package:notesapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "create your notes",
      home: Homescreen(),
      routes: {
        "addnotes": (context) => AddNotes(),
        "homescreen": (context) => Homescreen(),
      },
    );
  }
}
