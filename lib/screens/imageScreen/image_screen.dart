import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/screens/imageScreen/image_screen_controller.dart";
import "package:store_project/routes/route_name.dart";

import "package:store_project/config/constant_values.dart";
import 'package:store_project/widgets/row_image.dart';
import 'package:store_project/config/index_methods.dart';
import "package:store_project/models/customerImage.dart";

import "package:store_project/widgets/images_list.dart";

class ImageScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageScreenController());
  }
}

class ImageScreen extends GetView<ImageScreenController> {
  const ImageScreen({Key? key}) : super(key: key);

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
        child: Obx(() {
          return ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Colors.black45, BlendMode.darken),
              child: SizedBox(
                  child: (("" == controller.imageInput.value)
                      ? const Center(child: CircularProgressIndicator())
                      : Image.network(controller.imageInput.value,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }, fit: BoxFit.fill)),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height));
        }),
      ),
      Scaffold(
          appBar: AppBar(
              elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    controller.goToPage(RouteName.mainScreen);
                  })),
          body: Center(child: Column(children: const <Widget>[])),
          backgroundColor: Colors.transparent),
      DraggableScrollableSheet(
          initialChildSize: 0.2,
          maxChildSize: 0.6,
          minChildSize: 0.1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                child: Obx(() {
                  return ImagesList(
                      getRefresh: controller.getRefresh,
                      scrollController: scrollController,
                      getLoadMore: controller.getLoadMore,
                      loadStatus: controller.loadStatus.value,
                      customerImages: controller.data,
                      onImagePressed: controller.onImagePressed,
                      dataLength: controller.dataLength.value,
                      headList: const <Widget>[
                        SliverToBoxAdapter(
                            child: Icon(Icons.keyboard_arrow_up_outlined))
                      ]);
                }),
                padding: const EdgeInsets.only(top: 17.4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.4),
                    color: const Color(0xFFFFFFFF)));
          })
    ]);
  }
}
