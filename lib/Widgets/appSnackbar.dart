import 'package:flutter/material.dart';

Widget appSnackBar(String message) {
  return SnackBar(content: Text(message), duration: Duration(milliseconds: 2000),);
}
