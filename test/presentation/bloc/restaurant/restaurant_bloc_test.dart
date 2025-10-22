import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/check_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/delete_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/remove_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_location_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';

class MockCheckRestaurantUseCase extends Mock
    implements CheckRestaurantUseCase {}

class MockUpdateRestaurantLocationUseCase extends Mock
    implements UpdateRestaurantLocationUseCase {}

class MockUpdateRestaurantUseCase extends Mock
    implements UpdateRestaurantUseCase {}

class MockUploadRestaurantProfilePictureUseCase extends Mock
    implements UploadRestaurantProfilePictureUseCase {}

class MockRemoveRestaurantProfilePictureUseCase extends Mock
    implements RemoveRestaurantProfilePictureUseCase {}

class MockDeleteRestaurantUseCase extends Mock
    implements DeleteRestaurantUseCase {}

void main() {
  group('RestaurantBloc', () {
    late RestaurantBloc userBloc;
    late MockCheckRestaurantUseCase mockCheckRestaurantUseCase;
    late MockUpdateRestaurantLocationUseCase
    mockUpdateRestaurantLocationUseCase;
    late MockUpdateRestaurantUseCase mockUpdateRestaurantUseCase;
    late MockUploadRestaurantProfilePictureUseCase
    mockUploadRestaurantProfilePictureUseCase;
    late MockRemoveRestaurantProfilePictureUseCase
    mockRemoveRestaurantProfilePictureUseCase;
    late MockDeleteRestaurantUseCase mockDeleteRestaurantUseCase;
    setUp(() {
      mockCheckRestaurantUseCase = MockCheckRestaurantUseCase();
      mockUpdateRestaurantLocationUseCase =
          MockUpdateRestaurantLocationUseCase();
      mockUpdateRestaurantUseCase = MockUpdateRestaurantUseCase();
      mockUploadRestaurantProfilePictureUseCase =
          MockUploadRestaurantProfilePictureUseCase();
      mockRemoveRestaurantProfilePictureUseCase =
          MockRemoveRestaurantProfilePictureUseCase();
      mockDeleteRestaurantUseCase = MockDeleteRestaurantUseCase();
      registerFallbackValue(NoParams());

      userBloc = RestaurantBloc(
        mockCheckRestaurantUseCase,
        mockUpdateRestaurantLocationUseCase,
        mockUpdateRestaurantUseCase,
        mockUploadRestaurantProfilePictureUseCase,
        mockRemoveRestaurantProfilePictureUseCase,
        mockDeleteRestaurantUseCase,
      );
    });

    test('initial state should be RestaurantInitial', () {
      expect(userBloc.state, RestaurantInitial());
    });

    // CheckRestaurant
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantAuthenticated] when CheckRestaurant is added',
      build: () {
        when(
          () => mockCheckRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => const Right(tRestaurantModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(CheckRestaurant()),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantAuthenticated(tRestaurantModel),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUnauthenticated] on CheckRestaurant error',
      build: () {
        when(
          () => mockCheckRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => Left(CacheFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(CheckRestaurant()),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantUnauthenticated(CacheFailure()),
          ],
    );

    // UpdateRestaurant
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUpdateSuccess] when UpdateRestaurant is added',
      build: () {
        when(
          () => mockUpdateRestaurantUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Right(tRestaurantModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurant(tUpdateRestaurantParams)),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantUpdateSuccess(tRestaurantModel),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUpdateFailure] when UpdateRestaurant is added',
      build: () {
        when(
          () => mockUpdateRestaurantUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurant(tUpdateRestaurantParams)),
      expect:
          () => [RestaurantLoading(), RestaurantUpdateFailed(NetworkFailure())],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUpdateFailure] when UpdateRestaurant is added',
      build: () {
        when(
          () => mockUpdateRestaurantUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurant(tUpdateRestaurantParams)),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantUpdateFailed(CredentialFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUpdateFailure] when UpdateRestaurant is added',
      build: () {
        when(
          () => mockUpdateRestaurantUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurant(tUpdateRestaurantParams)),
      expect:
          () => [RestaurantLoading(), RestaurantUpdateFailed(ServerFailure())],
    );

    // UploadRestaurantProfilePicture
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUploadProfilePictureSuccess] when UploadRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockUploadRestaurantProfilePictureUseCase(tUploadRestaurantProfilePictureParams),
        ).thenAnswer((_) async => Right(tRestaurantModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(UploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams)),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantUploadProfilePictureSuccess(tRestaurantModel),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUploadProfilePictureFailed] when UploadRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockUploadRestaurantProfilePictureUseCase(tUploadRestaurantProfilePictureParams),
        ).thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams)),
      expect:
          () => [RestaurantLoading(), RestaurantUploadProfilePictureFailed(NetworkFailure())],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUploadProfilePictureFailed] when UploadRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockUploadRestaurantProfilePictureUseCase(tUploadRestaurantProfilePictureParams),
        ).thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams)),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantUploadProfilePictureFailed(CredentialFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantUploadProfilePictureFailed] when UploadRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockUploadRestaurantProfilePictureUseCase(tUploadRestaurantProfilePictureParams),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UploadRestaurantProfilePicture(tUploadRestaurantProfilePictureParams)),
      expect:
          () => [RestaurantLoading(), RestaurantUploadProfilePictureFailed(ServerFailure())],
    );

    // RemoveRestaurantProfilePicture
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantRemoveProfilePictureSuccess] when RemoveRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockRemoveRestaurantProfilePictureUseCase(NoParams()),
        ).thenAnswer((_) async => Right(tRestaurantModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveRestaurantProfilePicture()),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantRemoveProfilePictureSuccess(tRestaurantModel),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantRemoveProfilePictureFailed] when RemoveRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockRemoveRestaurantProfilePictureUseCase(NoParams()),
        ).thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveRestaurantProfilePicture()),
      expect:
          () => [RestaurantLoading(), RestaurantRemoveProfilePictureFailed(NetworkFailure())],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantRemoveProfilePictureFailed] when RemoveRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockRemoveRestaurantProfilePictureUseCase(NoParams()),
        ).thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveRestaurantProfilePicture()),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantRemoveProfilePictureFailed(CredentialFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantRemoveProfilePictureFailed] when RemoveRestaurantProfilePicture is added',
      build: () {
        when(
          () => mockRemoveRestaurantProfilePictureUseCase(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(RemoveRestaurantProfilePicture()),
      expect:
          () => [RestaurantLoading(), RestaurantRemoveProfilePictureFailed(ServerFailure())],
    );

    // UpdateRestaurantLocation
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLocationUpdating, RestaurantUpdateLocationSuccess] when UpdateRestaurantLocation is added',
      build: () {
        when(
          () => mockUpdateRestaurantLocationUseCase(NoParams()),
        ).thenAnswer((_) async => Right(tRestaurantModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurantLocation()),
      expect:
          () => [
            RestaurantLocationUpdating(),
            RestaurantUpdateLocationSuccess(tRestaurantModel),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLocationUpdating, RestaurantUpdateLocationFailed] when UpdateRestaurantLocation is added',
      build: () {
        when(
          () => mockUpdateRestaurantLocationUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurantLocation()),
      expect:
          () => [
            RestaurantLocationUpdating(),
            RestaurantUpdateLocationFailed(NetworkFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLocationUpdating, RestaurantUpdateLocationFailed] when UpdateRestaurantLocation is added',
      build: () {
        when(
          () => mockUpdateRestaurantLocationUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurantLocation()),
      expect:
          () => [
            RestaurantLocationUpdating(),
            RestaurantUpdateLocationFailed(CredentialFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLocationUpdating, RestaurantUpdateLocationFailed] when UpdateRestaurantLocation is added',
      build: () {
        when(
          () => mockUpdateRestaurantLocationUseCase(tUpdateRestaurantParams),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateRestaurantLocation()),
      expect:
          () => [
            RestaurantLocationUpdating(),
            RestaurantUpdateLocationFailed(ServerFailure()),
          ],
    );

    // DeleteRestaurant
    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantDeleteSuccess] when DeleteRestaurant is added',
      build: () {
        when(
          () => mockDeleteRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => Right(unit));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteRestaurant()),
      expect: () => [RestaurantLoading(), RestaurantDeleteSuccess(unit)],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantDeleteFailed] when DeleteRestaurant is added',
      build: () {
        when(
          () => mockDeleteRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteRestaurant()),
      expect:
          () => [RestaurantLoading(), RestaurantDeleteFailed(NetworkFailure())],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantDeleteFailed] when DeleteRestaurant is added',
      build: () {
        when(
          () => mockDeleteRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteRestaurant()),
      expect:
          () => [
            RestaurantLoading(),
            RestaurantDeleteFailed(CredentialFailure()),
          ],
    );

    blocTest<RestaurantBloc, RestaurantState>(
      'emits [RestaurantLoading, RestaurantDeleteFailed] when DeleteRestaurant is added',
      build: () {
        when(
          () => mockDeleteRestaurantUseCase(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteRestaurant()),
      expect:
          () => [RestaurantLoading(), RestaurantDeleteFailed(ServerFailure())],
    );
  });
}
