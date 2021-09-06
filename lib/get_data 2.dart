import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newpro/ReusableCard.dart';

class GetDataTwo extends StatefulWidget {
  @override
  _GetDataTwoState createState() => _GetDataTwoState();
}

class _GetDataTwoState extends State<GetDataTwo> {
  var _firestore = FirebaseFirestore.instance;
  String newName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Two'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('students').snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var snap = snapshots.data.docs;
          List<ReuseableCard> cardList = [];
          for (var item in snap) {
            String name = item.data()['name'];
            String age = item.data()['age'];
            String status = item.data()['married'];
            String id =item.id;
            var itemCard = ReuseableCard(
              name: name,
              age: age,
              status: status,
              onChanged: (val){
                newName=val;
              },
              onDelete: ()async{
                await _firestore.collection('students').doc(id).delete();
              },
              onUpData: ()async{
               await _firestore.collection('students').doc(id).update({'name':newName});
              },
            );
            cardList.add(itemCard);
          }
          return ListView(
            children: cardList,
          );
        },
      ),
    );
  }
}
