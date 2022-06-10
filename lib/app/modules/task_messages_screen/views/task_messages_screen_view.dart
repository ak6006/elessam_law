// ignore_for_file: prefer_const_constructors

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/modules/task_home_screen/controllers/task_home_screen_controller.dart';
import 'package:elessam_law/app/modules/task_home_screen/views/task_home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:get/get.dart';

import '../controllers/task_messages_screen_controller.dart';

class TaskMessagesScreenView extends GetView<TaskMessagesScreenController> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(TaskMessagesScreenController());
    // c.initmsg();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            globaltaskname,
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
                // Get.put(TaskHomeScreenController());
                Get.offAll(() => TaskHomeScreenView());
                // Get.to(() => TaskHomeScreenView());
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 29, 21, 145),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: // Text(c.count.value.toString())
              Chat(
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
            // onAttachmentPressed: c.handleImageSelection,
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
