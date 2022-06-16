import 'package:flutter/material.dart';
import "package:store_project/widgets/text_logo.dart";
import "package:store_project/widgets/text_simple.dart";

class PlaceMenu extends StatelessWidget {
  const PlaceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
              title: TextSimple(
                  textValue: "place",
                  textFontSize: 24.3,
                  textFontWeight: FontWeight.w500,
                  textColor: Color(0xFFFFFFFF)),
              leading: TextLogo(textFontSize: 43.0)),
          Container(
              child: Column(children: <Widget>[
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    leading: const Icon(Icons.female, color: Color(0xFFFFFFFF)),
                    minLeadingWidth: 11.5,
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    leading: const Icon(Icons.female, color: Color(0xFFFFFFFF)),
                    minLeadingWidth: 11.5,
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    leading: const Icon(Icons.female, color: Color(0xFFFFFFFF)),
                    minLeadingWidth: 11.5,
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    leading: const Icon(Icons.female, color: Color(0xFFFFFFFF)),
                    minLeadingWidth: 11.5,
                    tileColor: Colors.transparent.withOpacity(0.2))
              ]),
              margin: const EdgeInsets.only(top: 7.4, bottom: 7.4)),
          Container(
              child: Column(children: <Widget>[
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2),
                    shape: Border(
                        bottom: BorderSide(
                            color: Colors.transparent.withOpacity(0.9),
                            width: 0.3))),
                ListTile(
                    title: const TextSimple(
                        textValue: "place", textColor: Color(0xFFFFFFFF)),
                    tileColor: Colors.transparent.withOpacity(0.2))
              ]),
              margin: const EdgeInsets.only(top: 7.4, bottom: 7.4))
        ],
      ),
    );
  }
}
