import 'package:flutter/material.dart';
import 'package:linkyou_task/core/utils/size.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validator,
      this.hasOnTap,
      this.onTap,
      this.obscureText,
      this.keyboardType});
  TextEditingController controller;
  final String labelText;
  String? Function(String?)? validator;
  TextInputType? keyboardType;
  Function()? onTap;
  bool? hasOnTap;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, //_nameController,
      decoration: InputDecoration(
        labelText: labelText, //'Property Name',
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: height(context) * 0.02,
          horizontal: width(context) * 0.04,
        ),
      ),
      keyboardType: keyboardType,

      style: TextStyle(fontSize: width(context) * 0.04),
      validator: validator,
      // enabled: hasOnTap == true ? false : true,
      obscureText: obscureText ?? false,
      onTap: onTap,
    );
  }
}
