import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:valu_task/core/network_utils/results.dart';
import 'package:valu_task/core/network_utils/safe_api_call.dart';
import 'package:valu_task/core/network_utils/status.dart';

void main() {
  group('safeApiCall', () {
    test('should return Results.success when apiCall succeeds', () async {
      const successData = 'Success';
      final result = await safeApiCall(
        () async => const Results.success(data: successData),
      );
      expect(result.status, Status.success);
      expect(result.data, successData);
      expect(result.error, isNull);
    });

    test('should return Results.error on SocketException', () async {
      final result = await safeApiCall<String>(
        () async => throw const SocketException(''),
      );
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });

    test('should return Results.error on TimeoutException', () async {
      final result = await safeApiCall<String>(
        () async => throw TimeoutException(''),
      );
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });

    test('should return Results.error on HttpException', () async {
      final result = await safeApiCall<String>(
        () async => throw const HttpException(''),
      );
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });

    test('should return Results.error on FormatException', () async {
      final result = await safeApiCall<String>(
        () async => throw const FormatException(''),
      );
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });

    test('should return Results.error on IOException', () async {
      final result = await safeApiCall<String>(
        () async => throw const WebSocketException(''),
      );
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });

    test('should return Results.error on any other exception', () async {
      final result = await safeApiCall<String>(() async => throw Exception(''));
      expect(result.status, Status.error);
      expect(result.data, isNull);
    });
  });
}
