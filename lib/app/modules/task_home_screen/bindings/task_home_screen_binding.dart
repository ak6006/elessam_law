import 'package:get/get.dart';

import '../controllers/task_home_screen_controller.dart';

class TaskHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskHomeScreenController>(
      () => TaskHomeScreenController(),
    );
  }
}
