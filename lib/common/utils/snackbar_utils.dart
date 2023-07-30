import 'package:flutter/material.dart';

class SnackbarUtils {
  static showMessage(
      {required BuildContext context,
      required String message,
      Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: backgroundColor, content: Text(message)));
  }
}
