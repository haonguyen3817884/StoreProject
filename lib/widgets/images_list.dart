import 'package:flutter/material.dart';
import 'package:loadany/loadany.dart';

import "package:store_project/models/customerImage.dart";
import "package:store_project/config/constant_values.dart";
import "package:store_project/widgets/row_image.dart";

class ImagesList extends StatelessWidget {
  ImagesList(
      {Key? key,
      ScrollController? scrollController,
      required this.getRefresh,
      required this.getLoadMore,
      required this.loadStatus,
      required this.customerImages,
      required this.onImagePressed,
      required this.dataLength,
      this.headList = const <Widget>[]})
      : super(key: key) {
    if (scrollController != null) {
      this.scrollController = scrollController;
    }
  }

  final Future<void> Function() getRefresh;

  final Future<void> Function() getLoadMore;

  final LoadStatus loadStatus;

  final List<CustomerImage> customerImages;

  final Function onImagePressed;

  final int dataLength;

  final List<Widget> headList;

  ScrollController scrollController = ScrollController();

  List<Widget> getSlivers() {
    List<Widget> customerImagesList = <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return RowImage(
                images: CustomerImage.getImagesByRow(List.from(customerImages),
                    index, ConstantValues.maxItemsInOneLine),
                onImagePressed: onImagePressed);
          },
          childCount: (dataLength / ConstantValues.maxItemsInOneLine).ceil(),
        ),
      ),
    ];

    return List.from(headList)..addAll(customerImagesList);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getRefresh,
      child: LoadAny(
        onLoadMore: getLoadMore,
        status: loadStatus,
        loadingMsg: ConstantValues.loading,
        errorMsg: ConstantValues.loadingError,
        finishMsg: ConstantValues.loadingFinish,
        child: CustomScrollView(
            slivers: getSlivers(), controller: scrollController),
      ),
    );
  }
}
