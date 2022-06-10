import 'package:get/get.dart';

import '../controllers/ticket_screen_controller.dart';

class TicketScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketScreenController>(
      () => TicketScreenController(),
    );
  }
}
