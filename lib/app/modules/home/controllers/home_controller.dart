import 'dart:convert';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/notificationmodel.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/controllers/message_ticket_screen_controller.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/views/message_ticket_screen_view.dart';
import 'package:elessam_law/app/modules/task_messages_screen/controllers/task_messages_screen_controller.dart';
import 'package:elessam_law/app/modules/task_messages_screen/views/task_messages_screen_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   String b = json.encode(message.toMap());
    //   notificationModel = notificationModelFromJson(b);
    //   if (Get.currentRoute == '/TaskMessagesScreenView' &&
    //       notificationModel.data.model == 'project.task' &&
    //       globaltaskid == int.parse(notificationModel.data.resId) &&
    //       globalrojectname == notificationModel.data.projectname) {
    //     // routdir = '/task-messages-screen';
    //     Get.put(TaskMessagesScreenController()).initmsg();
    //   } else if (Get.currentRoute == '/MessageTicketScreenView' &&
    //       notificationModel.data.model == 'helpdesk.ticket' &&
    //       globaltic_id == int.parse(notificationModel.data.resId) &&
    //       globalticname == notificationModel.data.taskname) {
    //     // routdir = '/message-ticket-screen';
    //     Get.put(MessageTicketScreenController()).initmsg();
    //   } else {
    //     if (notificationModel.data.model == 'project.task') {
    //       globaltaskid = int.parse(notificationModel.data.resId);
    //       globaltaskname = notificationModel.data.taskname;
    //       globalrojectname = notificationModel.data.projectname;
    //       globalprojectid = int.parse(notificationModel.data.projectid);
    //       // routdir = '/task-messages-screen';
    //       Get.offAll(() => TaskMessagesScreenView());
    //     } else if (notificationModel.data.model == 'helpdesk.ticket') {
    //       globaltic_id = int.parse(notificationModel.data.resId);
    //       globalticname = notificationModel.data.taskname;
    //       // routdir = '/message-ticket-screen';
    //       Get.offAll(MessageTicketScreenView());
    //     }
    //   }
    // });

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('hoooooome iniiit');
    if (initialMessage != null) {
      String msg = json.encode(initialMessage.toMap());
      notificationModel = notificationModelFromJson(msg);
      if (notificationModel.data.model == 'project.task') {
        globaltaskid = int.parse(notificationModel.data.resId);
        globaltaskname = notificationModel.data.taskname;
        globalrojectname = notificationModel.data.projectname;

        globalprojectid = int.parse(notificationModel.data.projectid);
        // routdir = '/task-messages-screen';

        Get.offAll(() => TaskMessagesScreenView());
      } else if (notificationModel.data.model == 'helpdesk.ticket') {
        globaltic_id = int.parse(notificationModel.data.resId);
        globalticname = notificationModel.data.taskname;
        // routdir = '/message-ticket-screen';
        Get.offAll(MessageTicketScreenView());
      }
    } else {
      await firebaseFcm();
    }
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
