// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:elessam_law/app/data/notificationmodel.dart';
import 'package:elessam_law/app/data/ticketmessage.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/controllers/message_ticket_screen_controller.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/views/message_ticket_screen_view.dart';
import 'package:elessam_law/app/modules/task_messages_screen/controllers/task_messages_screen_controller.dart';
import 'package:elessam_law/app/modules/task_messages_screen/views/task_messages_screen_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:get_storage/get_storage.dart';

// const primaryColor = Color.fromARGB(255, 247, 175, 109);
var orpc = OdooClient('https://100.elessam.com');
late OdooSession session;
var subscription;
final getstore = GetStorage();
// List<Attendance> attendance = <Attendance>[];

// var subscription; //= orpc.sessionStream.listen(sessionChanged);
// var prev_session;
// List<Ticketmessage> globalticketMessage = <Ticketmessage>[];
Ticketmessage globalticketMessage =
    Ticketmessage(messages: [], messageCount: 0); // = <Ticketmessage>[];

List<int> globalwebsiteMessageIds = [];
// ignore: non_constant_identifier_names
dynamic globalticname;
// ignore: non_constant_identifier_names
dynamic globaltic_id;
dynamic globalprojectid;
dynamic globalrojectname;
dynamic globaltaskid;
dynamic globaltaskname;
dynamic fcmToken;
NotificationModel notificationModel = notificationModel;

sessionChanged(OdooSession sessionId) async {
  print('We got new session ID: ' + sessionId.toJson().toString());
  getstore.write('session', sessionId.toJson());
  // OdooSession b = OdooSession.fromJson(sessionId.toJson());
  // store_session_somehow(sessionId);
}

Future<bool> getlastsession() async {
  try {
    final sessionId = getstore.read('session');
    if (sessionId != null) {
      session = OdooSession.fromJson(sessionId);
      orpc = OdooClient('https://100.elessam.com', session);
      final res = await orpc.checkSession();
      print(res);
      print('dooooonnnnnnneeeee');
      // await firebaseFcm();
      return true;
    } else {
      print('emmmmpty');
      return false;
    }
  } on OdooSessionExpiredException catch (e) {
    print(e);

    return false;
  }
}

Future<bool> checkForInitialMessage() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
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

      return false;
    }
  }
  return true;
}

Future<String> firebaseFcm() async {
  String routdir = "/home";
  try {
    // await Firebase.initializeApp();

    //  FirebaseMessaging _firebaseMessaging ;//= FirebaseMessaging;
    //  _firebaseMessaging.
    // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    //   print('UUUUUUUUUUUUUUUUUUU');
    //   await saveToken(fcmToken);
    // }).onError((err) {
    //   // Error getting token.
    // });

    fcmToken = await FirebaseMessaging.instance.getToken();
    // print(fcmToken);
    await saveToken(fcmToken);

    FirebaseMessaging.instance.onTokenRefresh.listen(saveToken);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String msg = json.encode(message.toMap());
      notificationModel = notificationModelFromJson(msg);
      if (Get.currentRoute == '/TaskMessagesScreenView' &&
          notificationModel.data.model == 'project.task' &&
          globaltaskid == int.parse(notificationModel.data.resId) &&
          globalrojectname == notificationModel.data.projectname) {
        routdir = '/task-messages-screen';
        Get.put(TaskMessagesScreenController()).initmsg();
      } else if (Get.currentRoute == '/MessageTicketScreenView' &&
          notificationModel.data.model == 'helpdesk.ticket' &&
          globaltic_id == int.parse(notificationModel.data.resId) &&
          globalticname == notificationModel.data.taskname) {
        routdir = '/message-ticket-screen';
        Get.put(MessageTicketScreenController()).initmsg();
      } else {
        if (notificationModel.data.model == 'project.task') {
          globaltaskid = int.parse(notificationModel.data.resId);
          globaltaskname = notificationModel.data.taskname;
          globalrojectname = notificationModel.data.projectname;

          globalprojectid = int.parse(notificationModel.data.projectid);
          routdir = '/task-messages-screen';

          Get.offAll(() => TaskMessagesScreenView());
        } else if (notificationModel.data.model == 'helpdesk.ticket') {
          globaltic_id = int.parse(notificationModel.data.resId);
          globalticname = notificationModel.data.taskname;
          routdir = '/message-ticket-screen';
          Get.offAll(MessageTicketScreenView());
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String b = json.encode(message.toMap());
      notificationModel = notificationModelFromJson(b);
      if (Get.currentRoute == '/TaskMessagesScreenView' &&
          notificationModel.data.model == 'project.task' &&
          globaltaskid == int.parse(notificationModel.data.resId) &&
          globalrojectname == notificationModel.data.projectname) {
        Get.put(TaskMessagesScreenController()).initmsg();
      } else if (Get.currentRoute == '/MessageTicketScreenView' &&
          notificationModel.data.model == 'helpdesk.ticket' &&
          globaltic_id == int.parse(notificationModel.data.resId) &&
          globalticname == notificationModel.data.taskname) {
        Get.put(MessageTicketScreenController()).initmsg();
      } else {
        showOverlayNotification((context) {
          return GestureDetector(
            onTap: () {
              if (notificationModel.data.model == 'project.task') {
                globaltaskid = int.parse(notificationModel.data.resId);
                globaltaskname = notificationModel.data.taskname;
                globalrojectname = notificationModel.data.projectname;

                globalprojectid = int.parse(notificationModel.data.projectid);

                Get.offAll(() => TaskMessagesScreenView());
              } else if (notificationModel.data.model == 'helpdesk.ticket') {
                globaltic_id = int.parse(notificationModel.data.resId);
                globalticname = notificationModel.data.taskname;
                Get.offAll(MessageTicketScreenView());
              }
              OverlaySupportEntry.of(context)!.dismiss();
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: SafeArea(
                child: ListTile(
                  leading: SizedBox.fromSize(
                    size: const Size(90, 90),
                    child: ClipOval(
                      child: IconButton(
                          icon: Image.asset('assets/images/law3.png'),
                          iconSize: 30,
                          onPressed: () {
                            // OverlaySupportEntry.of(context)!.dismiss();
                          }),
                    ),
                  ),
                  title: Text(notificationModel.notification.title),
                  subtitle: Column(
                    children: [
                      Text(notificationModel.data.taskname),
                      Text(notificationModel.notification.body),
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 30,
                      onPressed: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      }),

                  //  Builder(builder: (context) {
                  //   return FlatButton(
                  //       textColor: Colors.yellow,
                  //       onPressed: () {
                  //         OverlaySupportEntry.of(context)!.dismiss();
                  //       },
                  //       child: Text('Dismiss'));
                  // }),

                  //------------------
                  //  IconButton(

                  //     icon: Icon(Icons.close),
                  //     onPressed: () {
                  //       OverlaySupportEntry.of(context)!.dismiss();
                  //     }),
                ),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 15000));
      }

      // print(Get.currentRoute);
      // return;
    });

    return routdir;
  } catch (e) {
    return routdir;
  }
}

Future<bool> login(String username, String password) async {
  try {
    session = await orpc.authenticate('elessam-15', username, password);

    // await firebaseFcm();

    return true;
  } on OdooException catch (e) {
    print(e);
    return false;
  }
}

Future<void> saveToken(String token) async {
  try {
    var res1 = await orpc.callRPC('/my/token', 'call', {
      "city": token,
    });
    // return true;
  } catch (e) {
    print(e);
    // return false;
  }
}

Future<dynamic> getmessageticketData(dynamic id) async {
  try {
    var res = await orpc.callKw({
      'model': 'mail.message', //.category',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        'domain': [
          '&',
          [('res_id'), '=', (id)],
          [('subtype_id'), '=', 1]
        ],
        // 'domain': [
        //   ['res_id', '=', id] //session.userId
        // ],
        'fields': [
          'id',
          'body',
          'email_from',
          'reply_to',
          'subject',
          'author_id',
          'create_uid',
          'message_id',
          'res_id',
          'date',
          'message_type',
          'subtype_id',
          'model',
          'notified_partner_ids',
          'notification_ids',
          'parent_id',
          // 'tracking_value_ids',
        ],
      },
    });
    //*print(jsonEncode(res));
    // ticketMessage = (ticketmessageFromJson(jsonEncode(res)));
    return jsonEncode(res);
  } catch (e) {
    print(e);
    return false;
  }
}

Future<dynamic> get_ticket_data() async {
  try {
    var res = await orpc.callKw({
      'model': 'helpdesk.ticket', //.category',
      'method': 'search_read',
      'args': [],
      'kwargs': {
        'context': {'bin_size': true},
        // 'domain': [
        //   ['user_id', '=', userid] //session.userId
        // ],
        'fields': [
          'id',
          'name',
          'stage_id',
          'partner_id',
          'category_id',
          'description',
          'create_date',
          'website_message_ids'
          // 'message_partner_ids'
        ],
      },
    });
    //*print(jsonEncode(res));
    // employeeData = (employeeDtataFromJson(jsonEncode(res)));
    // ticketModel = (ticketModelFromJson)(jsonEncode(res));
    return jsonEncode(res);
  } catch (e) {
    print(e);
    return false;
  }
}
