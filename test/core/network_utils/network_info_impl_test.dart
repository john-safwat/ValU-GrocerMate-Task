import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:valu_task/core/network_utils/network_info_impl.dart';

import 'network_info_impl_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('isConnected', () {
    test('should return true when the device is connected to mobile', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.mobile]);

      final result = await networkInfo.isConnected;

      expect(result, true);
      verify(mockConnectivity.checkConnectivity());
      verifyNoMoreInteractions(mockConnectivity);
    });

    test('should return true when the device is connected to wifi', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);

      final result = await networkInfo.isConnected;

      expect(result, true);
      verify(mockConnectivity.checkConnectivity());
      verifyNoMoreInteractions(mockConnectivity);
    });

    test('should return false when the device is not connected', () async {
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.none]);

      final result = await networkInfo.isConnected;

      expect(result, false);
      verify(mockConnectivity.checkConnectivity());
      verifyNoMoreInteractions(mockConnectivity);
    });
  });

  group('onConnectivityChanged', () {
    test('should forward the stream from the Connectivity package', () {
      final expectedStream = Stream.value([ConnectivityResult.wifi]);
      when(
        mockConnectivity.onConnectivityChanged,
      ).thenAnswer((_) => expectedStream);

      final resultStream = networkInfo.onConnectivityChanged;

      expect(resultStream, same(expectedStream));
      verify(mockConnectivity.onConnectivityChanged);
      verifyNoMoreInteractions(mockConnectivity);
    });
  });
}
