// ignore_for_file: unnecessary_const, prefer_const_literals_to_create_immutables

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/default_button.dart';
import 'package:elessam_law/app/data/size_config.dart';
// import 'package:elessam_law/app/data/size_config.dart';
import 'package:elessam_law/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_screen_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignInScreenView extends GetView<SignInScreenController> {
  // const SignInScreenView({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final height = Get.height;
    // SizeConfig().init(context);
    // prefs = await SharedPreferences.getInstance();

    // Get.put(controller);
    Get.put(SignInScreenController());
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

                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: 50),

                    _title(),
                    // Container(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   alignment: Alignment.centerRight,
                    //   child: Text('Forgot Password ?',
                    //       style: TextStyle(
                    //           fontSize: 14, fontWeight: FontWeight.w500)),
                    // ),
                    // _divider(),
                    // _facebookButton(),
                    SizedBox(height: height * .055),
                    // _createAccountLabel(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text:
              'هذا التطبيق خاص بعملاء الشركة يرجى التواصل مع الادارة لاسم المستخدم وكلمة المرور ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: "cairo",
              color: Color.fromARGB(255, 255, 255, 255)),
          children: [
            TextSpan(
              text: ' ',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontFamily: "cairo",
                  fontSize: 20),
            ),
            TextSpan(
              text: '',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("اسم المستخدم", emailController),
        _entryField("كلمة المرور", passController, isPassword: true),
      ],
    );
  }

  Widget _entryField(String title, TextEditingController control,
      {bool isPassword = false}) {
    return Container(
      // width: Get.width/2,
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
                fontFamily: "cairo"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              controller: control,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  // hintText: 'Enter a search term',
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Obx(
      () => controller.isLoading.value
          ? const CircularProgressIndicator(
              color: Color.fromARGB(255, 247, 137, 43),
            )
          : DefaultButton(
              text: "دخول",
              press: () async {
                controller.isLoading.value = true;

                final log =
                    await login(emailController.text, passController.text);
                if (log) {
                  controller.isLoading.value = false;
                  Get.offAll(() => HomeView());
                } else {
                  controller.isLoading.value = false;
                  Get.defaultDialog(
                      title: "خطاء في الوصول",
                      middleText: "بيانات الوصول غير صحيحة ",
                      backgroundColor: Color.fromARGB(255, 206, 160, 33),
                      titleStyle: TextStyle(color: Colors.white),
                      middleTextStyle: TextStyle(color: Colors.white),
                      radius: 30);
                }
                //  Get.offAll(() => ProjectHomeScreenView());
              },
            ),
    );

    // InkWell(
    //     onTap: () async {
    //       controller.isLoading.value = true;

    //       final log =
    //           await login(emailController.text, passController.text);
    //       if (log) {
    //         controller.isLoading.value = false;
    //         Get.offAll(() => HomeView());
    //       } else {
    //         controller.isLoading.value = false;
    //         Get.defaultDialog(
    //             title: "خطاء في الوصول",
    //             middleText: "بيانات الوصول غير صحيحة ",
    //             backgroundColor: Color.fromARGB(255, 206, 160, 33),
    //             titleStyle: TextStyle(color: Colors.white),
    //             middleTextStyle: TextStyle(color: Colors.white),
    //             radius: 30);
    //       }
    //     },
    //     child: Container(
    //       width: Get.width / 3,
    //       // height: Get.height/15,
    //       padding: EdgeInsets.symmetric(vertical: 15),
    //       alignment: Alignment.center,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(Radius.circular(5)),
    //           boxShadow: <BoxShadow>[
    //             BoxShadow(
    //                 color: Colors.grey.shade200,
    //                 offset: Offset(2, 4),
    //                 blurRadius: 5,
    //                 spreadRadius: 2)
    //           ],
    //           // ignore: prefer_const_constructors
    //           gradient: LinearGradient(
    //               begin: Alignment.centerLeft,
    //               end: Alignment.centerRight,
    //               colors: [
    //                 Color.fromARGB(255, 255, 255, 255),
    //                 Color.fromARGB(255, 255, 255, 255)
    //               ])),
    //       child: Text(
    //         'دخول',
    //         style: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.bold,
    //             fontFamily: "cairo",
    //             color: Color.fromARGB(255, 0, 0, 0)),
    //       ),
    //     ),
    //   ));
  }

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

}
