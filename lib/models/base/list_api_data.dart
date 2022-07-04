import 'dart:convert';

import 'base_parser_json.dart';

ListAPIResponse assigneeFromJson(String str) =>
    ListAPIResponse.fromJson(json.decode(str));

String assigneeToJson(ListAPIResponse data) => json.encode(data.toJson());

class ListAPIResponse<T> {
  ListAPIResponse({
    required this.data,
  });

  final List<T> data;

  factory ListAPIResponse.fromJson(List<dynamic> jsonList) => ListAPIResponse(
        data: List<T>.from(jsonList.map((x) => GPParserJson.parseJson<T>(x))),
      );

  List<dynamic> toJson() => List<dynamic>.from(data.map((x) => x.toString()));
}
