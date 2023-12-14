import 'package:flutter/material.dart';

class BodyWedget extends StatelessWidget {
  const BodyWedget({super.key, this.imagepath});
  final String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: 200,
      color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              width: 400,
              height: 500,
              color: Colors.black,
              child: Image.asset("$imagepath"))
        ],
      ),
    );
  }
}
