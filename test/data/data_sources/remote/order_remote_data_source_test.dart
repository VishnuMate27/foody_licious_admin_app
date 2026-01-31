import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/order_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/models/order/order_response_model.dart';
import 'package:foody_licious_admin_app/data/models/order/orders_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockStreamedResponse extends Mock implements http.StreamedResponse {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

void main() {
  late OrderRemoteDataSourceImpl dataSource;
  late MockStreamedResponse mockStreamedResponse;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
    registerFallbackValue(FakeBaseRequest());
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    mockStreamedResponse = MockStreamedResponse();
    dataSource = OrderRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http'));
  });

  group('getAllOrders', () {
    String urlEndpoint = '';
    if (tGetAllOrdersParams.statuses != null) {
      urlEndpoint = tGetAllOrdersParams.statuses!.join("&status=");
    }
    var expectedUrl =
        '$kBaseUrlTest/api/restaurants/order/getAllOrders?restaurant_id=${tGetAllOrdersParams.restaurantId}&page=${tGetAllOrdersParams.page}&page_size=${tGetAllOrdersParams.limit}&status=$urlEndpoint';
    final fakeResponse = fixture('order/orders_response_model.json');

    test('should perform a GET request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.getAllOrders(tGetAllOrdersParams);

      /// Assert
      verify(
        () => mockHttpClient.get(
          any(),
          headers: any(named: 'headers'),
        ),
      ).called(1);
      expect(result, isA<OrdersResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllOrders(tGetAllOrdersParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw RestaurantNotExistsFailure on 404', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 404));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllOrders(tGetAllOrdersParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on 500 and others', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllOrders(tGetAllOrdersParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('updateOrderStatus', () {
    final requestBody = json.encode({
      "orderId": tUpdateOrderStatusParams.orderId,
      "restaurantId": tUpdateOrderStatusParams.restaurantId,
      "status": tUpdateOrderStatusParams.status,
    });
    var expectedUrl = '$kBaseUrlTest/api/restaurants/order/updateOrderStatus';
    final fakeResponse = fixture('order/order_response_model.json');

    test('should perform a POST request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.updateOrderStatus(
        tUpdateOrderStatusParams,
      );

      /// Assert
      verify(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).called(1);
      expect(result, isA<OrderResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.updateOrderStatus(tUpdateOrderStatusParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw UnauthorizedRequestFailure on 401', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 401));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.updateOrderStatus(tUpdateOrderStatusParams),
        throwsA(isA<UnauthorizedRequestFailure>()),
      );
    });

    test('should throw OrderNotExistsFailure on 404', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 404));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.updateOrderStatus(tUpdateOrderStatusParams),
        throwsA(isA<OrderNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on 500 and others', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async =>
            await dataSource.updateOrderStatus(tUpdateOrderStatusParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
