import 'package:get/get.dart';

import '../controllers/message_ticket_screen_controller.dart';

class MessageTicketScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageTicketScreenController>(
      () => MessageTicketScreenController(),
    );
  }
}
