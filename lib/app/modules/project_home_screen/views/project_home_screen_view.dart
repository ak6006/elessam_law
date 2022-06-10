// ignore_for_file: prefer_const_constructors

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/data/default_button.dart';
import 'package:elessam_law/app/modules/home/controllers/home_controller.dart';
import 'package:elessam_law/app/modules/home/views/home_view.dart';
import 'package:elessam_law/app/modules/task_home_screen/views/task_home_screen_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/project_home_screen_controller.dart';

class ProjectHomeScreenView extends GetView<ProjectHomeScreenController> {
  const ProjectHomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(ProjectHomeScreenController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مشاريع',
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
          'المشروع',
          style: TextStyle(color: Colors.white),
        ),
      ),
      DataColumn(
        label: Text(
          'عدد المهام',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // DataColumn(
      //   label: Text(
      //     'الحالة',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // )
    ];
  }

  List<DataRow> _createRows() {
    // List<bool> _selected = [];
    // _selected = List<bool>.generate(
    //     controller.ticketModel.value.length, (int index) => false);
    return controller.projectModelctr.value
        .map(
          (tic) => DataRow(
            // key: _selected,
            cells: [
              DataCell(Text(
                tic.name,
                style: essamStyle,
              )),
              DataCell(Text(
                tic.taskCount.toString(),
                style: essamStyle,
              )),
            ],
            // selected: _selected[row],

            onSelectChanged: (bool? selected) async {
              globalprojectid = tic.id;
              globalrojectname = tic.name;
              // controller.getTasktData();
              //  await controller.showticketmessage(tic.websiteMessageIds);
              // globalwebsiteMessageIds = tic.websiteMessageIds;
              // globaltic_id = tic.id;

              // globalticname = tic.name;
              // Get.offAll(() => TaskHomeScreenView());
              Get.to(() => TaskHomeScreenView());
            },
          ),
        )
        .toList();
  }

  //@@@@@@@@@@@@@@@@@@@@@@@@@@
}
