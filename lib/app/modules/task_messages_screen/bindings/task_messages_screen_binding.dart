import 'package:get/get.dart';

import '../controllers/task_messages_screen_controller.dart';

class TaskMessagesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskMessagesScreenController>(
      () => TaskMessagesScreenController(),
    );
  }
}
