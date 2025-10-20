import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious_admin_app/data/services/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  late RestaurantRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockLocationService mockLocationService;
  // Create a fake position
  final fakePosition = Position(
    latitude: 70.0,
    longitude: 75.0,
    timestamp: DateTime.now(),
    accuracy: 5.0,
    altitude: 10.0,
    altitudeAccuracy: 5.0,
    heading: 90.0,
    headingAccuracy: 1.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    isMocked: true,
  );

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    mockLocationService = MockLocationService();
    dataSource = RestaurantRemoteDataSourceImpl(
      client: mockHttpClient,
      locationService: mockLocationService,
    );
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http')); // ✅ now available everywhere
  });

  group('updateRestaurant', () {
    var expectedUrl = '$kBaseUrlTest/api/restaurants/profile';
    final fakeResponse = fixture('restaurant/restaurant_response_model.json');

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
      final result = await dataSource.updateRestaurant(tUpdateRestaurantParams);

      /// Assert
      verify(
        () => mockHttpClient.put(
          any(),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(tUpdateRestaurantParams.toJson()),
          encoding: null,
        ),
      );
      expect(result, isA<RestaurantResponseModel>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
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
        () async => await dataSource.updateRestaurant(tUpdateRestaurantParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
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
        () async => await dataSource.updateRestaurant(tUpdateRestaurantParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  // group('uploadRestaurantProfilePicture', () {
  //   var expectedUrl = '$kBaseUrlTest/api/restaurants/upload_restaurant_profile_picture';
  //   final fakeResponse = fixture('restaurant/restaurant_response_model.json');

  //   test('should perform a multipart POST request to correct URL with fields and file', () async {
  //     /// Arrange
  //     final streamedResponse = http.StreamedResponse(
  //       Stream.value(utf8.encode(fakeResponse)),
  //       200,
  //     );

  //     when(() => mockHttpClient.send(any()))
  //         .thenAnswer((_) async => streamedResponse);

  //     /// Act
  //     final result = await dataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams);

  //     // Assert
  //     verify(
  //       () => mockHttpClient.send(
  //         any(
  //           that: isA<http.MultipartRequest>()
  //               .having((req) => req.url, 'url', expectedUrl)
  //               .having((req) => req.fields['folder'], 'folder', 'restaurants')
  //               .having(
  //                   (req) => req.fields['sub_folder'], 'sub_folder', 'profile_picture')
  //               .having(
  //                   (req) => req.fields['restaurant_id'], 'restaurant_id', '12345'),
  //         ),
  //       ),
  //     ).called(1);
  //     expect(result, isA<RestaurantResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400 or 401', () async {
  //     /// Arrange
  //     final streamedResponse = http.StreamedResponse(
  //       Stream.value(utf8.encode('Error')),
  //       400,
  //     );

  //     when(() => mockHttpClient.send(any()))
  //         .thenAnswer((_) async => streamedResponse);

  //     /// Act & Assert
  //     expect(
  //       () async => await dataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on non-200 other than 400/401', () async {
  //     /// Arrange
  //     final streamedResponse = http.StreamedResponse(
  //       Stream.value(utf8.encode('Error')),
  //       500,
  //     );

  //     when(() => mockHttpClient.send(any()))
  //         .thenAnswer((_) async => streamedResponse);

  //     /// Act & Assert
  //     expect(
  //       () async => await dataSource.uploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });


  group('updateRestaurantLocation', () {
    String restaurantId = "RcrNpesIeKSd3afH67ndyDLUaMJ3";
    var expectedUrl = '$kBaseUrlTest/api/restaurants/profile';
    final fakeResponse = fixture('restaurant/restaurant_response_model.json');

    setUp(() {
      // Stub the location service
      when(
        () => mockLocationService.determinePosition(),
      ).thenAnswer((_) async => fakePosition);
    });

    test('should perform a PUT request to correct URL with params', () async {
      final fakeParams = {
        "id": restaurantId,
        "address": {
          "coordinates": {
            "type": "Point",
            "coordinates": [70.0, 75.0], // must match fakePosition
          },
        },
      };

      when(
        () => mockHttpClient.put(
          Uri.parse('$kBaseUrl/api/restaurants/profile'),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource.updateRestaurantLocation(restaurantId);

      verify(
        () => mockHttpClient.put(
          Uri.parse('$kBaseUrl/api/restaurants/profile'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(fakeParams),
          encoding: null,
        ),
      );
      expect(result, isA<RestaurantResponseModel>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () async => await dataSource.updateRestaurantLocation(restaurantId),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      when(
        () => mockHttpClient.put(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () async => await dataSource.updateRestaurantLocation(restaurantId),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('deleteRestaurant', () {
    String restaurantId = "RcrNpesIeKSd3afH67ndyDLUaMJ3";
    var expectedUrl = '$kBaseUrlTest/api/restaurants/delete_restaurant';

    test('should perform a POST request to correct URL with params', () async {
      final fakeParams = {"id": restaurantId};

      when(
        () => mockHttpClient.post(
          Uri.parse('$kBaseUrl/api/restaurants/delete_restaurant'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(fakeParams),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response("Response", 200));

      final result = await dataSource.deleteRestaurant(restaurantId);

      verify(
        () => mockHttpClient.post(
          Uri.parse('$kBaseUrl/api/restaurants/delete_restaurant'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(fakeParams),
          encoding: null,
        ),
      );
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () async => await dataSource.deleteRestaurant(restaurantId),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw RestaurantNotExistsFailure on 404', () async {
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 404));

      expect(
        () async => await dataSource.deleteRestaurant(restaurantId),
        throwsA(isA<RestaurantNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      when(
        () => mockHttpClient.post(
          any(),
          headers: any(named: 'headers'),
          body: any(named: 'body'),
          encoding: any(named: 'encoding'),
        ),
      ).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () async => await dataSource.deleteRestaurant(restaurantId),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
