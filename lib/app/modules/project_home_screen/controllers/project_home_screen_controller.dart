import 'dart:convert';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/modules/project_home_screen/projectmodel_model.dart';
import 'package:get/get.dart';

class ProjectHomeScreenController extends GetxController {
  //TODO: Implement ProjectHomeScreenController

  final count = 0.obs;
  final projectModelctr = <Projectmodel>[].obs;
  Future<dynamic> getProjectData() async {
    try {
      var res = await orpc.callKw({
        'model': 'project.project', //.category',
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
            'tag_ids',
            'partner_id',
            'user_id', //for assignees
            'description',
            'task_count',
            'tasks',
            'task_count_with_subtasks',
            'message_ids',
            'update_ids',
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

  @override
  void onInit() {
    //*print("ZZZZZZZZZZZZZZZZZ project init");
    super.onInit();
  }

  @override
  void onReady() async {
    final res = await getProjectData();
    projectModelctr.value = (projectmodelFromJson(res));
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
