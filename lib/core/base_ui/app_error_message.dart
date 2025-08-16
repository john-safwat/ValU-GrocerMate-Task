import 'package:flutter/material.dart';

class AppErrorMessage {
  final String message;

  const AppErrorMessage(this.message);

  @override
  String toString() => message;

  Widget toText() => Text(message);
}
