import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';

class RemoveRestaurantProfilePictureUseCase
    extends UseCase<Restaurant, NoParams> {
  final RestaurantRepository repository;
  RemoveRestaurantProfilePictureUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(void params) async {
    return await repository.removeRestaurantProfilePicture();
  }
}