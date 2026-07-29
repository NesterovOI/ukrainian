import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextFromField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFromField(
      controller: controller,
      hintText: hintText,
      labelText: labelText,
      isPassword: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
