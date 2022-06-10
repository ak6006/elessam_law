import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TaskMessagViewView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TaskMessagViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TaskMessagViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
