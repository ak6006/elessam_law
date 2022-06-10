import 'dart:convert';

import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/modules/add_task_screen/views/ticketcateg.dart';
import 'package:get/get.dart';

class AddTaskScreenController extends GetxController {
  //TODO: Implement AddTaskScreenController

  final count = 0.obs;
  final ida = 0.obs;
  final ticketcategoryctr = <TicketCateg>[].obs;
  String dropdownvalue = 'اختار القسم';

  void updatedrop(String val) {
    dropdownvalue = val;
    update();
  }

  Future<dynamic> getcategory() async {
    try {
      var res = await orpc.callKw({
        'model': 'helpdesk.ticket.category', //.category',
        'method': 'search_read',
        'args': [],
        'kwargs': {
          'context': {'bin_size': true},
          // 'domain': [
          //  ['id', '=', 263] //session.userId
          // ],
          'fields': [
            'id',
            'name',
            'company_id',
            // 'mail_mail_id',
            //'mail_message_id',
            //'notification_status',
            //'notification_type',
            // 'res_partner_id', //for project name
            // 'user_ids',
            // 'priority',
            // 'kanban_state', //status
            // 'kanban_state_label',
            // 'total_hours_spent',
            // 'portal_user_names',
            // 'commercial_partner_id',
            // 'create_uid',
          ],
        },
      });
      // print(globalprojectid);
      print(jsonEncode(res));
      ticketcategoryctr.value = ticketCategFromJson(jsonEncode(res));
      print(ticketcategoryctr[0].name);

      // employeeData = (employeeDtataFromJson(jsonEncode(res)));
      // ticketModel = (ticketModelFromJson)(jsonEncode(res));
      return jsonEncode(res);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> addNewTicket(String desc, String sub) async {
    try {
      var res1 = await orpc.callRPC('/submitted/ticketjson', 'call', {
        "category": ida.value,
        "description": desc,
        "subject": sub,
      });
      print('VVVVVVVVVVVV ' + res1.toString());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void onInit() {
    getcategory();
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
