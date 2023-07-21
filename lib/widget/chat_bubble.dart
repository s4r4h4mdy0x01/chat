import 'package:chat/models/models_mess.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({
    required this.mess,
    required this.color,
    this.radiusLeft = 0,
    this.radiusRight = 0,
    this.alignment = Alignment.bottomLeft,
  });
  final Message mess;
  final Color color;
  final double radiusLeft;
  final double radiusRight;
  AlignmentGeometry alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                topRight: const Radius.circular(32),
                topLeft: const Radius.circular(32),
                bottomRight: Radius.circular(radiusRight),
                bottomLeft: Radius.circular(radiusLeft))),
        child: Text(
          mess.message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
