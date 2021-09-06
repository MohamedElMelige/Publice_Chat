import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:newpro/Chat/Register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  var _formKey = GlobalKey<FormState>();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    PatternValidator(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        errorText: 'email format not valid'),
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password at lest 8 chars'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'password must have special char')
  ]);
  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          'Register',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Builder(
        builder: (context) => ListView(
          padding: EdgeInsets.all(20),
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      'enter your email:',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: emailValidator,
                      //     (vaidate) {
                      //   if (vaidate.isEmpty) return 'email is required';
                      //   //else if(RegExp())
                      //     return 'email format not valid';
                      //   return null;
                      // },
                      onChanged: (val) {
                        email = val;
                      },
                      decoration: InputDecoration(
                          hintText: 'enter email',
                          labelText: 'email',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'enter your password',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: passwordValidator,
                      //   (validate) {
                      // if (validate.isEmpty) return 'Password is required';
                      // else if(validate.length<8)
                      //   return 'password length at last 8 chars';
                      // //else if(RegExp(''))
                      //   return 'password is required a spceail char';
                      // return null;
                      //},
                      onChanged: (val) {
                        password = val;
                      },
                      decoration: InputDecoration(
                          hintText: 'enter Password',
                          labelText: 'password',
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            FlatButton(
                color: Colors.purple,
                padding: EdgeInsets.all(20),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('no internet connection'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } else {
                    try {
                      await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        if (e.code == 'user-not-found') {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('email not found'),
                            backgroundColor: Colors.red,
                          ));
                        } else if (e.code == 'wrong-password') {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'password or email is wrong',
                              )));
                        }
                      }
                    }
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                'Don\'t have account',
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
