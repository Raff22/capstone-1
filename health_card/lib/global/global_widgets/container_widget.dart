import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {super.key,
      this.height,
      this.width,
      required this.borderColor,
      required this.borderWidth,
      this.child,
      required this.borderRadius,
      required this.containerColor,
      required this.blurRadius,
      required this.shadowColor,
      this.onPressed, this.padding});
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color borderColor;
  final double borderWidth;
  final Widget? child;
  final double borderRadius;
  final Color containerColor;
  final double blurRadius;
  final Color shadowColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [BoxShadow(blurRadius: blurRadius, color: shadowColor)],
            color: containerColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: child,
      ),
    );
  }
}
