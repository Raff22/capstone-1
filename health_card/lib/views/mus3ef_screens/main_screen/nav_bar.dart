import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:health_card/views/mus3ef_screens/main_screen.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/front_body_screen.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/qr_code_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key, required this.idText});
  final String idText;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final items = [
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.medical_information_outlined,
      size: 30,
      color: Colors.white,
    ),
    const Icon(
      Icons.qr_code,
      size: 30,
      color: Colors.white,
    ),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(255, 160, 9, 9),
        backgroundColor: Colors.blue.withOpacity(0),
        height: 60,
        items: items,
        index: index,
        onTap: (selectedindex) {
          print(index);
          setState(() {
            index = selectedindex;
          });
        },
      ),
      body: Container(
        // color: Colors.blue,
        alignment: Alignment.center,
        child: selectedpage(index: index, idText: widget.idText),
      ),
    );
  }

  Widget selectedpage({required int index, required String idText}) {
    Widget widget = FrontBody(
      patientId: idText,
    );

    switch (index) {
      case 0:
        widget = MainScreen(idText: idText);
        break;
      case 1:
        widget = FrontBody(
          patientId: idText,
        );
        break;

      case 2:
        widget = BarCodeScanner();
        break;
      default:
        widget = MainScreen(
          idText: idText,
        );
    }

    return widget;
  }
}
