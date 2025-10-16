import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';

class UploadRestaurantProfilePictureUseCase
    extends UseCase<Restaurant, UploadRestaurantProfilePictureParams> {
  final RestaurantRepository repository;
  UploadRestaurantProfilePictureUseCase(this.repository);

  @override
  Future<Either<Failure, Restaurant>> call(
    UploadRestaurantProfilePictureParams params,
  ) async {
    return await repository.uploadRestaurantProfilePicture(params);
  }
}

class UploadRestaurantProfilePictureParams {
  String? restaurantId;
  final String imageFilePath;

  UploadRestaurantProfilePictureParams({
    this.restaurantId,
    required this.imageFilePath,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (data['restaurantId'] != null) data['restaurantId'] = id;
    data['photo'] = imageFilePath;
    return data;
  }
}
