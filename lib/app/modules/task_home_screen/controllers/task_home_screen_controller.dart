import 'dart:convert';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/modules/task_home_screen/views/taskmodel.dart';
import 'package:get/get.dart';

class TaskHomeScreenController extends GetxController {
  //TODO: Implement TaskHomeScreenController

  final count = 0.obs;
  final taskModelctr = <Tasktmodel>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<dynamic> getTasktData() async {
    try {
      var res = await orpc.callKw({
        'model': 'project.task', //.category',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          'domain': [
            ['project_id', '=', globalprojectid] //session.userId
          ],
          'fields': [
            'id',
            'name',
            'tag_ids',
            'partner_id',
            'stage_id',
            'description',
            'project_id', //for project name
            'user_ids',
            'priority',
            'kanban_state', //status
            'kanban_state_label',
            'total_hours_spent',
            'portal_user_names',
            'commercial_partner_id',
            // 'create_uid',
          ],
        },
      });
      //*print(globalprojectid);
      //*print(jsonEncode(res));
      // employeeData = (employeeDtataFromJson(jsonEncode(res)));
      // ticketModel = (ticketModelFromJson)(jsonEncode(res));
      return jsonEncode(res);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> inittask() async {
    print('innnnnnnnnnnnnnnnit task home');
    final res = await getTasktData();
    taskModelctr.value = (tasktmodelFromJson(res));
    return true;
  }

  @override
  void onReady() async {
    // final res = await getTasktData();
    // taskModelctr.value = (tasktmodelFromJson(res));
    inittask();
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
