
import 'package:flutter/material.dart';
import 'package:linkyou_task/core/utils/size.dart';

// ignore: must_be_immutable
class CustomElevatedButon extends StatelessWidget {
  CustomElevatedButon(
      {super.key,
      required this.onPressed,
      required this.buttonColor,
      required this.buttonText});
  Function()? onPressed;
  Color buttonColor;
  String buttonText;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.symmetric(
          vertical: height(context) * 0.02,
          horizontal: width(context) * 0.1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: width(context) * 0.045, // Responsive font size
          color: Colors.white,
        ),
      ),
    );
  }
}
