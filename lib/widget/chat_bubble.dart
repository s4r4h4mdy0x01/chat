import 'package:chat/const/colors.dart';
import 'package:chat/models/models_mess.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
   const ChatBubble({required this.mess});
  final Message mess;
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
        mess.message  ,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
