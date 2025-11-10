// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:foody_licious_admin_app/core/error/failures.dart';
// import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
// import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:http/http.dart' as http;
// import '../../../fixtures/constant_objects.dart';
// import '../../../fixtures/fixture_reader.dart';
// import '../../../helpers/test_loadenv.dart';

// class MockHttpClient extends Mock implements http.Client {}

// class FakeBaseRequest extends Fake implements http.BaseRequest {}

// void main() {
//   late MenuItemsRemoteDataSourceImpl dataSource;
//   late MockHttpClient mockHttpClient;

//   setUpAll(() {
//     registerFallbackValue(Uri.parse('https://example.com'));
//     registerFallbackValue(FakeBaseRequest());
//   });

//   setUp(() async {
//     await loadTestDotEnv();
//     mockHttpClient = MockHttpClient();
//     dataSource = MenuItemsRemoteDataSourceImpl(client: mockHttpClient);
//   });

//   test('use BASE_URL from env', () {
//     expect(kBaseUrlTest, contains('http'));
//   });

//   group('addItemInMenu', () {
//     var expectedUrl = '$kBaseUrlTest/api/restaurants/menuItems/addNewItem';
//     final fakeResponse = fixture('menuItem/menu_item_response_model.json');

//     test('should perform a POST request to correct URL with params', () async {
//       // Arrange
//       when(
//         () => mockHttpClient.post(
//           any(),
//           headers: any(named: 'headers'),
//           body: any(named: 'body'),
//           encoding: any(named: 'encoding'),
//         ),
//       ).thenAnswer((_) async => http.Response(fakeResponse, 201));

//       // Act
//       final result = await dataSource.addItemInMenu(tAddMenuItemParams);

//       // Assert
//       verify(
//         () => mockHttpClient.post(
//           any(),
//           headers: {'Content-Type': 'application/json'},
//           body: jsonEncode(tAddMenuItemParams.toJson()),
//           encoding: null,
//         ),
//       ).called(1);
//       expect(result, isA<Unit>());
//     });

//     test('should throw RestaurantNotExistsFailure on 404', () async {
//       // Arrange
//       when(
//         () => mockHttpClient.post(
//           any(),
//           headers: any(named: 'headers'),
//           body: any(named: 'body'),
//           encoding: any(named: 'encoding'),
//         ),
//       ).thenAnswer((_) async => http.Response('Error', 404));

//       // Act & Assert
//       expect(
//         () async => await dataSource.addItemInMenu(tAddMenuItemParams),
//         throwsA(isA<RestaurantNotExistsFailure>()),
//       );
//     });

//     test('should throw ItemAlreadyExistsFailure on 409', () async {
//       // Arrange
//       when(
//         () => mockHttpClient.post(
//           any(),
//           headers: any(named: 'headers'),
//           body: any(named: 'body'),
//           encoding: any(named: 'encoding'),
//         ),
//       ).thenAnswer((_) async => http.Response('Error', 409));

//       // Act & Assert
//       expect(
//         () async => await dataSource.addItemInMenu(tAddMenuItemParams),
//         throwsA(isA<ItemAlreadyExistsFailure>()),
//       );
//     });

//     test('should throw ServerFailure on non-200 other than 404/409', () async {
//       // Arrange
//       when(
//         () => mockHttpClient.post(
//           any(),
//           headers: any(named: 'headers'),
//           body: any(named: 'body'),
//           encoding: any(named: 'encoding'),
//         ),
//       ).thenAnswer((_) async => http.Response('Error', 500));

//       // Act & Assert
//       expect(
//         () async => await dataSource.addItemInMenu(tAddMenuItemParams),
//         throwsA(isA<ServerFailure>()),
//       );
//     });
//   });
// }
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

class FakeMultipartRequest extends Fake implements http.MultipartRequest {}

class FakeStreamedResponse extends Fake implements http.StreamedResponse {}

void main() {
  late MenuItemsRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(FakeUri());
    registerFallbackValue(FakeMultipartRequest());
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
    late String testImagePath;

    // test('should perform a POST request without images', () async {
    //   // Arrange
    //   final paramsWithoutImages = AddMenuItemParams(
    //     restaurantId: tAddMenuItemParams.restaurantId,
    //     name: tAddMenuItemParams.name,
    //     description: tAddMenuItemParams.description,
    //     price: tAddMenuItemParams.price,
    //     availableQuantity: tAddMenuItemParams.availableQuantity,
    //     ingredients: tAddMenuItemParams.ingredients,
    //     imageFilePaths: [
    //       testImagePath,
    //       testImagePath,
    //     ], // Empty list - no images
    //   );

    //   when(
    //     () => mockHttpClient.post(
    //       any(),
    //       headers: any(named: 'headers'),
    //       body: any(named: 'body'),
    //       encoding: any(named: 'encoding'),
    //     ),
    //   ).thenAnswer((_) async => http.Response(fakeResponse, 201));

    //   // Act
    //   final result = await dataSource.addItemInMenu(paramsWithoutImages);

    //   // Assert
    //   verify(
    //     () => mockHttpClient.post(
    //       any(),
    //       headers: {'Content-Type': 'application/json'},
    //       body: any(named: 'body'),
    //       encoding: null,
    //     ),
    //   ).called(1);
    //   expect(result, isA<Unit>());
    // });

    setUp(() async {
      final tempDir = Directory.systemTemp;
      final testFile = File(
        '${tempDir.path}/test_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await testFile.writeAsBytes([
        255,
        216,
        255,
        224,
      ]); // Fake JPEG header bytes
      testImagePath = testFile.path;
    });

    

    test('should throw RestaurantNotExistsFailure on 404', () async {
      // Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ItemAlreadyExistsFailure on 409', () async {
      // Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 409));

      // Act & Assert
      expect(
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<ItemAlreadyExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 404/409', () async {
      // Arrange
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(
        () async => await dataSource.addItemInMenu(tAddMenuItemParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  // group('deleteItemInMenu', () {
  //   test('should perform DELETE request and return Unit on success', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.delete(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Success', 200));

  //     // Act
  //     final result = await dataSource.deleteItemInMenu(tDeleteMenuItemParams);

  //     // Assert
  //     verify(
  //       () => mockHttpClient.delete(
  //         any(),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({'id': tDeleteMenuItemParams.itemId}),
  //         encoding: null,
  //       ),
  //     ).called(1);
  //     expect(result, isA<Unit>());
  //   });

  //   test('should throw CredentialFailure on 400', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.delete(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 400));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.deleteItemInMenu(tDeleteMenuItemParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ItemNotExistsFailure on 404', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.delete(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 404));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.deleteItemInMenu(tDeleteMenuItemParams),
  //       throwsA(isA<ItemNotExistsFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on other errors', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.delete(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 500));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.deleteItemInMenu(tDeleteMenuItemParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });

  // group('getAllMenuItem', () {
  //   final fakeResponse = fixture('menuItem/menu_items_response_model.json');

  //   test('should perform GET request and return MenuItemsResponseModel', () async {
  //     // Arrange
  //     when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response(fakeResponse, 200));

  //     // Act
  //     final result = await dataSource.getAllMenuItem(tGetAllMenuItemsParams);

  //     // Assert
  //     verify(() => mockHttpClient.get(any())).called(1);
  //     expect(result, isA<MenuItemsResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400', () async {
  //     // Arrange
  //     when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response('Error', 400));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ItemNotExistsFailure on 404', () async {
  //     // Arrange
  //     when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response('Error', 404));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
  //       throwsA(isA<ItemNotExistsFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on other errors', () async {
  //     // Arrange
  //     when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
  //         .thenAnswer((_) async => http.Response('Error', 500));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.getAllMenuItem(tGetAllMenuItemsParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });

  // group('increaseItemQuantity', () {
  //   final fakeResponse = fixture('menuItem/menu_item_response_model.json');
  //   const testItemId = 'item123';

  //   test('should perform PUT request and return MenuItemResponseModel', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response(fakeResponse, 200));

  //     // Act
  //     final result = await dataSource.increaseItemQuantity(testItemId);

  //     // Assert
  //     verify(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({'id': testItemId}),
  //         encoding: null,
  //       ),
  //     ).called(1);
  //     expect(result, isA<MenuItemResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 400));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.increaseItemQuantity(testItemId),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on other errors', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 500));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.increaseItemQuantity(testItemId),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });

  // group('decreaseItemQuantity', () {
  //   final fakeResponse = fixture('menuItem/menu_item_response_model.json');
  //   const testItemId = 'item123';

  //   test('should perform PUT request and return MenuItemResponseModel', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response(fakeResponse, 200));

  //     // Act
  //     final result = await dataSource.decreaseItemQuantity(testItemId);

  //     // Assert
  //     verify(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({'id': testItemId}),
  //         encoding: null,
  //       ),
  //     ).called(1);
  //     expect(result, isA<MenuItemResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 400));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.decreaseItemQuantity(testItemId),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on other errors', () async {
  //     // Arrange
  //     when(
  //       () => mockHttpClient.put(
  //         any(),
  //         headers: any(named: 'headers'),
  //         body: any(named: 'body'),
  //         encoding: any(named: 'encoding'),
  //       ),
  //     ).thenAnswer((_) async => http.Response('Error', 500));

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.decreaseItemQuantity(testItemId),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });

  // group('updateItemInMenu', () {
  //   final fakeResponse = fixture('menuItem/menu_item_response_model.json');

  //   test('should perform multipart PUT request and return MenuItemResponseModel', () async {
  //     // Arrange
  //     final mockStreamedResponse = MockStreamedResponse();
  //     when(() => mockStreamedResponse.statusCode).thenReturn(200);
  //     when(() => mockStreamedResponse.stream).thenAnswer(
  //       (_) => Stream.value(utf8.encode(fakeResponse)),
  //     );

  //     when(() => mockHttpClient.send(any())).thenAnswer(
  //       (_) async => mockStreamedResponse,
  //     );

  //     // Act
  //     final result = await dataSource.updateItemInMenu(tUpdateMenuItemParams);

  //     // Assert
  //     verify(() => mockHttpClient.send(any())).called(1);
  //     expect(result, isA<MenuItemResponseModel>());
  //   });

  //   test('should throw RestaurantNotExistsFailure on 404', () async {
  //     // Arrange
  //     final mockStreamedResponse = MockStreamedResponse();
  //     when(() => mockStreamedResponse.statusCode).thenReturn(404);
  //     when(() => mockStreamedResponse.stream).thenAnswer(
  //       (_) => Stream.value(utf8.encode('Error')),
  //     );

  //     when(() => mockHttpClient.send(any())).thenAnswer(
  //       (_) async => mockStreamedResponse,
  //     );

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.updateItemInMenu(tUpdateMenuItemParams),
  //       throwsA(isA<RestaurantNotExistsFailure>()),
  //     );
  //   });

  //   test('should throw ItemAlreadyExistsFailure on 409', () async {
  //     // Arrange
  //     final mockStreamedResponse = MockStreamedResponse();
  //     when(() => mockStreamedResponse.statusCode).thenReturn(409);
  //     when(() => mockStreamedResponse.stream).thenAnswer(
  //       (_) => Stream.value(utf8.encode('Error')),
  //     );

  //     when(() => mockHttpClient.send(any())).thenAnswer(
  //       (_) async => mockStreamedResponse,
  //     );

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.updateItemInMenu(tUpdateMenuItemParams),
  //       throwsA(isA<ItemAlreadyExistsFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on other errors', () async {
  //     // Arrange
  //     final mockStreamedResponse = MockStreamedResponse();
  //     when(() => mockStreamedResponse.statusCode).thenReturn(500);
  //     when(() => mockStreamedResponse.stream).thenAnswer(
  //       (_) => Stream.value(utf8.encode('Error')),
  //     );

  //     when(() => mockHttpClient.send(any())).thenAnswer(
  //       (_) async => mockStreamedResponse,
  //     );

  //     // Act & Assert
  //     expect(
  //       () async => await dataSource.updateItemInMenu(tUpdateMenuItemParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });
}

class MockStreamedResponse extends Mock implements http.StreamedResponse {}
