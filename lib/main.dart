import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_web_app/screens/note_page.dart';

import 'firebase_auth/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
      theme: ThemeData(
          primaryColor: Colors.black,
          canvasColor: Colors.black,
          colorScheme: ColorScheme.dark(primary: Colors.black),
          floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.black)),
        home:
        //Notespage(title: "Notes",),
        FirebaseAuth.instance.currentUser == null ? SignIn() : Notespage(title: "Notes"),
    );
  }
}
