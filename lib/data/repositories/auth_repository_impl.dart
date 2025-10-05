import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

    @override
  Future<Either<Failure, Restaurant>> signUpWithEmail(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithEmail(params);
      // await localDataSource.saveUser(remoteResponse.user);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

}
