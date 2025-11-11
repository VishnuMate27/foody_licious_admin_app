import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

void main() {
  late MenuItemsRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
    registerFallbackValue(FakeBaseRequest());
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = MenuItemsRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http'));
  });

  group('addItemInMenu', () {
    var expectedUrl = '$kBaseUrlTest/api/restaurants/menuItems/addNewItem';
    final fakeResponse = fixture('menuItem/menu_item_response_model.json');

    test('should perform a POST request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 201));

      /// Act
      final result = await dataSource.addItemInMenu(tAddMenuItemParams);

      /// Assert
      verifyNever(
        () => mockHttpClient.post(
          any(),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tAddMenuItemParams.toJson()),
          encoding: any(named: 'encoding'),
        ),
      ).called(0);
      expect(result, equals(unit));
    });

    test('should throw RestaurantNotExistsFailure on 404', () async {
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
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ItemAlreadyExistsFailure on 409', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 409));

      /// Act & Assert
      expect(
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<ItemAlreadyExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
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
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('getAllMenuItem', () {
    var expectedUrl = '$kBaseUrlTest/api/restaurants/menuItems/allMenuItems?restaurant_id=${tGetAllMenuItemsParams.restaurantId}&page=${tGetAllMenuItemsParams.page}&page_size=${tGetAllMenuItemsParams.limit}';
    final fakeResponse = fixture('menuItem/menu_items_response_model.json');

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
      final result = await dataSource.getAllMenuItem(tGetAllMenuItemsParams);

      /// Assert
      verifyNever(
        () => mockHttpClient.post(
          any(),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tGetAllMenuItemsParams.toJson()),
          encoding: any(named: 'encoding'),
        ),
      ).called(0);
      expect(result, isA<MenuItemsResponseModel>());
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
        () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
        isA<MenuItemsResponseModel>(),
      );
    });

    test('should throw ItemNotExistsFailure on 409', () async {
      /// Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 409));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
        throwsA(isA<ItemNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
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
        () async => await dataSource..getAllMenuItem(tGetAllMenuItemsParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

}
