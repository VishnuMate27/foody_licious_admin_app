import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import '../../../fixtures/constant_objects.dart';

void main() {
  test(
    'RestaurantModel should be a subclass of Restaurant entity',
    () async {
      /// Assert
      expect(tRestaurantModel, isA<Restaurant>());
    },
  );
}