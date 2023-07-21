import 'package:chat/const/colors.dart';
import 'package:chat/const/string_const.dart';
import 'package:chat/models/models_mess.dart';
import 'package:chat/pages/login_screen.dart';
import 'package:chat/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kTime).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromjson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(klogo, cacheHeight: 50),
                  const Text(
                    'Chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubble(
                              mess: messageList[index],
                              color: kPrimaryColor,
                              radiusRight: 32,
                            )
                          : ChatBubble(
                              mess: messageList[index],
                              color: kColorMesstwo,
                              radiusLeft: 32,
                              alignment: Alignment.bottomRight,
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {kMessage: data, kTime: DateTime.now(), 'id': email},
                      );
                      controller.clear();
                      _controller.animateTo(
                          _controller.position.maxScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.decelerate);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message....',
                      suffixIcon: IconButton(onPressed: () {
                        
                      },icon:const Icon(Icons.send),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('loading');
        }
      },
    );
  }
}
