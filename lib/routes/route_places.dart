import 'package:get/get.dart';
import "package:store_project/routes/route_name.dart";
import "package:store_project/screens/ageScreen/age_screen.dart";

import 'package:store_project/screens/mainScreen/main_screen.dart';

import "package:store_project/screens/confirmScreen/confirm_screen.dart";
import "package:store_project/screens/imageScreen/image_screen.dart";

class RoutePlaces {
  static List<GetPage> places = <GetPage>[
    GetPage(
        name: RouteName.ageScreen,
        page: () => const AgeScreen(),
        binding: AgeScreenBinding()),
    GetPage(
        name: RouteName.mainScreen,
        page: () => const MainScreen(),
        binding: MainScreenBinding()),
    GetPage(
        name: RouteName.confirmScreen,
        page: () => const ConfirmScreen(),
        binding: ConfirmScreenBinding()),
    GetPage(
        name: RouteName.imageScreen,
        page: () => const ImageScreen(),
        binding: ImageScreenBinding())
  ];
}
