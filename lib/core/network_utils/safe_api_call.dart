import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';
import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/results.dart';

Future<Results<T>> safeApiCall<T>(Future<Results<T>> Function() apiCall) async {
  try {
    Results<T> response = await apiCall();
    debugPrint('✅ Success: $response');
    return response;
  } on SocketException catch (e, stackTrace) {
    debugPrint('❌ SocketException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: NoInternetError(
        const AppErrorMessage(
          'No internet connection. Please check your network.',
        ),
      ),
    );
  } on TimeoutException catch (e, stackTrace) {
    debugPrint('❌ TimeoutException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: TimeoutError(
        const AppErrorMessage('Request timed out. Please try again.'),
      ),
    );
  } on HttpException catch (e, stackTrace) {
    debugPrint('❌ HttpException: $e\nStackTrace: $stackTrace');
    final message = e.message.toLowerCase();
    if (message.contains('401')) {
      return Results<T>.error(
        error: UnauthorizedError(
          const AppErrorMessage('Unauthorized access. Please log in.'),
        ),
      );
    } else if (message.contains('404')) {
      return Results<T>.error(
        error: NotFoundError(
          const AppErrorMessage('Requested resource not found.'),
        ),
      );
    } else if (message.contains('5')) {
      return Results<T>.error(
        error: ServerError(
          const AppErrorMessage('Server error. Please try again later.'),
          statusCode: int.tryParse(
            message
                .split(' ')
                .firstWhere((s) => s.startsWith('5'), orElse: () => ''),
          ),
        ),
      );
    } else if (message.contains('4')) {
      return Results<T>.error(
        error: ClientError(
          const AppErrorMessage('Client error. Please check your request.'),
          statusCode: int.tryParse(
            message
                .split(' ')
                .firstWhere((s) => s.startsWith('4'), orElse: () => ''),
          ),
        ),
      );
    }
    return Results<T>.error(
      error: NetworkError(const AppErrorMessage('Network error occurred.')),
    );
  } on FormatException catch (e, stackTrace) {
    debugPrint('❌ FormatException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: ParsingError(
        const AppErrorMessage('Failed to parse response data.'),
      ),
    );
  } on IOException catch (e, stackTrace) {
    debugPrint('❌ IOException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: NetworkError(
        const AppErrorMessage('Input/output error occurred.'),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('❌ Unknown Exception: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: UnKnownError(
        const AppErrorMessage('An unexpected error occurred.'),
      ),
    );
  }
}
