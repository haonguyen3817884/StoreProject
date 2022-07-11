import 'package:json_annotation/json_annotation.dart';
import "package:store_project/config/index_methods.dart";

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'customerImage.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class CustomerImage {
  CustomerImage(this.customerImageId, this.customerImageUrl);

  @JsonKey(name: "ImageID")
  String customerImageId;

  @JsonKey(name: "ImageViewURL")
  String customerImageUrl;

  String getCustomerImageId() {
    return customerImageId;
  }

  void setCustomerImageId(String customerImageId) {
    customerImageId = customerImageId;
  }

  String getCustomerImageUrl() {
    return customerImageUrl;
  }

  void setCustomerImageUrl(String customerImageUrl) {
    customerImageUrl = customerImageUrl;
  }

  static List<CustomerImage> getImagesByRow(
      List<CustomerImage> customerImages, int rowIndex, int max) {
    List<CustomerImage> imageList = <CustomerImage>[];

    imageList = customerImages.sublist(
        rowIndex * max,
        rowIndex * max +
            ((isLastRow(rowIndex, max, customerImages.length))
                ? customerImages.length % max
                : max));

    return imageList;
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CustomerImage.fromJson(Map<String, dynamic> json) =>
      _$CustomerImageFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CustomerImageToJson(this);
}
