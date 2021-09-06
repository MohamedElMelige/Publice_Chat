import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newpro/Chat/ChatPage.dart';
import 'package:newpro/Chat/Register.dart';
import 'package:newpro/first_page.dart';

import 'Chat/Login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageOne(
        appBarText: 'Page One',
        bodyText: 'Page One',
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  PageOne({this.bodyText, this.appBarText});
  final String appBarText, bodyText;
  @override
  Widget build(BuildContext context) {
    return PageTwo(
      appBarText: appBarText,
      bodyText: bodyText,
    );
  }
}

class PageTwo extends StatelessWidget {
  PageTwo({this.bodyText, this.appBarText});
  final String appBarText, bodyText;
  @override
  Widget build(BuildContext context) {
    return PageThree(
      appBarText: appBarText,
      bodyText: bodyText,
    );
  }
}

class PageThree extends StatelessWidget {
  PageThree({this.bodyText, this.appBarText});
  final String appBarText, bodyText;
  @override
  Widget build(BuildContext context) {
    return PageFour(
      appBarText: appBarText,
      bodyText: bodyText,
    );
  }
}

class PageFour extends StatelessWidget {
  PageFour({this.bodyText, this.appBarText});
  final String appBarText, bodyText;
  @override
  Widget build(BuildContext context) {
    return PageFive(
      appBarText: appBarText,
      bodyText: bodyText,
    );
  }
}

class PageFive extends StatelessWidget {
  PageFive({this.appBarText, this.bodyText});
  final String appBarText, bodyText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
      ),
      body: Center(
        child: Text(bodyText),
      ),
    );
    ;
  }
}
