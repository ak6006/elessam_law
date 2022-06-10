// ignore_for_file: prefer_const_constructors

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/modules/Ticket_screen/views/ticket_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:get/get.dart';

import '../controllers/message_ticket_screen_controller.dart';

class MessageTicketScreenView extends GetView<MessageTicketScreenController> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(MessageTicketScreenController());
    // List<types.Message> msg=c.messages.value<List<types.Message>>;
//  Get.find<MessageTicketScreenController>().messages;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            globalticname,
            style: essamStyle.copyWith(
                fontSize: 28, color: Color.fromARGB(255, 10, 21, 100)),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            // const SizedBox(
            //   width: 120,
            // ),
            TextButton.icon(
              label: const Text(
                '',
                style: TextStyle(
                    color: Color.fromARGB(255, 26, 59, 177),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                c.initmsg();
                // Get.put(TicketScreenController());
                //  Get.offAll(() => TicketScreenView());
              },
              icon: const Icon(
                Icons.arrow_circle_down,
                color: Color.fromARGB(255, 29, 21, 145),
              ),
            ),
            TextButton.icon(
              label: const Text(
                '',
                style: TextStyle(
                    color: Color.fromARGB(255, 26, 59, 177),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                // Get.put(TicketScreenController());
                Get.offAll(() => TicketScreenView());
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 29, 21, 145),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Chat(
            theme: DefaultChatTheme(
              inputBackgroundColor: Colors.red,
              // ignore: prefer_const_literals_to_create_immutables
              userAvatarNameColors: [
                Color.fromARGB(255, 220, 45, 45),
                Colors.blue
              ],
            ),
            //.value<List<types.Message>>
            messages: c.messages1,
            onSendPressed: c.handleSendPressed,
            user: c.user.value,
            onEndReachedThreshold: c.count.value.toDouble(),
            showUserNames: true,
            showUserAvatars: true,
            // nameBuilder: (const Text('nnnnn')

            // },
          ),
        ),
      ),
    );
  }
}
