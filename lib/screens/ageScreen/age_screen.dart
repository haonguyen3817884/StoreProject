import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import "package:store_project/widgets/text_logo.dart";
import "package:store_project/widgets/age_text_place.dart";

import "package:store_project/widgets/age_input_place.dart";

import "package:store_project/screens/ageScreen/age_screen_controller.dart";

class AgeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AgeScreenController());
  }
}

class AgeScreen extends GetView<AgeScreenController> {
  const AgeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Colors.black, Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),

              /// change this to your  image directory
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
          ),
        ),
      ),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0.0,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent),
                  backgroundColor: Colors.transparent),
              body: Center(
                  child: Column(children: <Widget>[
                Container(
                    child: const TextLogo(),
                    margin: const EdgeInsets.only(
                        top: 0, left: 0, right: 0, bottom: 74)),
                SizedBox(
                    child: const Divider(
                        color: Color.fromARGB(255, 98, 98, 98), thickness: 0.8),
                    width: MediaQuery.of(context).size.width * 0.4),
                Expanded(child: Obx(() {
                  return (controller.isText.value)
                      ? const AgeTextPlace()
                      : const AgeInputPlace();
                }))
              ])),
              backgroundColor: Colors.transparent))
    ]);
  }
}
