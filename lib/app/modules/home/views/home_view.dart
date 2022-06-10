// import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/default_button.dart';
import 'package:elessam_law/app/data/size_config.dart';
import 'package:elessam_law/app/modules/Ticket_screen/controllers/ticket_screen_controller.dart';
import 'package:elessam_law/app/modules/Ticket_screen/views/ticket_screen_view.dart';
import 'package:elessam_law/app/modules/project_home_screen/views/project_home_screen_view.dart';
import 'package:elessam_law/app/modules/sign_in_screen/controllers/sign_in_screen_controller.dart';
import 'package:elessam_law/app/modules/sign_in_screen/views/sign_in_screen_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:odoo_rpc/odoo_rpc.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    // prefs = await SharedPreferences.getInstance();
    SizeConfig().init(context);
    Get.put(HomeController());
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    DefaultButton(
                      text: "استشاراتي",
                      press: () {
                        //  Get.put(TicketScreenController()); // controller init
                        // Get.deleteAll();
                        Get.to(() => TicketScreenView());
                      },
                    ),
                    SizedBox(height: height * .055),
                    DefaultButton(
                      text: "معاملاتي",
                      press: () {
                        Get.to(() => ProjectHomeScreenView());
                      },
                    ),
                    SizedBox(height: height * .055),
                    DefaultButton(
                      text: "تسجيل خروج",
                      press: () {
                        Get.defaultDialog(
                            onCancel: () {
                              return;
                            },
                            onConfirm: () async {
                              try {
                                getstore.remove('session');
                                orpc.destroySession();
                                await FirebaseMessaging.instance.deleteToken();
                                Get.put(SignInScreenController());
                                Get.offAll(SignInScreenView());
                              } on OdooException catch (e) {
                                print(e);
                                // subscription.cancel();
                                orpc.close();
                                // exit(-1);

                              }
                            },
                            title: "هل انت متاكد ! ",
                            middleText: "هل تريد تسجيل خروج ؟ ",
                            backgroundColor: Color.fromARGB(255, 206, 160, 33),
                            titleStyle: TextStyle(color: Colors.white),
                            middleTextStyle: TextStyle(color: Colors.white),
                            radius: 30);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    //  Scaffold(
    //   appBar: AppBar(
    //     title: Text('HomeView'),
    //     centerTitle: true,
    //   ),
    //   body: Center(
    //     child: TextButton(

    //       onPressed: () {
    //         getticketData(11);

    //        },
    //       child: Text('ggggggggg'),
    //     ),
    //   ),
    // );
  }
}
