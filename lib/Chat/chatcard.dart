import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  ChatCard({this.sender, this.message, this.isMe});
  final String sender, message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
         topRight: Radius.circular(50),),
          color: (isMe) ? Colors.purple : Colors.white,
      //elevation: 10,
      ),
      margin: (isMe)
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.5)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment:
              (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(color: (isMe) ? Colors.white : Colors.purple),
            ),
            Text(message,
                style: TextStyle(color: (isMe) ? Colors.white : Colors.purple)),
          ],
        ),
      ),
    );
  }
}
