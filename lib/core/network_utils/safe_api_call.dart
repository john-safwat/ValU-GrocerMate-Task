import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:valu_task/core/network_utils/results.dart';

Future<Results<T>> safeApiCall<T>(Future<Results<T>> Function() apiCall) async {
  try {
    Results<T> response = await apiCall();
    debugPrint('✅ Success: $response');
    return response;
  } on SocketException catch (e, stackTrace) {
    debugPrint('❌ SocketException: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  } on TimeoutException catch (e, stackTrace) {
    debugPrint('❌ TimeoutException: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  } on HttpException catch (e, stackTrace) {
    debugPrint('❌ HttpException: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  } on FormatException catch (e, stackTrace) {
    debugPrint('❌ FormatException: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  } on IOException catch (e, stackTrace) {
    debugPrint('❌ IOException: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  } catch (e, stackTrace) {
    debugPrint('❌ Unknown Exception: $e\nStackTrace: $stackTrace');
    return Results<T>.error();
  }
}
