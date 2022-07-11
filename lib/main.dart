import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import "package:store_project/routes/route_name.dart";
import "package:store_project/routes/route_places.dart";

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final storage = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: (null == storage.read("customerAge"))
            ? RouteName.ageScreen
            : RouteName.mainScreen,
        getPages: RoutePlaces.places);
  }
}
