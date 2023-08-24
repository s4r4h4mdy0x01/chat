import 'package:chat/models/models_mess.dart';

class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Message> messages;
  ChatSuccess({required this.messages});
}
