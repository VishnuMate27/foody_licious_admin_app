import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';

class DeleteRestaurantUseCase extends UseCase<Unit, void> {
  final RestaurantRepository repository;
  DeleteRestaurantUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(void params) async {
    return await repository.deleteRestaurant();
  }
}
