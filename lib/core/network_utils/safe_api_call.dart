import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valu_task/core/base_ui/app_error_message.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/network_utils/app_errors.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';

Future<Results<T>> safeApiCall<T>(Future<Results<T>> Function() apiCall) async {
  try {
    Results<T> response = await apiCall();
    debugPrint('✅ Success: $response');
    return response;
  } on SocketException catch (e, stackTrace) {
    debugPrint('❌ SocketException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: NoInternetError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.noInternetError,
        ),
      ),
    );
  } on TimeoutException catch (e, stackTrace) {
    debugPrint('❌ TimeoutException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: TimeoutError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.timeoutError,
        ),
      ),
    );
  } on HttpException catch (e, stackTrace) {
    debugPrint('❌ HttpException: $e\nStackTrace: $stackTrace');
    final message = e.message.toLowerCase();
    if (message.contains('401')) {
      return Results<T>.error(
        error: UnauthorizedError(
          AppErrorMessage(
            getIt<AppConfigProvider>().localizations.unauthorizedError,
          ),
        ),
      );
    } else if (message.contains('404')) {
      return Results<T>.error(
        error: NotFoundError(
          AppErrorMessage(
            getIt<AppConfigProvider>().localizations.notFoundError,
          ),
        ),
      );
    } else if (message.contains('5')) {
      return Results<T>.error(
        error: ServerError(
          AppErrorMessage(
            getIt<AppConfigProvider>().localizations.serverError,
          ),
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
          AppErrorMessage(
            getIt<AppConfigProvider>().localizations.clientError,
          ),
          statusCode: int.tryParse(
            message
                .split(' ')
                .firstWhere((s) => s.startsWith('4'), orElse: () => ''),
          ),
        ),
      );
    }
    return Results<T>.error(
      error: NetworkError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.networkError,
        ),
      ),
    );
  } on FormatException catch (e, stackTrace) {
    debugPrint('❌ FormatException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: ParsingError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.parsingError,
        ),
      ),
    );
  } on IOException catch (e, stackTrace) {
    debugPrint('❌ IOException: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: NetworkError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.ioException,
        ),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('❌ Unknown Exception: $e\nStackTrace: $stackTrace');
    return Results<T>.error(
      error: UnKnownError(
        AppErrorMessage(
          getIt<AppConfigProvider>().localizations.unknownError,
        ),
      ),
    );
  }
}