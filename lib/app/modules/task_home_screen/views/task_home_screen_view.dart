// ignore_for_file: prefer_const_constructors

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/modules/project_home_screen/controllers/project_home_screen_controller.dart';
import 'package:elessam_law/app/modules/project_home_screen/views/project_home_screen_view.dart';
import 'package:elessam_law/app/modules/task_messages_screen/controllers/task_messages_screen_controller.dart';
import 'package:elessam_law/app/modules/task_messages_screen/views/task_messages_screen_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/task_home_screen_controller.dart';

class TaskHomeScreenView extends GetView<TaskHomeScreenController> {
  @override
  Widget build(BuildContext context) {
    final c = Get.put(TaskHomeScreenController());
    c.inittask();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          globalrojectname,
          style: essamStyle.copyWith(
              fontSize: 20, color: Color.fromARGB(255, 10, 21, 100)),
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
              '',
              style: TextStyle(
                  color: Color.fromARGB(255, 214, 168, 60),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              // Get.put(ProjectHomeScreenController());
              // Get.offAll(() => ProjectHomeScreenView());
              Get.to(() => ProjectHomeScreenView());
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 29, 21, 145),
            ),
          ),
        ],
      ),
      // ignore: prefer_const_constructors
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

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: createDataTable(),
                    ),
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
      dataRowHeight: 80,
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
          'المهمة',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'المرحلة',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'الحالة',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'المسؤول',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'عدد الساعات',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'ملاحظات',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];
  }

  List<DataRow> _createRows() {
    // List<bool> _selected = [];
    // _selected = List<bool>.generate(
    //     controller.ticketModel.value.length, (int index) => false);
    return controller.taskModelctr.value
        .map(
          (tic) => DataRow(
            // key: _selected,
            cells: [
              DataCell(Text(
                tic.name,
                style: essamStyle,
              )),
              DataCell(
                Text(
                  tic.stageId[1].toString(),
                  style: essamStyle,
                ),
              ),
              DataCell(
                Text(
                  tic.kanbanState
                      .replaceAll('blocked', 'محجوب')
                      .replaceAll('done', 'تم التنفيذ')
                      .replaceAll('normal', 'قيد التنقيذ'),
                  style: essamStyle,
                ),
              ),
              DataCell(
                Text(
                  tic.portalUserNames,
                  style: essamStyle,
                ),
              ),
              DataCell(
                Text(
                  tic.totalHoursSpent.toString(),
                  style: essamStyle,
                ),
              ),
              DataCell(
                Text(
                  tic.description
                      .replaceAll('<h1>', '')
                      .replaceAll('</h1>', '')
                      .replaceAll('<p>', '')
                      .replaceAll('</p>', '')
                      .replaceAll('<br>', ''),
                  style: essamStyle,
                ),
              ),
            ],
            // selected: _selected[row],

            onSelectChanged: (bool? selected) async {
              // globalprojectid = tic.partnerId[0];
              // controller.getTasktData();
              globaltaskid = tic.id;
              globaltaskname = tic.name;
              //  await controller.showticketmessage(tic.websiteMessageIds);
              // globalwebsiteMessageIds = tic.websiteMessageIds;
              // globaltic_id = tic.id;
              //*print(globaltaskid);
              // globalticname = tic.name;
              Get.offAll(() => TaskMessagesScreenView());
              // Get.put(TaskMessagesScreenController()).initmsg();
              // Get.to(() => TaskMessagesScreenView());
            },
          ),
        )
        .toList();
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@
}
