import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'category.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Category {
  Category(this.name);

  String name;

  String getName() {
    return name;
  }

  void setName(String categoryName) {
    name = categoryName;
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Category.fromJson(String categoryName) =>
      _$CategoryFromJson(categoryName);
}
