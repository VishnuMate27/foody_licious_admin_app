import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';


class CheckRestaurantUseCase extends UseCase<Restaurant, void> {
  final RestaurantRepository repository;
  CheckRestaurantUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(void params) async {
    return await repository.checkRestaurant();
  }
}
