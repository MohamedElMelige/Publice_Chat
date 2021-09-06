import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  ReuseableCard({this.age,this.name,this.status,this.onDelete,this.onUpData,this.onChanged});
  final String name,age,status;
  final Function onUpData,onDelete,onChanged;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      elevation: 15,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text('$name',style: TextStyle(fontSize: 20,color: Colors.purple),),
            Text('$age',style: TextStyle(fontSize: 20,color: Colors.purple),),
            Text('$status',style: TextStyle(fontSize: 20,color: Colors.purple),),
            SizedBox(height: 20,),
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'enter new name',
                labelText: 'new name',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.teal,
                    onPressed:onUpData, child: Text('Update',style: TextStyle(fontSize: 20,color: Colors.white),)),
                FlatButton(
                    padding: EdgeInsets.all(10),
                    color: Colors.teal,
                    onPressed: onDelete, child: Text('Delete',style: TextStyle(fontSize: 20,color: Colors.white),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
