import 'package:chat/const/string_const.dart';

class Message {
  final String message;
  final String id;
  Message(this.message, this.id);
  factory Message.fromjson(dataOfJson) {
    return Message(dataOfJson[kMessage], dataOfJson['id']);
  }
}
