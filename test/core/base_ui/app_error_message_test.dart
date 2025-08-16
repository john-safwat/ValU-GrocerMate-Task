import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';

void main() {
  group('AppErrorMessage', () {
    test('constructor should correctly assign the message', () {
      const message = 'This is a test error message.';

      const errorMessage = AppErrorMessage(message);

      expect(errorMessage.message, message);
    });

    test('toString() should return the message string', () {
      const message = 'Another test message.';
      const errorMessage = AppErrorMessage(message);

      final result = errorMessage.toString();

      expect(result, message);
    });

    test('toText() should return a Text widget with the correct message', () {
      const message = 'Widget test message.';
      const errorMessage = AppErrorMessage(message);

      final textWidget = errorMessage.toText();

      expect(textWidget, isA<Text>());
      expect(errorMessage.message, message);
    });
  });
}