import 'package:get/get.dart';
import "package:store_project/routes/route_name.dart";
import "package:store_project/screens/ageScreen/age_screen.dart";

import "package:store_project/screens/placeScreen/place_screen.dart";

import "package:store_project/screens/confirmScreen/confirm_screen.dart";
import "package:store_project/screens/imageScreen/image_screen.dart";

class RoutePlaces {
  static List<GetPage> places = <GetPage>[
    GetPage(
        name: RouteName.agePlace,
        page: () => const AgeScreen(),
        binding: AgeScreenBinding()),
    GetPage(
        name: RouteName.placePlace,
        page: () => const PlaceScreen(),
        binding: PlaceScreenBinding()),
    GetPage(
        name: RouteName.confirmPlace,
        page: () => const ConfirmScreen(),
        binding: ConfirmScreenBinding()),
    GetPage(
        name: RouteName.imagePlace,
        page: () => const ImageScreen(),
        binding: ImageScreenBinding())
  ];
}
