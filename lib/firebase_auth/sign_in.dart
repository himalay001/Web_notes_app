import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes_web_app/firebase_auth/sign_up.dart';
import 'package:notes_web_app/screens/note_page.dart';
import 'authentication.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";

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
               ),
    );
  }

  Widget image() {
    return Center(
        child: Image.asset(
      'assets/img_3.png',
    ));
  }

  Widget form() {
    return Form(
      key: _formkey,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0, left: 8, bottom: 8),
              child: Center(
                  child: Text(
                "Sign in" ,
                style: TextStyle(fontSize: 35, color: Colors.black),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0, left: 8, bottom: 20),
              child: Text(
                "Sign in if you have an account in here.",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 8, bottom: 8),
              child: Text("Your email", style: TextStyle( color: Colors.black),),
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
                hintText: 'Enter email id' ,
                filled: true,
                fillColor: Colors.blueGrey[50],
                labelStyle: TextStyle(fontSize: 12, color: Colors.black),
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
              validator: (value) {
                if (value.toString().length < 6) {
                  return 'Invalid password';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                password = value!;
              },
              key: ValueKey('password'),
              cursorColor: Colors.black,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                counterText: "Forgot password? ",
                suffixIcon: Icon(
                  Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.blueGrey[50],
                labelStyle: TextStyle(fontSize: 12, color: Colors.black),
                hintStyle: TextStyle(color: Colors.blueGrey),
                counterStyle: TextStyle(color: Colors.black),
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
              height: 30,
            ),
            Center(
              child: Container(
                height: 40,
                width: 120,
                child: ElevatedButton(
                    onPressed: () async {
                      // Authentication()
                      //     .signIn(email: email, password: password)
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
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        await signIn(email, password);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Notespage(title: "Notes")));
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
                      "Sign in",
                      style: TextStyle(fontSize: 22, ),
                    ))),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ", style: TextStyle(color: Colors.black),),
                  TextButton(
                    onPressed: () {
                      print("Clicked");
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text(
                      "Sign Up",
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
    );
  }
}
