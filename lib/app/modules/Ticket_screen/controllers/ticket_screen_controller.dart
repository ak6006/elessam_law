// import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/const.dart';
import 'package:elessam_law/app/data/ticketmessage.dart';
import 'package:elessam_law/app/data/ticketmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TicketScreenController extends GetxController {
  //TODO: Implement TicketScreenController

  final count = 0.obs;

//List<TicketModel>
  final ticketModel = <TicketModel>[].obs;
//List<Ticketmessage>
  // final ticketMessage = <Ticketmessage>[].obs;

  //   TextEditingController nameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // int currentIndex = 0;
  //  List<User> userList = [
  //   User(name: "a", email: "a"),
  //   User(name: "d", email: "b"),
  //   User(name: "c", email: "c"),
  // ];

  // Future<void> showticketmessage(List<int> val) async {
  //   dynamic res = await getmessageticketData(val);
  //   if (val != false) {
  // ticketMessage.value = (ticketmessageFromJson((res)));

  //   }
  // }
//  void updateTextControllers(User user) {
//     nameController.text = user.name;
//     emailController.text = user.email;
//     update();
//   }
//   void updateForm() {
//     User user = User(name: nameController.text, email: emailController.text);
//     userList[currentIndex] = user;
//     update();
//   }

//   void addUserToList(name, email) {
//     userList.add(User(name: name, email: email));
//     update();
//   }

//   void updateLanguageInformation() {
//     // for (var i = 0; i <= userList.length; i++) { // ** don't need nested for loop here **
//     for (var user in userList) {
//       print("Name: " + user.name + " Email: " + user.email);
//     }
//     // }
//   }
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    // print('VVVVVVVVVVVVVVVVVVVVVVVVVVVVV');
    dynamic res = await get_ticket_data();
    ticketModel.value = (ticketModelFromJson)((res));
    super.onReady();
  }

  @override
  void onClose() {
    // print('bbbbbbbbbbbbbbbbbbbb');
  }

  void increment() => count.value++;
}
