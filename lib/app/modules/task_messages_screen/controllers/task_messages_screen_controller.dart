// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:elessam_law/app/data/ticketmessage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:elessam_law/app/data/const.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class TaskMessagesScreenController extends GetxController {
  //TODO: Implement TaskMessagesScreenController

  final count = 0.0.obs;
  // List<types.Message> messages1 = []; // as List<types.Message>;
  final messages1 = <types.Message>[].obs;
  // final messages = [].obs;
  final Rx<Ticketmessage> globalticketMessagectr =
      Ticketmessage(messages: [], messageCount: 0).obs; // = <Ticketmessage>[];
  final user = types.User(
    id: session.id,
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

  void handleImageSelection() async {}

  Future<void> handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user.value,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: session.id,
      text: session.userName + '\n' + message.text,
      remoteId: globaltaskid.toString(),
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
        "res_model": "project.task",
        "res_id": globaltaskid,
        "message": msg,
        "attachment_ids": "",
        "attachment_tokens": "",
        // }
        // ]
      });
      // print('zzzzzzzzzz ' + res1.id.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> postmessage(String msg) async {
    // print(session.partnerId);
    try {
      final res = await orpc.callKw({
        'model': 'mail.message',
        'method': 'create',
        'args': [
          {
            'model': 'project.task',
            'res_id': globaltaskid,
            'email_from': session.userLogin,
            'message_type': 'comment',
            'subtype_id': 1,
            'author_id': (session.partnerId),
            'body': msg,
            // 'parent_id': 6339,
            // 'notification_ids': [
            //   [
            //     0,
            //     0,
            //     {
            //       'res_partner_id': 3,
            //       'notification_type': 'inbox',
            //       'notification_status': 'sent',
            //     }
            //   ],
            //   [
            //     0,
            //     0,
            //     {
            //       'res_partner_id': 6,
            //       'notification_type': 'email',
            //       'notification_status': 'sent',
            //     }
            //   ],
            // ],

            // 'email_from':'',
          },
        ],
        'kwargs': {},
      });
      //*print('VVVVVVVVVVVV ' + res.toString());
      return jsonEncode(res);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> getmsg() async {
    try {
      var res = await orpc.callRPC('/mail/chatter_fetch', 'call', {
        "res_id": globaltaskid,
        "res_model": 'project.task',
        'limit': 30,
        "domain": [
          '&',
          [('res_id'), '=', (globaltaskid)],
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
    print('innnnnnnnnnnnit task message');
    // messages1.clear();
    // print(globaltaskid);

    // final res = await getmessageticketData(globaltaskid);
    final res = await getmsg();
    globalticketMessage = (ticketmessageFromJson((res)));
    globalticketMessage.messages.sort((a, b) => a.date.compareTo(b.date));
    // for (var m in messages1) {
    //   if (m.remoteId != globaltaskid.toString()) {
    //     messages1.removeWhere((element) => element.remoteId != globaltaskid.toString());

    //   }
    // }
    messages1
        .removeWhere((element) => element.remoteId != globaltaskid.toString());

    for (var c in globalticketMessage.messages) {
      // final index = globalticketMessagectr.value.messages
      //     .indexWhere((element) => element.id == c.id);
      final index =
          messages1.indexWhere((element) => element.id == c.id.toString());
      if (index < 0) {
        // globalticketMessagectr.value.messages.add(c);
        final us = c.authorId[1] == session.userName
            ? user.value
            : types.User(
                id: c.authorId[1],
                firstName: c.authorId[1],
                imageUrl:
                    'https://100.elessam.com/web/image/mail.message/${c.id}/author_avatar/50x50',
                lastName: '');

        final textMessage = types.TextMessage(
          author: us,
          createdAt: c.date.millisecondsSinceEpoch,
          id: c.id.toString(),
          text: c.body
              .replaceAll('<p>', '')
              .replaceAll('</p>', '')
              .replaceAll('<br>', '\n'),
          remoteId: globaltaskid.toString(),
        );

        addMessage(textMessage);

        count.value++;
      }
      // print('VVVVVVVVVVVV ' + index.toString());
    }
    return;
    // globalticketMessagectr.value = (ticketmessageFromJson((res)));

    globalticketMessagectr.value.messages
        .sort((a, b) => a.date.compareTo(b.date));
    for (var d in globalticketMessagectr.value.messages) {
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
        remoteId: globaltaskid.toString(),
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
    // getmsg();
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
