import 'package:get/get.dart';

import '../modules/Ticket_screen/bindings/ticket_screen_binding.dart';
import '../modules/Ticket_screen/views/ticket_screen_view.dart';
import '../modules/add_task_screen/bindings/add_task_screen_binding.dart';
import '../modules/add_task_screen/views/add_task_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/message_Ticket_screen/bindings/message_ticket_screen_binding.dart';
import '../modules/message_Ticket_screen/views/message_ticket_screen_view.dart';
import '../modules/project_home_screen/bindings/project_home_screen_binding.dart';
import '../modules/project_home_screen/views/project_home_screen_view.dart';
import '../modules/sign_in_screen/bindings/sign_in_screen_binding.dart';
import '../modules/sign_in_screen/views/sign_in_screen_view.dart';
import '../modules/task_home_screen/bindings/task_home_screen_binding.dart';
import '../modules/task_home_screen/views/task_home_screen_view.dart';
import '../modules/task_messages_screen/bindings/task_messages_screen_binding.dart';
import '../modules/task_messages_screen/views/task_messages_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN_SCREEN;
  static const SECONDROUT = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN_SCREEN,
      page: () => SignInScreenView(),
      binding: SignInScreenBinding(),
    ),
    GetPage(
      name: _Paths.TICKET_SCREEN,
      page: () => TicketScreenView(),
      binding: TicketScreenBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE_TICKET_SCREEN,
      page: () => MessageTicketScreenView(),
      binding: MessageTicketScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_HOME_SCREEN,
      page: () => ProjectHomeScreenView(),
      binding: ProjectHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.TASK_HOME_SCREEN,
      page: () => TaskHomeScreenView(),
      binding: TaskHomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.TASK_MESSAGES_SCREEN,
      page: () => TaskMessagesScreenView(),
      binding: TaskMessagesScreenBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK_SCREEN,
      page: () => AddTaskScreenView(),
      binding: AddTaskScreenBinding(),
    ),
  ];
}
