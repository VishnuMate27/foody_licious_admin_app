

import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import '../../../fixtures/constant_objects.dart';

void main(){
    test('OrderModel should be a subclass of OrderEntity entity',() {
      /// Assert
      expect(tOrderModel1, isA<OrderEntity>());
  });
}