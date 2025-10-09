import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/repositories/auth_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final RestaurantLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Restaurant>> signInWithEmail(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signInWithEmail(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneNumberForLogin(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.verifyPhoneNumberForLogin(
        params,
      );
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signInWithPhone(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signInWithPhone(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signInWithGoogle() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signInWithGoogle();
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signInWithFacebook() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signInWithFacebook();
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendPasswordResetEmail(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse =
          await remoteDataSource.sendPasswordResetEmail(params);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
  
  @override
  Future<Either<Failure, Restaurant>> signUpWithEmail(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithEmail(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> sendVerificationEmail() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.sendVerificationEmail();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> waitForEmailVerification() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.waitForEmailVerification();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneNumberForRegistration(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource
          .verifyPhoneNumberForRegistration(params);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signUpWithPhone(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithPhone(params);
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signUpWithGoogle() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithGoogle();
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Restaurant>> signUpWithFacebook() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithFacebook();
      await localDataSource.saveRestaurant(remoteResponse.restaurant);
      return Right(remoteResponse.restaurant);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(unit);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

}
