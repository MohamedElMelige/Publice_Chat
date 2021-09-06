import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chatcard.dart';

class chatPage extends StatefulWidget {
  @override
  _chatPageState createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  var _fireStore = FirebaseFirestore.instance;
  String newMessage;
  var _controller=TextEditingController();
  var _auth= FirebaseAuth.instance;
  var loggedInUser;
  getCurrentUser(){
    User user= _auth.currentUser;
    loggedInUser=user.email;
  }
  //------------------------------------------------------------------
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('chat').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var items = snapshot.data.docs;
                List<Widget> chatList = [];
                for (var item in items) {
                  String message = item.data()['message'];
                  String sender = item.data()['sender'];
                  var itemList = chatList;
                  chatList.addAll(itemList);
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(15),
                    children: chatList,
                  ),
                );
              }),
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.white12,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    // controller: ,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                    ),
                    onChanged: (val){
                      _controller.text = val;
                    },
                  ),
                ),
                IconButton(icon: Icon(Icons.send), color: Colors.teal, iconSize: 30,onPressed: (){
                  _fireStore.collection('chat').add(
                    {'message': newMessage,
                      'sender': loggedInUser,
                      'sort' : DateTime.now().millisecondsSinceEpoch
                    },);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}