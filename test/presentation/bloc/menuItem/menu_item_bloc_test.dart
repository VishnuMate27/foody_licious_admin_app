import 'dart:math';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/menuItem/menu_item_bloc.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockAddMenuItemUseCase extends Mock implements AddMenuItemUseCase {}

class MockUpdateMenuItemUseCase extends Mock implements UpdateMenuItemUseCase {}

class MockDeleteMenuItemUseCase extends Mock implements DeleteMenuItemUseCase {}

class MockGetAllMenuItemsUseCase extends Mock
    implements GetAllMenuItemsUseCase {}

class MockIncreaseItemQuantityUseCase extends Mock
    implements IncreaseItemQuantityUseCase {}

class MockDecreaseItemQuantityUseCase extends Mock
    implements DecreaseItemQuantityUseCase {}

void main() {
  late MenuItemBloc menuItemBloc;
  late MockAddMenuItemUseCase mockAddMenuItemUseCase;
  late MockUpdateMenuItemUseCase mockUpdateMenuItemUseCase;
  late MockDeleteMenuItemUseCase mockDeleteMenuItemUseCase;
  late MockGetAllMenuItemsUseCase mockGetAllMenuItemsUseCase;
  late MockIncreaseItemQuantityUseCase mockIncreaseItemQuantityUseCase;
  late MockDecreaseItemQuantityUseCase mockDecreaseItemQuantityUseCase;

  setUp(() {
    mockAddMenuItemUseCase = MockAddMenuItemUseCase();
    mockUpdateMenuItemUseCase = MockUpdateMenuItemUseCase();
    mockDeleteMenuItemUseCase = MockDeleteMenuItemUseCase();
    mockGetAllMenuItemsUseCase = MockGetAllMenuItemsUseCase();
    mockIncreaseItemQuantityUseCase = MockIncreaseItemQuantityUseCase();
    mockDecreaseItemQuantityUseCase = MockDecreaseItemQuantityUseCase();
    menuItemBloc = MenuItemBloc(
      mockAddMenuItemUseCase,
      mockUpdateMenuItemUseCase,
      mockDeleteMenuItemUseCase,
      mockGetAllMenuItemsUseCase,
      mockIncreaseItemQuantityUseCase,
      mockDecreaseItemQuantityUseCase,
    );
  });

  setUpAll(() {
    registerFallbackValue(tUpdateMenuItemParams);
  });

  test('initial state should be MenuItemInitial', () {
    expect(menuItemBloc.state, MenuItemInitial());
  });

  /// AddItemsInMenu
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemAddLoading, MenuItemAddSuccess] when AddMenuItem is added.',
    build: () {
      when(
        () => mockAddMenuItemUseCase(tAddMenuItemParams),
      ).thenAnswer((_) async => Right(unit));
      return menuItemBloc;
    },
    act: (bloc) => bloc.add(AddMenuItem(tAddMenuItemParams)),
    expect: () => [MenuItemAddLoading(), MenuItemAddSuccess()],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemAddLoading, MenuItemAddFailed] when AddMenuItem is added.',
    build: () {
      when(
        () => mockAddMenuItemUseCase(tAddMenuItemParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    act: (bloc) => bloc.add(AddMenuItem(tAddMenuItemParams)),
    expect:
        () => [
          MenuItemAddLoading(),
          MenuItemAddFailed(ExceptionFailure(e.toString())),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemAddLoading, MenuItemAddFailed] when AddMenuItem is added.',
    build: () {
      when(
        () => mockAddMenuItemUseCase(tAddMenuItemParams),
      ).thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
      return menuItemBloc;
    },
    act: (bloc) => bloc.add(AddMenuItem(tAddMenuItemParams)),
    expect:
        () => [
          MenuItemAddLoading(),
          MenuItemAddFailed(RestaurantNotExistsFailure()),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemAddLoading, MenuItemAddFailed] when AddMenuItem is added.',
    build: () {
      when(
        () => mockAddMenuItemUseCase(tAddMenuItemParams),
      ).thenAnswer((_) async => Left(ItemAlreadyExistsFailure()));
      return menuItemBloc;
    },
    act: (bloc) => bloc.add(AddMenuItem(tAddMenuItemParams)),
    expect:
        () => [
          MenuItemAddLoading(),
          MenuItemAddFailed(ItemAlreadyExistsFailure()),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemAddLoading, MenuItemAddFailed] when AddMenuItem is added.',
    build: () {
      when(
        () => mockAddMenuItemUseCase(tAddMenuItemParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    act: (bloc) => bloc.add(AddMenuItem(tAddMenuItemParams)),
    expect: () => [MenuItemAddLoading(), MenuItemAddFailed(ServerFailure())],
  );

  /// DeleteMenuItem
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemDeleteSuccess, FetchingAllMenuItemsSuccess] when deletion succeeds',
    build: () {
      when(
        () => mockDeleteMenuItemUseCase(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Right(unit));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DeleteMenuItem(tDeleteMenuItemsParams)),
    expect:
        () => [
          MenuItemDeleteSuccess(),
          FetchingAllMenuItemsSuccess([tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemDeleteFailed, FetchingAllMenuItemsSuccess] when deletion succeeds',
    build: () {
      when(
        () => mockDeleteMenuItemUseCase(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DeleteMenuItem(tDeleteMenuItemsParams)),
    expect:
        () => [
          MenuItemDeleteFailed(ExceptionFailure(e.toString())),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemDeleteFailed, FetchingAllMenuItemsSuccess] when deletion succeeds',
    build: () {
      when(
        () => mockDeleteMenuItemUseCase(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DeleteMenuItem(tDeleteMenuItemsParams)),
    expect:
        () => [
          MenuItemDeleteFailed(CredentialFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemDeleteFailed, FetchingAllMenuItemsSuccess] when deletion succeeds',
    build: () {
      when(
        () => mockDeleteMenuItemUseCase(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Left(ItemNotExistsFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DeleteMenuItem(tDeleteMenuItemsParams)),
    expect:
        () => [
          MenuItemDeleteFailed(ItemNotExistsFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemDeleteFailed, FetchingAllMenuItemsSuccess] when deletion succeeds',
    build: () {
      when(
        () => mockDeleteMenuItemUseCase(tDeleteMenuItemsParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DeleteMenuItem(tDeleteMenuItemsParams)),
    expect:
        () => [
          MenuItemDeleteFailed(ServerFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  /// IncreaseItemQuantity
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsSuccess] when item quantity increase succeeds',
    build: () {
      when(
        () => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams),
      ).thenAnswer((_) async => Right(tIncreasedQuantityMenuItem));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
    expect:
        () => [
          FetchingAllMenuItemsSuccess([tIncreasedQuantityMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [IncreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity increase Failed',
    build: () {
      when(
        () => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
    expect:
        () => [
          IncreaseMenuItemQuantityFailed(ExceptionFailure(e.toString())),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [IncreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity increase Failed',
    build: () {
      when(
        () => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
    expect:
        () => [
          IncreaseMenuItemQuantityFailed(CredentialFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [IncreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity increase Failed',
    build: () {
      when(
        () => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
    expect:
        () => [
          IncreaseMenuItemQuantityFailed(ServerFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  /// DecreaseItemQuantity
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsSuccess] when item quantity decrease succeeds',
    build: () {
      when(
        () => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams),
      ).thenAnswer((_) async => Right(tDecreasedQuantityMenuItem));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
    expect:
        () => [
          FetchingAllMenuItemsSuccess([tDecreasedQuantityMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [DecreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity decrease Failed',
    build: () {
      when(
        () => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
    expect:
        () => [
          DecreaseMenuItemQuantityFailed(ExceptionFailure(e.toString())),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [DecreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity decrease Failed',
    build: () {
      when(
        () => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
    expect:
        () => [
          DecreaseMenuItemQuantityFailed(CredentialFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [DecreaseMenuItemQuantityFailed, FetchingAllMenuItemsSuccess] when item quantity decrease Failed',
    build: () {
      when(
        () => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
    expect:
        () => [
          DecreaseMenuItemQuantityFailed(ServerFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  /// GetAllItemQuantity
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsSuccess] when GetAllMenuItems succeds',
    build: () {
      when(
        () => mockGetAllMenuItemsUseCase(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Right([tMenuItem, tMenuItem2]));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem]),
    act: (bloc) => bloc.add(GetAllMenuItems(tGetAllMenuItemsParams)),
    expect:
        () => [
          FetchingAllMenuItemsLoading(),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] when GetAllMenuItems succeds',
    build: () {
      when(
        () => mockGetAllMenuItemsUseCase(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem]),
    act: (bloc) => bloc.add(GetAllMenuItems(tGetAllMenuItemsParams)),
    expect:
        () => [
          FetchingAllMenuItemsLoading(),
          FetchingAllMenuItemsFailed(ExceptionFailure(e.toString())),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] when GetAllMenuItems succeds',
    build: () {
      when(
        () => mockGetAllMenuItemsUseCase(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Left(CredentialFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem]),
    act: (bloc) => bloc.add(GetAllMenuItems(tGetAllMenuItemsParams)),
    expect:
        () => [
          FetchingAllMenuItemsLoading(),
          FetchingAllMenuItemsFailed(CredentialFailure()),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] when GetAllMenuItems succeds',
    build: () {
      when(
        () => mockGetAllMenuItemsUseCase(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem]),
    act: (bloc) => bloc.add(GetAllMenuItems(tGetAllMenuItemsParams)),
    expect:
        () => [
          FetchingAllMenuItemsLoading(),
          FetchingAllMenuItemsFailed(RestaurantNotExistsFailure()),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [FetchingAllMenuItemsLoading, FetchingAllMenuItemsFailed] when GetAllMenuItems succeds',
    build: () {
      when(
        () => mockGetAllMenuItemsUseCase(tGetAllMenuItemsParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem]),
    act: (bloc) => bloc.add(GetAllMenuItems(tGetAllMenuItemsParams)),
    expect:
        () => [
          FetchingAllMenuItemsLoading(),
          FetchingAllMenuItemsFailed(ServerFailure()),
        ],
  );

  /// UpdateItemInMenu
  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemUpdateSuccess, FetchingAllMenuItemsSuccess] when UpdateItemInMenu succeds',
    build: () {
      when(
        () => mockUpdateMenuItemUseCase(tUpdateMenuItemParams),
      ).thenAnswer((_) async => Right(tUpdatedMenuItem));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(UpdateMenuItem(tUpdateMenuItemParams)),
    expect:
        () => [
          MenuItemUpdateSuccess(tUpdatedMenuItem),
          FetchingAllMenuItemsSuccess([tUpdatedMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemUpdateFailed, FetchingAllMenuItemsSuccess] when UpdateItemInMenu succeds',
    build: () {
      when(
        () => mockUpdateMenuItemUseCase(tUpdateMenuItemParams),
      ).thenAnswer((_) async => Left(ExceptionFailure(e.toString())));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(UpdateMenuItem(tUpdateMenuItemParams)),
    expect:
        () => [
          MenuItemUpdateFailed(ExceptionFailure(e.toString())),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemUpdateFailed, FetchingAllMenuItemsSuccess] when UpdateItemInMenu succeds',
    build: () {
      when(
        () => mockUpdateMenuItemUseCase(tUpdateMenuItemParams),
      ).thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(UpdateMenuItem(tUpdateMenuItemParams)),
    expect:
        () => [
          MenuItemUpdateFailed(RestaurantNotExistsFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemUpdateFailed, FetchingAllMenuItemsSuccess] when UpdateItemInMenu succeds',
    build: () {
      when(
        () => mockUpdateMenuItemUseCase(tUpdateMenuItemParams),
      ).thenAnswer((_) async => Left(ItemAlreadyExistsFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(UpdateMenuItem(tUpdateMenuItemParams)),
    expect:
        () => [
          MenuItemUpdateFailed(ItemAlreadyExistsFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );

  blocTest<MenuItemBloc, MenuItemState>(
    'emits [MenuItemUpdateFailed, FetchingAllMenuItemsSuccess] when UpdateItemInMenu succeds',
    build: () {
      when(
        () => mockUpdateMenuItemUseCase(tUpdateMenuItemParams),
      ).thenAnswer((_) async => Left(ServerFailure()));
      return menuItemBloc;
    },
    seed: () => FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
    act: (bloc) => bloc.add(UpdateMenuItem(tUpdateMenuItemParams)),
    expect:
        () => [
          MenuItemUpdateFailed(ServerFailure()),
          FetchingAllMenuItemsSuccess([tMenuItem, tMenuItem2]),
        ],
  );
}
