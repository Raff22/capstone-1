import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:health_card/global/globals.dart';
import 'package:health_card/utilities/extentions/size_extentions.dart';
import 'package:health_card/views/mus3ef_screens/main_screen/part_screens/doctor_view/doctor_view.dart';

class imageprofile extends StatelessWidget {
  const imageprofile({
    super.key,
    required this.path,
  });
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(divide: 2.3),
      height: context.getHeight(divide: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.amber),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: path != null && path!.isNotEmpty
            ? CachedNetworkImage(imageUrl: path!, fit: BoxFit.cover)
            : Image.asset("assets/images/img1.jpg", fit: BoxFit.cover),
      ),
    );
  }
}

class mySpacer extends StatelessWidget {
  const mySpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 1,
      color: Colors.black,
    );
  }
}

class pationtCard extends StatelessWidget {
  const pationtCard({
    super.key,
    required this.imgpath,
    required this.title,
    required this.pathfunc,
  });
  final String imgpath;
  final String title;
  final Function pathfunc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.getHeight(divide: 8),
          width: context.getWidth(divide: 1.1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 10,
          child: InkWell(
            onTap: () {
              pathfunc();
            },
            child: Container(
              height: context.getHeight(divide: 10),
              width: context.getWidth(divide: 1.2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffddeaed),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 69, 69, 69).withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ]),
            ),
          ),
        ),
        Positioned(
            left: 2,
            bottom: 8,
            child: Container(
              height: context.getHeight(divide: 9.5),
              width: context.getWidth(divide: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: -13)
                ],
                borderRadius: BorderRadius.circular(70),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(
                    "$imgpath",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )),
        Positioned(
            left: 100,
            top: 40,
            child: Text("$title",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
      ],
    );
  }
}

class cardInfo extends StatelessWidget {
  const cardInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        mySpacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('main_screen.nametext'.tr(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Text(
          "${globalCurrentPatient!.fullName!}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        mySpacer(),
        Column(
          children: [
            Text("main_screen.IDtext".tr(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(" 111111",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("main_screen.agetext".tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Text("20",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}
