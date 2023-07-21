import 'package:chat/const/string_const.dart';

class Message {
  final String message;
  Message(this.message);
  factory Message.fromjson(dataOfJson) {
    return Message(dataOfJson[kMessage]);
  }
}
