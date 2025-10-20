
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/exceptions.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fixtures/constant_objects.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late RestaurantLocalDataSourceImpl restaurantLocalDataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    restaurantLocalDataSource = RestaurantLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getRestaurant', () {
    test('should return a RestaurantModel when it is available', () async {
      /// Arrange
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => true);
      when(() => mockSharedPreferences.setBool('first_run', false))
          .thenAnswer((_) => Future<bool>.value(true));
      when(() => mockSharedPreferences.getString(cachedRestaurant))
          .thenReturn(restaurantModelToJson(tRestaurantModel));

      /// Act
      final result = await restaurantLocalDataSource.getRestaurant();

      /// Assert
      expect(result, isA<RestaurantModel>());
      verify(() => mockSharedPreferences.getString(cachedRestaurant)).called(1);
    });

    test('should throw CacheException when RestaurantModel is not available',
        () async {
      /// Arrange
      when(() => mockSharedPreferences.getBool('first_run'))
          .thenAnswer((_) => false);
      when(() => mockSharedPreferences.getString(cachedRestaurant)).thenReturn(null);

      /// Act and Assert
      expect(
          () => restaurantLocalDataSource.getRestaurant(), throwsA(isA<CacheException>()));
      verify(() => mockSharedPreferences.getString(cachedRestaurant)).called(1);
    });
  });

  group('saveRestaurant', () {
    test('should save the restaurant', () async {
      /// Arrange
      when(() => mockSharedPreferences.setString(
              cachedRestaurant, restaurantModelToJson(tRestaurantModel)))
          .thenAnswer((invocation) => Future<bool>.value(true));

      /// Act
      await restaurantLocalDataSource.saveRestaurant(tRestaurantModel);

      /// Assert
      verify(() => mockSharedPreferences.setString(
          cachedRestaurant, restaurantModelToJson(tRestaurantModel))).called(1);
    });
  });

  group('clearCache', () {
    test('should clear the cache', () async {
      /// Arrange
      when(() => mockSharedPreferences.remove(cachedRestaurant))
          .thenAnswer((_) => Future<bool>.value(true));

      /// Act
      await restaurantLocalDataSource.clearCache();

      /// Assert
      verify(() => mockSharedPreferences.remove(cachedRestaurant)).called(1);
    });
  });
}