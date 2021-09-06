import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'ChatPage.dart';
import 'package:newpro/Chat/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password;
  bool spinner =false;
  var _formKey = GlobalKey<FormState>();
  var emailValidator = MultiValidator([
    RequiredValidator(errorText: 'email is required'),
    //PatternValidator(pattern, errorText: errorText)
  ]);
  var passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(8, errorText: 'password at lest 8 chars'),
    //PatternValidator(pattern, errorText: 'password must have specail chars')
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
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>chatPage()));
                    } catch (e) {
                      if(e is PlatformException){
                        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE'){
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Email already used'),
                          backgroundColor: Colors.red,
                          ));
                        }

                      }
                    }
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Alread have account?',
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
