import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/screens/ProfileEditScreen.dart';
import 'package:flutter_app/services/Authenticator.dart';
import 'package:flutter_app/services/DataBase.dart';
import 'package:flutter_app/shared/constant.dart';

class RegisterScreen extends StatefulWidget {
  final DataBase db;
  RegisterScreen({@required this.db});
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final Authenticator _auth = Authenticator();
  final appPrimaryColor = const Color(0xff4CAF50);
  final appAccentColor = const Color(0xff23008B);
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Madhyam',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Theme.of(context).primaryColor,
        accentColor: Theme.of(context).accentColor,
        backgroundColor: Theme.of(context).backgroundColor,
        fontFamily: 'AppFont',
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    "Madhyam",
                    style: TextStyle(
                      fontFamily: 'TitleFont',
                      fontSize: 50.0,
                      color: appPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 500,
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration:
                              inputTextDecoration.copyWith(hintText: "Email"),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: inputTextDecoration.copyWith(
                              hintText: "Password"),
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ char'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print(email);
                              print(password);
                              dynamic result = await _auth
                                  .signUpWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Please provide valid email or password';
                                });
                              } else {
                                //If no problems with sing in go to profileScreen to enter data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfileEditScreen(
                                        db: widget.db, isNewUser: true),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          style: primaryButton,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await Future.delayed(const Duration(seconds: 1), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(
                              db: widget.db,
                            ),
                          ),
                        );
                      });
                    },
                    child: Text(
                      'Do you have account?',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: appAccentColor,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
