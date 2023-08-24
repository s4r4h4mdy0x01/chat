import 'package:bloc/bloc.dart';
import 'package:chat/const/string_const.dart';
import 'package:chat/models/models_mess.dart';
import 'package:chat/pages/cubits/cubit_chat/chat_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  void sendMessages({required String data, required var email}) {
    messages.add(
      {kMessage: data, kTime: DateTime.now(), 'id': email},
    );
  }

  void getMessages() {
    messages.orderBy(kTime).snapshots().listen((event) {
      List<Message> messageList = [];
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromjson(doc));
      }
      emit(ChatSuccess(messages: messageList));
    });
  }
}
