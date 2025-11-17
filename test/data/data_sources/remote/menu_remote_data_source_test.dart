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

class MockStreamedResponse extends Mock implements http.StreamedResponse {}

class FakeBaseRequest extends Fake implements http.BaseRequest {}

void main() {
  late MenuItemsRemoteDataSourceImpl dataSource;
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

  group('updateItemInMenu', () {
    var expectedUrl = '$kBaseUrlTest/api/restaurants/menuItems/updateItem';
    final fakeResponse = fixture('menuItem/menu_item_response_model.json');

    test(
      'should return MenuItemResponseModel on 200 with full params',
      () async {
        /// Arrange
        when(() => mockStreamedResponse.statusCode).thenReturn(200);
        when(() => mockStreamedResponse.stream).thenAnswer(
          (_) => http.ByteStream.fromBytes(utf8.encode(fakeResponse)),
        );
        when(
          () => mockHttpClient.send(any()),
        ).thenAnswer((_) async => mockStreamedResponse);

        /// Act
        final result = await dataSource.sendUpdateItemInMenuRequest(
          tUpdateMenuItemParams,
        );

        /// Assert
        final capturedRequest =
            verify(() => mockHttpClient.send(captureAny())).captured.single
                as http.MultipartRequest;
        expect(capturedRequest.method, equals('PUT'));
        expect(capturedRequest.url.path, contains('/menuItems/updateItem'));
        expect(
          capturedRequest.fields['restaurant_id'],
          equals(tUpdateMenuItemParams.restaurantId),
        );
        expect(
          capturedRequest.fields['name'],
          equals(tUpdateMenuItemParams.name),
        );
        expect(result, isA<MenuItemResponseModel>());
      },
    );

    test('should throw RestaurantNotExistsFailure on 404', () async {
      /// Arrange
      when(() => mockStreamedResponse.statusCode).thenReturn(404);
      when(
        () => mockStreamedResponse.stream,
      ).thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode(fakeResponse)));
      when(
        () => mockHttpClient.send(any()),
      ).thenAnswer((_) async => mockStreamedResponse);

      /// Act & Assert
      expect(
        () async =>
            await dataSource.sendUpdateItemInMenuRequest(tUpdateMenuItemParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ItemAlreadyExistsFailure on 409', () async {
      /// Arrange
      when(() => mockStreamedResponse.statusCode).thenReturn(409);
      when(
        () => mockStreamedResponse.stream,
      ).thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode(fakeResponse)));
      when(
        () => mockHttpClient.send(any()),
      ).thenAnswer((_) async => mockStreamedResponse);

      /// Act & Assert
      expect(
        () async =>
            await dataSource.sendUpdateItemInMenuRequest(tUpdateMenuItemParams),
        throwsA(isA<ItemAlreadyExistsFailure>()),
      );
    });

    test('should throw ServerFailure on 500', () async {
      /// Arrange
      when(() => mockStreamedResponse.statusCode).thenReturn(500);
      when(
        () => mockStreamedResponse.stream,
      ).thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode(fakeResponse)));
      when(
        () => mockHttpClient.send(any()),
      ).thenAnswer((_) async => mockStreamedResponse);

      /// Act & Assert
      expect(
        () async =>
            await dataSource.sendUpdateItemInMenuRequest(tUpdateMenuItemParams),
        throwsA(isA<ServerFailure>()),
      );
    });

    test('should use multipart PUT request', () async {
      /// Arrange
      when(() => mockStreamedResponse.statusCode).thenReturn(200);
      when(
        () => mockStreamedResponse.stream,
      ).thenAnswer((_) => http.ByteStream.fromBytes(utf8.encode(fakeResponse)));
      when(
        () => mockHttpClient.send(any()),
      ).thenAnswer((_) async => mockStreamedResponse);

      /// Act
      await dataSource.sendUpdateItemInMenuRequest(tUpdateMenuItemParams);

      /// Assert
      verify(() => mockHttpClient.send(any())).called(1);
    });
  });

  group('deleteItemInMenu', () {
    var expectedUrl = '$kBaseUrlTest/api/restaurants/menuItems/deleteItem';
    final fakeResponse = fixture('menuItem/menu_items_response_model.json');

    test(
      'should perform a DELETE request to correct URL with params',
      () async {
        /// Arrange
        when(
          () => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          ),
        ).thenAnswer((_) async => http.Response(fakeResponse, 200));

        /// Act
        final result = await dataSource.deleteItemInMenu(
          tDeleteMenuItemsParams,
        );

        /// Assert
        verify(
          () => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          ),
        ).called(1);
        expect(result, isA<Unit>());
      },
    );

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.delete(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.deleteItemInMenu(tDeleteMenuItemsParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ItemNotExistsFailure on 404', () async {
      /// Arrange
      when(
        () => mockHttpClient.delete(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 404));

      /// Act & Assert
      expect(
        () async => await dataSource.deleteItemInMenu(tDeleteMenuItemsParams),
        throwsA(isA<ItemNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      /// Arrange
      when(
        () => mockHttpClient.delete(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.deleteItemInMenu(tDeleteMenuItemsParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
  
  group('getAllMenuItem', () {
    var expectedUrl =
        '$kBaseUrlTest/api/restaurants/menuItems/allMenuItems?restaurant_id=${tGetAllMenuItemsParams.restaurantId}&page=${tGetAllMenuItemsParams.page}&page_size=${tGetAllMenuItemsParams.limit}';
    final fakeResponse = fixture('menuItem/menu_items_response_model.json');

    test('should perform a GET request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.getAllMenuItem(tGetAllMenuItemsParams);

      /// Assert
      verifyNever(
        () => mockHttpClient.get(
          Uri.parse(expectedUrl),
          headers: any(named: 'headers'),
        ),
      );
      expect(result, isA<MenuItemsResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
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
        () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      /// Arrange
      when(
        () => mockHttpClient.get(any(), headers: any(named: 'headers')),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('increaseItemQuantity', () {
    var expectedUrl =
        '$kBaseUrlTest/api/restaurants/menuItems/increaseItemQuantity';
    final fakeResponse = fixture('menuItem/menu_item_response_model.json');

    test('should perform a PUT request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.increaseItemQuantity(tRestaurantModel.id);

      /// Assert
      verify(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).called(1);
      expect(result, isA<MenuItemResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.increaseItemQuantity(tRestaurantModel.id),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.increaseItemQuantity(tRestaurantModel.id),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('decreaseItemQuantity', () {
    var expectedUrl =
        '$kBaseUrlTest/api/restaurants/menuItems/decreaseItemQuantity';
    final fakeResponse = fixture('menuItem/menu_item_response_model.json');

    test('should perform a PUT request to correct URL with params', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.decreaseItemQuantity(tRestaurantModel.id);

      /// Assert
      verify(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).called(1);
      expect(result, isA<MenuItemResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.decreaseItemQuantity(tRestaurantModel.id),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400', () async {
      /// Arrange
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.decreaseItemQuantity(tRestaurantModel.id),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
