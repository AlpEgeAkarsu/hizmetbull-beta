import 'package:flutter/material.dart';

Widget basicSpacer() {
  return Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Divider(
        color: Colors.black38,
        thickness: 1,
      ),
    ],
  );
}
