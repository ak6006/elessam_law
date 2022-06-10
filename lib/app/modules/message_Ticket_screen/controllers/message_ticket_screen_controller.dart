// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/ticketmessage.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageTicketScreenController extends GetxController {
  final count = 0.0.obs;
  List<types.Message> messages1 = []; // as List<types.Message>;
  // final messages = [].obs;
  final user = types.User(
    id: '06c33e8b-e835-4736-80f4-63f44b66666c',
    // firstName: 'agmad',
    // imageUrl: 'https://alakhawain.net/wp-content/uploads/2022/05/logo-last.png',
    // lastName: 'ali',
  ).obs;

  // final user_name_info = types.User(id: session.userName);
  // final user_email_info = session.userLogin;

  void addMessage(types.Message message) {
    messages1.insert(0, message);
    update();
  }

  Future<void> handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user.value,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: session.id,
      text: session.userName + '\n' + message.text,
    );
    final res = await postmessage2(message.text);

    //  addMessage(textMessage);

    await initmsg();
    count.value++;

    //  update();
  }

// res_model, res_id, message
  Future<dynamic> postmessage2(String msg) async {
    try {
      var res1 = await orpc.callRPC('/mail/chatter_post', 'call', {
        // 'args': [
        //   {
        "res_model": "helpdesk.ticket",
        "res_id": globaltic_id,
        "message": msg,
        "attachment_ids": "",
        "attachment_tokens": "",
        // }
        // ]
      });
      print('VVVVVVVVVVVV ' + res1.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> postmessage(String msg) async {
    ////*print(session.partnerId);
    try {
      final res = await orpc.callKw({
        'model': 'mail.message',
        'method': 'create',
        'args': [
          {
            'model': 'helpdesk.ticket',
            'res_id': globaltic_id,
            'email_from': session.userLogin,
            'message_type': 'comment',
            'subtype_id': 1,
            'author_id': (session.partnerId),
            'body': msg
            // 'email_from':'',
          },
        ],
        'kwargs': {},
      });

      return jsonEncode(res);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> getmsg() async {
    try {
      var res = await orpc.callRPC('/mail/chatter_fetch', 'call', {
        "res_id": globaltic_id,
        "res_model": 'helpdesk.ticket',
        'limit': 30,
        "domain": [
          '&',
          [('res_id'), '=', (globaltic_id)],
          [('subtype_id'), '=', 1]
        ],
      });
      // print('VVVVVVVVVVVV ' + jsonEncode(res));
      // Clipboard.setData(ClipboardData(text: jsonEncode(res)));
      return jsonEncode(res);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> initmsg() async {
    messages1.clear();
    // final res = await getmessageticketData(globaltic_id);
    final res = await getmsg();

    globalticketMessage = (ticketmessageFromJson((res)));
    globalticketMessage.messages.sort((a, b) => a.date.compareTo(b.date));
    for (var d in globalticketMessage.messages) {
      final us = d.authorId[1] == session.userName
          ? user.value
          : types.User(
              id: d.authorId[1],
              firstName: d.authorId[1],
              imageUrl:
                  'https://100.elessam.com/web/image/mail.message/${d.id}/author_avatar/50x50',
              lastName: '');

      final textMessage = types.TextMessage(
        author: us,
        createdAt: d.date.millisecondsSinceEpoch,
        id: d.id.toString(),
        text: d.body
            .replaceAll('<p>', '')
            .replaceAll('</p>', '')
            .replaceAll('<br>', '\n'),
      );

      addMessage(textMessage);

      count.value++;
      //  return true;
    }
  }

  @override
  void onInit() {
    initmsg();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void increment() => count.value++;
}
