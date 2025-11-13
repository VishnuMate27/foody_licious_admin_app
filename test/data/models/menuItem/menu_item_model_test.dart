import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';

import '../../../fixtures/constant_objects.dart';

void main() {
  test('MenuItemModel should be a subclass of MenuItem entity',() {
      /// Assert
      expect(tMenuItemModel, isA<MenuItem>());
  });
}
