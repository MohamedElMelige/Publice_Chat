import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newpro/ReusableCard.dart';
class GetData extends StatefulWidget {
  @override
  _GetDataState createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  var _fireStore = FirebaseFirestore.instance;
  List<ReuseableCard> cardList=[];
  getData()async{
    await for(var snapshot in _fireStore.collection('students').snapshots()){
      for(var items in snapshot.docs){
        String name = items.data()['name'];
        String age = items.data()['age'];
        String status = items.data()['married'];
        var myCard =ReuseableCard(name:name ,age:age ,status:status ,);
        cardList.add(myCard);
        setState(() {});
      };
    };
  }
  @override
  void initState(){
    getData();
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: ListView.builder(
       itemCount: cardList.length,
        itemBuilder: (context,index)=>cardList[index],
      ),
    );
  }
}
