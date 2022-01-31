import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_web_app/firebase_auth/sign_in.dart';
import 'package:notes_web_app/screens/note_page.dart';
import 'authentication.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white12,
        ),
        body: kIsWeb
            ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: image(),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: form(),
                    ),
                  ],
                ),
              )
            :
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        SizedBox(
                          child: image(),
                          height: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        form(),
                      ],
              ),
                  ),
                ));
  }

  Widget image() {
    return Container(
      width: 350,
      child: Center(
          child: Image.asset(
        'assets/img_3.png',
      )),
    );
  }

  Widget form() {
    return Form(
      key: _formkey,
      child: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8, bottom: 8),
                child: Center(
                    child: Text(
                  "Sign up",
                  style: TextStyle(fontSize: 35, color: Colors.black),
                )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.0, left: 8, bottom: 8),
                child: Text(
                  "Sign up if you want to become a member.",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0, left: 8, bottom: 10),
                child: Text("Username", style: TextStyle(color: Colors.black),),
              ),
              TextFormField(
                key: ValueKey('username'),
                validator: (value) {
                  if (value.toString().length < 3) {
                    return 'Invalid Username';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  username = value!;
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Username',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  contentPadding: EdgeInsets.only(left: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0, left: 8, bottom: 8),
                child: Text("Your email", style: TextStyle(color: Colors.black),),
              ),
              TextFormField(
                key: ValueKey('email'),
                validator: (value) {
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value!)) {
                    return 'Invalid email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Enter email id',
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  contentPadding: EdgeInsets.only(left: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0, left: 8, bottom: 8),
                child: Text("Password", style: TextStyle(color: Colors.black),),
              ),
              TextFormField(
                key: ValueKey('password'),
                validator: (value) {
                  if (value.toString().length < 6) {
                    return 'Enter at least 6 characters';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value!;
                },
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: Icon(
                    Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  labelStyle: TextStyle(fontSize: 12),
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  contentPadding: EdgeInsets.only(left: 30),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey.shade100),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                      onPressed: () async {
                        // Authentication()
                        //     .signUp(email: email, password: password)
                        //     .then((result) {
                        //   if (result == null) {
                        //     Navigator.pushReplacement(context,
                        //         MaterialPageRoute(builder: (context) => Notespage(title: "Notes")));
                        //   } else {
                        //     Scaffold.of(context).showSnackBar(SnackBar(
                        //       content: Text(
                        //         result,
                        //         style: TextStyle(fontSize: 16),
                        //       ),
                        //     ));
                        //   }
                        // });
                        print("button clicked");
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          await signUp(email, password,);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notespage(title: "Notes")));
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 22),
                      ))),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a member? ", style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: () {
                        print("Clicked");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
