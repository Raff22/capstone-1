import 'package:flutter/material.dart';
import 'package:health_card/consts/colors.dart';

class AuthFelid extends StatelessWidget {
  const AuthFelid({
    super.key,
    this.hint = "Enter your Email",
    this.label = "Email",
    this.sufixIcon,
    this.isPass = false,
    this.displayPass = false,
    this.onTap,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.keyForm,
    this.validator,
  });
  final String hint;
  final String label;
  final IconData? sufixIcon;
  final bool isPass;
  final bool displayPass;
  final Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final GlobalKey? keyForm;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: keyForm,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          obscureText: !isPass ? false : !displayPass,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: red2),
              borderRadius: BorderRadius.circular(20), //<-- SEE HERE
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: red2),
              borderRadius: BorderRadius.circular(20), //<-- SEE HERE
            ),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            label: Text(
              label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            ),
            suffixIcon: isPass
                ? InkWell(
                    onTap: onTap,
                    child: Icon(!displayPass
                        ? Icons.visibility_off_sharp
                        : Icons.remove_red_eye),
                  )
                : Icon(
                    sufixIcon,
                    color: Colors.black,
                  ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
