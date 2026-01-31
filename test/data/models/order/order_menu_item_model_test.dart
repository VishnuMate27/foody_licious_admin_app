

import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';

import '../../../fixtures/constant_objects.dart';

void main(){
    test('OrderMenuItemModel should be a subclass of OrderMenuItem entity',() {
      /// Assert
      expect(tOrderMenuItemModel, isA<OrderMenuItem>());
  });
}