import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final FontWeight hintFontWeight;
  final double hintFontSize;
  final Color hintTextColor;
  final bool isObscure;
  final TextEditingController formcontroller;
  const CustomTextFormField(
      {Key key,
      this.hintText,
      this.hintFontSize,
      this.hintFontWeight,
      this.hintTextColor,
      this.isObscure,
      this.formcontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: formcontroller,
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
        hintText: hintText != null ? hintText : "",
        focusColor: Colors.black,
        hintStyle: TextStyle(
          fontSize: hintFontSize,
          fontWeight: hintFontWeight,
          color: hintTextColor != null ? hintTextColor : Colors.black,
        ),
      ),
    );
  }
}
