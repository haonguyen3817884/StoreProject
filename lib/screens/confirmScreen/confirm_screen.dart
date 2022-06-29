import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import "package:store_project/screens/confirmScreen/confirm_screen_controller.dart";

import "package:store_project/widgets/button.dart";

class ConfirmScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmScreenController());
  }
}

class ConfirmScreen extends GetView<ConfirmScreenController> {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            systemOverlayStyle:
                const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.transparent),
        body: Center(
            child: Container(
                child: Column(
                    children: <Widget>[
                      controller.getTitle(),
                      Container(
                          child: Column(
                              children: controller.getTexts(),
                              crossAxisAlignment: CrossAxisAlignment.start),
                          margin:
                              const EdgeInsets.only(top: 27.4, bottom: 27.4),
                          width: 274.0),
                      Button(
                          text: "Continue",
                          buttonAction: () {
                            controller.getAction();
                          })
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start),
                width: 274.0,
                margin: EdgeInsets.only(top: 74.0))),
        backgroundColor: Colors.black);
  }
}
