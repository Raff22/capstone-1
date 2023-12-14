// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:health_card/global/global_widgets/text_widget.dart';

import 'package:health_card/utilities/extentions/navigation_extentions.dart';

PreferredSizeWidget AppBarWidget(
  BuildContext context,
  final String appBarTittle,
  Widget actionIcons,
) {
  return AppBar(
    title: TextWidget(text: appBarTittle),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        context.popScreen();
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    ),
    actions: [actionIcons],
  );
}
