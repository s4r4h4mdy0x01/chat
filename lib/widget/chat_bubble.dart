import 'package:chat/const/colors.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
      margin:  const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding:const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius:const  BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
          'Hello I\'m sara',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
