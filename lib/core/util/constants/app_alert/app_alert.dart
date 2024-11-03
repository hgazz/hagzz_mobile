import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

class AppAlert {
  static success({required String message, required context}) =>
      toastification.show(
        context: context,
        style: ToastificationStyle.minimal,
        type: ToastificationType.success,
        alignment: Alignment.topCenter,
        title: Text(message),
        autoCloseDuration: const Duration(seconds: 2),
      );

  static error(
          {required String message,
          Toast? toastLength,
          required context,
          int? messageDuration,
          bool hasDuration = true}) =>
      toastification.show(
        context: context,
        style: ToastificationStyle.minimal,
        type: ToastificationType.error,
        alignment: Alignment.topCenter,
        showProgressBar: hasDuration,
        title: Text(message),
        autoCloseDuration: hasDuration != false
            ? Duration(seconds: messageDuration ?? 2)
            : null,
      );
}
