// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customerImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerImage _$CustomerImageFromJson(Map<String, dynamic> json) =>
    CustomerImage(
      json['ImageID'] as String,
      json['ImageViewURL'] as String,
    );

Map<String, dynamic> _$CustomerImageToJson(CustomerImage instance) =>
    <String, dynamic>{
      'ImageID': instance.customerImageId,
      'ImageViewURL': instance.customerImageUrl,
    };
