import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/check_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/delete_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/remove_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_location_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  CheckRestaurantUseCase _checkRestaurantUseCase;
  UpdateRestaurantLocationUseCase _updateRestaurantLocationUseCase;
  UpdateRestaurantUseCase _updateRestaurantUseCase;
  UploadRestaurantProfilePictureUseCase _uploadRestaurantProfilePictureUseCase;
  RemoveRestaurantProfilePictureUseCase _removeRestaurantProfilePictureUseCase;
  DeleteRestaurantUseCase _deleteRestaurantUseCase;

  RestaurantBloc(
    this._checkRestaurantUseCase,
    this._updateRestaurantLocationUseCase,
    this._updateRestaurantUseCase,
    this._uploadRestaurantProfilePictureUseCase,
    this._removeRestaurantProfilePictureUseCase,
    this._deleteRestaurantUseCase,
  ) : super(RestaurantInitial()) {
    on<CheckRestaurant>(_checkRestaurant);
    on<UpdateRestaurant>(_updateRestaurant);
    on<UpdateRestaurantLocation>(_updateRestaurantLocation);
    on<UploadRestaurantProfilePicture>(_uploadRestaurantProfilePicture);
    on<RemoveRestaurantProfilePicture>(_removeRestaurantProfilePicture);
    on<DeleteRestaurant>(_deleteRestaurant);
  }

  void _checkRestaurant(
    CheckRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLoading());
      final result = await _checkRestaurantUseCase(NoParams());
      result.fold(
        (failure) => emit(RestaurantUnauthenticated(failure)),
        (restaurant) => emit(RestaurantAuthenticated(restaurant)),
      );
    } catch (e) {
      emit(RestaurantUnauthenticated(ExceptionFailure(e.toString())));
    }
  }

  void _updateRestaurant(
    UpdateRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLoading());
      final result = await _updateRestaurantUseCase(event.params);
      result.fold(
        (failure) => emit(RestaurantUpdateFailed(failure)),
        (restaurant) => emit(RestaurantUpdateSuccess(restaurant)),
      );
    } catch (e) {
      emit(RestaurantUpdateFailed(ExceptionFailure(e.toString())));
    }
  }

  void _uploadRestaurantProfilePicture(
    UploadRestaurantProfilePicture event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLoading());
      final result = await _uploadRestaurantProfilePictureUseCase(event.params);
      result.fold(
        (failure) => emit(RestaurantUploadProfilePictureFailed(failure)),
        (restaurant) => emit(RestaurantUploadProfilePictureSuccess(restaurant)),
      );
    } catch (e) {
      emit(RestaurantUploadProfilePictureFailed(ExceptionFailure(e.toString())));
    }
  }

  void _removeRestaurantProfilePicture(
    RemoveRestaurantProfilePicture event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLoading());
      final result = await _removeRestaurantProfilePictureUseCase(NoParams());
      result.fold(
        (failure) => emit(RestaurantRemoveProfilePictureFailed(failure)),
        (restaurant) => emit(RestaurantRemoveProfilePictureSuccess(restaurant)),
      );
    } catch (e) {
      emit(RestaurantRemoveProfilePictureFailed(ExceptionFailure(e.toString())));
    }
  }

  void _updateRestaurantLocation(
    UpdateRestaurantLocation event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLocationUpdating());
      final result = await _updateRestaurantLocationUseCase(NoParams());
      result.fold(
        (failure) => emit(RestaurantUpdateLocationFailed(failure)),
        (restaurant) => emit(RestaurantUpdateLocationSuccess(restaurant)),
      );
    } catch (e) {
      emit(RestaurantUpdateLocationFailed(ExceptionFailure(e.toString())));
    }
  }

  void _deleteRestaurant(
    DeleteRestaurant event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      emit(RestaurantLoading());
      final result = await _deleteRestaurantUseCase(NoParams());
      result.fold(
        (failure) => emit(RestaurantDeleteFailed(failure)),
        (unit) => emit(RestaurantDeleteSuccess(unit)),
      );
    } catch (e) {
      emit(RestaurantUpdateFailed(ExceptionFailure(e.toString())));
    }
  }
}
