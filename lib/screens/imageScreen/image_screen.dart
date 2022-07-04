import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loadany/loadany.dart';
import "package:store_project/screens/imageScreen/image_screen_controller.dart";
import "package:store_project/routes/route_name.dart";

import "package:store_project/config/constant_values.dart";
import "package:store_project/widgets/place_image.dart";
import "package:store_project/config/index_loading.dart";

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
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              child: Container(
                  child: (("" == controller.imageInput.value)
                      ? Center(child: CircularProgressIndicator())
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
                  icon: Icon(Icons.close),
                  onPressed: () {
                    controller.placeIn(RouteName.placePlace);
                  })),
          body: Center(child: Column(children: <Widget>[])),
          backgroundColor: Colors.transparent),
      DraggableScrollableSheet(
          initialChildSize: 0.2,
          maxChildSize: 0.6,
          minChildSize: 0.1,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
                child: Obx(() {
                  return RefreshIndicator(
                    onRefresh: controller.getRefresh,
                    child: LoadAny(
                      onLoadMore: controller.getLoadMore,
                      status: controller.loadStatus.value,
                      loadingMsg: ConstantValues.loading,
                      errorMsg: ConstantValues.loadingError,
                      finishMsg: ConstantValues.loadingFinish,
                      child: CustomScrollView(slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PlaceImage(
                                  places: controller.customerImages.sublist(
                                      index * ConstantValues.maxItemsInOneLine,
                                      index * ConstantValues.maxItemsInOneLine +
                                          ((isLengthValid(
                                                  index,
                                                  ConstantValues
                                                      .maxItemsInOneLine,
                                                  controller.dataLength.value))
                                              ? controller.dataLength.value %
                                                  ConstantValues
                                                      .maxItemsInOneLine
                                              : ConstantValues
                                                  .maxItemsInOneLine)));
                            },
                            childCount: (controller.dataLength.value /
                                    ConstantValues.maxItemsInOneLine)
                                .ceil(),
                          ),
                        ),
                      ], controller: scrollController),
                    ),
                  );
                }),
                color: Color(0xFFFFFFFF));
          })
    ]);
  }
}
