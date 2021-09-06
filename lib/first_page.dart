import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newpro/get_data.dart';
import 'get_data 2.dart';
class Curd extends StatefulWidget {
  @override
  _CurdState createState() => _CurdState();
}

class _CurdState extends State<Curd> {
  String name, age, married,newName;
  bool spinner = false;
  var _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text(
          'CRUD',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            onChanged: (val) {
              name = val;
            },
            decoration: InputDecoration(
              hintText: 'enter your name',
              labelText: 'name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (val) {
              age = val;
            },
            decoration: InputDecoration(
              hintText: 'enter your age',
              labelText: 'age',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (val) {
              married = val;
            },
            decoration: InputDecoration(
              hintText: 'enter your status',
              labelText: 'status',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
              padding: EdgeInsets.all(15),
              color: Colors.teal,
              onPressed: () async {
                await _firestore.collection('students').add({
                  'name':name,
                  'age':age,
                  'status':married,
                });
                // await _firestore
                //     .collection('students')
                //     .doc('myCustomId')
                //     .set({'name': name, 'age': age, 'married': married});
              },
              child: Text(
                'ADD',
                style: TextStyle(fontSize: 25, color: Colors.white),
              )),
          SizedBox(
            height: 20,
          ),
          //-----------------------------------------------
          TextField(
            onChanged: (val){
              newName=val;
            },
            decoration: InputDecoration(
              hintText: 'enter new name',
              labelText: 'name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            padding: EdgeInsets.all(20),
            color: Colors.teal,
              onPressed: ()async{
            await _firestore.collection('students').doc('myCustomId').update({'name':newName});
          }, child: Text('Update',style: TextStyle(fontSize: 25),)),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            padding: EdgeInsets.all(20),
            color: Colors.teal,
              onPressed: ()async{
            await _firestore.collection('students').doc('myCustomId').delete();}, child:Text('Delete',style: TextStyle(fontSize: 25),)),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            padding: EdgeInsets.all(20),
            color: Colors.teal,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> GetDataTwo()));

        }, child: Text('get data',style: TextStyle(fontSize: 25)))

        ],
      ),
    );
  }
}
