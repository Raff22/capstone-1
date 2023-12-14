import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TableCard extends StatelessWidget {
  @override
  final String weight;
  final String height;
  final String bloodType;
  final String birthday;

  const TableCard(
      {super.key,
      required this.weight,
      required this.height,
      required this.bloodType,
      required this.birthday});

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTableRow('main_screen.weighttext'.tr(), weight),
            Divider(),
            _buildTableRow('main_screen.heighttext'.tr(), height, subtitle: ""),
            Divider(),
            _buildTableRow(
              'main_screen.bloodtext'.tr(),
              bloodType,
            ),
            Divider(),
            _buildTableRow('main_screen.birthdaytext'.tr(), birthday),
            // ... add more rows here
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String title, String data, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          if (subtitle != null)
            Text(subtitle, style: TextStyle(color: Colors.red)),
          Text(data),
        ],
      ),
    );
  }
}
