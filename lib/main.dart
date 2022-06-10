import 'package:elessam_law/app/data/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';

import 'app/routes/app_pages.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase
      .initializeApp(); //(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
  // print("Handling a background message: ${message.notification?.body}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final res = await getlastsession();
  String routdir = "/home";
  // if (res) {
  //   routdir = await firebaseFcm();
  // }
  subscription = orpc.sessionStream.listen(sessionChanged);
  runApp(
    OverlaySupport(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "تطبيق المحامي",
        initialRoute: res ? routdir : AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
