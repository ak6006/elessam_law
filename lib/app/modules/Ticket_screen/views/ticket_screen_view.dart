// import 'dart:convert';

// ignore_for_file: prefer_const_constructors

// import 'package:elessam_law/app/data/const.dart';
import 'dart:convert';
import 'dart:math';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/data/default_button.dart';
import 'package:elessam_law/app/data/discount_banner.dart';
import 'package:elessam_law/app/modules/add_task_screen/views/add_task_screen_view.dart';
import 'package:elessam_law/app/modules/home/controllers/home_controller.dart';
import 'package:elessam_law/app/modules/home/views/home_view.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/controllers/message_ticket_screen_controller.dart';
import 'package:elessam_law/app/modules/message_Ticket_screen/views/message_ticket_screen_view.dart';
// import 'package:elessam_law/app/data/size_config.dart';
// import 'package:elessam_law/app/data/ticketmodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

import 'package:get/get.dart';

import '../controllers/ticket_screen_controller.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class TicketScreenView extends GetView<TicketScreenController> {
  final _user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');
  List<types.Message> _messages = [];

  void _addMessage(types.Message message) {
    _messages.insert(0, message);
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    // prefs = await SharedPreferences.getInstance();

    Get.put(TicketScreenController());
    // controller.update();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'استشارات',
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
              'اضافة',
              style: TextStyle(
                  color: Color.fromARGB(255, 26, 59, 177),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              // Get.put(TicketScreenController());
              Get.offAll(() => AddTaskScreenView());
            },
            icon: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 29, 21, 145),
            ),
          ),
          TextButton.icon(
            label: const Text(
              '',
              style: TextStyle(
                  color: Color.fromARGB(255, 214, 168, 60),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              Get.put(HomeController());
              Get.offAll(() => HomeView());
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 29, 21, 145),
            ),
          ),
        ],
      ),
      body: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
        )),
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: height * .2),

                //+++++++++++++++++++++++
// Ge   //++++++++++++++++++

                DiscountBanner(),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Obx(
                    () => createDataTable(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//controller

  DataTable createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      dividerThickness: 5,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Color.fromARGB(255, 250, 247, 247),
            width: 0.5,
          ),
        ),
      ),
      dataRowHeight: 80,
      dataRowColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? Colors.blue
              : Color.fromARGB(100, 215, 217, 219)),
      showBottomBorder: true,
      headingTextStyle:
          TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.deepOrange),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Text(
        'القسم',
        style: TextStyle(color: Colors.white),
      )),
      DataColumn(
          label: Text(
        'الاستشارة',
        style: TextStyle(color: Colors.white),
      )),
      DataColumn(
          label: Text(
        'الحالة',
        style: TextStyle(color: Colors.white),
      ))
    ];
  }

  List<DataRow> _createRows() {
    // List<bool> _selected = [];
    // _selected = List<bool>.generate(
    //     controller.ticketModel.value.length, (int index) => false);
    return controller.ticketModel.value
        .map(
          (tic) => DataRow(
            // key: _selected,
            cells: [
              DataCell(Text(
                tic.name,
                style: essamStyle,
              )),
              DataCell(Text(
                tic.categoryId[1],
                style: essamStyle,
              )),
              DataCell(
                Text(
                  tic.stageId[1]
                      .replaceAll('New', 'جديد')
                      .replaceAll('Awaiting', 'انتظار'),
                  style: essamStyle,
                ),
              ),
            ],
            // selected: _selected[row],

            onSelectChanged: (bool? selected) async {
              //  await controller.showticketmessage(tic.websiteMessageIds);
              globalwebsiteMessageIds = tic.websiteMessageIds;
              globaltic_id = tic.id;
              globalticname = tic.name;
              Get.offAll(() => MessageTicketScreenView());
            },
          ),
        )
        .toList();
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@
}
