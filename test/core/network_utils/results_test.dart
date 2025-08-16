import 'package:flutter_test/flutter_test.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';
import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/status.dart';

void main() {
  group(
    'Testing Results class for all 4 cases (success , error , initial , loading)',
    () {
      test(
        'Results.initial should have initial status and null data/message',
        () {
          const results = Results<String>.initial();

          expect(results.status, Status.initial);
          expect(results.data, isNull);
          expect(results.error, isNull);
        },
      );

      test(
        'Results.success should have success status, data, and null message',
        () {
          const data = 'Success Data';
          const results = Results<String>.success(data: data);

          expect(results.status, Status.success);
          expect(results.data, data);
          expect(results.error, isNull);
        },
      );

      test(
        'Results.success should work with different data types like int',
        () {
          const data = 123;
          const results = Results<int>.success(data: data);

          expect(results.status, Status.success);
          expect(results.data, data);
          expect(results.error, isNull);
        },
      );

      test('Results.error should have error status and an error message', () {
        const errorMessage = AppErrorMessage("UnKnownError");
        final error = UnKnownError(errorMessage);
        final results = Results<String>.error(error: error);

        expect(results.status, Status.error);
        expect(results.data, isNull);
        expect(results.error, error);
      });

      test('Results.error can optionally have data along with a message', () {
        const errorMessage = AppErrorMessage("UnKnownError");
        final error = UnKnownError(errorMessage);
        const data = 'Data';
        final results = Results<String>.error(data: data, error: error);

        expect(results.status, Status.error);
        expect(results.data, data);
        expect(results.error, error);
      });

      test('Results.loading should have loading status and null message', () {
        const results = Results<String>.loading();

        expect(results.status, Status.loading);
        expect(results.data, isNull);
        expect(results.error, isNull);
      });

      test('Results.loading can optionally have previous data', () {
        const data = 'Data';
        const results = Results<String>.loading(data: data);

        expect(results.status, Status.loading);
        expect(results.data, data);
        expect(results.error, isNull);
      });
    },
  );
}
