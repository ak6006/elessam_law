import 'package:get/get.dart';

import '../controllers/project_home_screen_controller.dart';

class ProjectHomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectHomeScreenController>(
      () => ProjectHomeScreenController(),
    );
  }
}
