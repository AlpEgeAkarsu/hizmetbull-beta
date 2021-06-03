import 'package:flutter/material.dart';

class RegisterCustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String buttonText;
  const RegisterCustomButton({Key key, this.callback, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      style: ElevatedButton.styleFrom(primary: Colors.black),
      child: Text(
        buttonText == null ? "KAYIT OL" : buttonText,
        style: TextStyle(fontSize: 16, fontFamily: "Roboto"),
      ),
    );
  }
}
