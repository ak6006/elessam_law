// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:elessam_law/app/data/constants.dart';
import 'package:elessam_law/app/data/default_button.dart';
import 'package:elessam_law/app/modules/Ticket_screen/views/ticket_screen_view.dart';
import 'package:elessam_law/app/modules/add_task_screen/views/ticketcateg.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_task_screen_controller.dart';

class AddTaskScreenView extends GetView<AddTaskScreenController> {
  final subjectController = TextEditingController();
  final descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final c = Get.put(AddTaskScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'استشارة جديده',
          style: essamStyle.copyWith(
              fontSize: 28, color: Color.fromARGB(255, 10, 21, 100)),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          // const SizedBox(
          //   width: 120,
          // ),
          TextButton.icon(
            label: const Text(
              '',
              style: TextStyle(
                  color: Color.fromARGB(255, 26, 59, 177),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              //  c.initmsg();
              // Get.put(TicketScreenController());
              //  Get.offAll(() => TicketScreenView());
            },
            icon: const Icon(
              Icons.arrow_circle_down,
              color: Color.fromARGB(255, 29, 21, 145),
            ),
          ),
          TextButton.icon(
            label: const Text(
              '',
              style: TextStyle(
                  color: Color.fromARGB(255, 26, 59, 177),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              // Get.put(TicketScreenController());
              Get.offAll(() => TicketScreenView());
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 29, 21, 145),
            ),
          ),
        ],
      ),
      body:
          //  Container(
          //   height: Get.height,
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //     image: AssetImage("assets/images/bg.jpg"),
          //     fit: BoxFit.cover,
          //   )),
          //   child:
          Obx(
        (() => SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Text('القسم'),
                        Text(
                          c.count.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        DropdownButton(
                          hint: Text(c.dropdownvalue),
                          // underline: Text('القسم'),
                          // Initial Value
                          // value: c.dropdownvalue.toString(),
                          items: c.ticketcategoryctr.map((items) {
                            return DropdownMenuItem(
                              value: items, //c.dropdownvalue.value,
                              child: Text(
                                items.name,
                                style: essamStyle.copyWith(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            // c.dropdownvalue = value;
                            c.updatedrop(value.name);
                            c.increment();
                            c.ida.value = value.id;
                            print(c.ida);
                            // print(c.count.value);
                          },
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'الموضوع',
                          style: essamStyle.copyWith(color: Colors.black),
                        ),
                        _entryField('الموضوغ', subjectController, multi: true),
                        // TextField(
                        //   keyboardType: TextInputType.multiline,
                        //   maxLines: null,
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'تفاصيل',
                          style: essamStyle.copyWith(color: Colors.black),
                        ),
                        _entryField('تفاصيل', descController, multi: false),
                        SizedBox(height: Get.height * .055),
                        DefaultButton(
                          text: "حفظ",
                          press: () async {
                            await c.addNewTicket(
                                descController.text, subjectController.text);

                            Get.offAll(() => TicketScreenView());
                          },
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height: height * .2),

                  // Directionality(
                  //   textDirection: TextDirection.rtl,
                  //   child: Obx(
                  //     () => SingleChildScrollView(
                  //       scrollDirection: Axis.horizontal,
                  //       // child: createDataTable(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController control,
      {bool isPassword = false, multi = false}) {
    return Container(
      // width: Get.width/2,
      // margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
                fontFamily: "cairo"),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            textAlign: TextAlign.right,
            obscureText: isPassword,
            controller: control,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                labelText: title,
                // hintText: 'Enter a search term',
                filled: true),
            keyboardType: multi ? TextInputType.name : TextInputType.multiline,
            minLines: 1, // <-- SEE HERE
            maxLines: 5, // <-- SEE HERE
          )
        ],
      ),
    );
  }
}
