import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/data_sources/local/restaurant_local_data_source.dart';
import 'package:foody_licious_admin_app/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious_admin_app/data/repositories/auth_repository_impl.dart';
import 'package:foody_licious_admin_app/data/repositories/restaurant_repository_impl.dart';
import 'package:foody_licious_admin_app/data/services/location_service.dart';
import 'package:foody_licious_admin_app/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_verification_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_facebook_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_google_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_out_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_google_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/verify_phone_number_for_login_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/verify_phone_number_for_registration_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/wait_for_email_verification_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/check_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/delete_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/remove_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_location_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/firebase_options.dart';
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious_admin_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../data/data_sources/remote/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';

final sl = GetIt.instance;

// This global key lets you show dialogs even from here (used by main.dart)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> init() async {
  // Must be first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: "assets/utils/.env");

  //Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(),
      sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  // Use cases
  sl.registerLazySingleton(() => SignInWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberForLoginUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithPhoneUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SendPasswordResetEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithFacebookUseCase(sl()));
  sl.registerLazySingleton(() => SendVerificationEmailUseCase(sl()));
  sl.registerLazySingleton(() => WaitForEmailVerificationUsecase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberForRegistrationUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithPhoneUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithFacebookUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(), client: sl(), googleSignIn: sl(),facebookAuth:sl()),
  );

  //Features - Restaurant
  // Bloc
  sl.registerFactory(() => RestaurantBloc(sl(), sl(), sl(), sl(),sl(),sl()));
  // Use cases
  sl.registerLazySingleton(() => CheckRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRestaurantLocationUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => DeleteRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => UploadRestaurantProfilePictureUseCase(sl()));
  sl.registerLazySingleton(() => RemoveRestaurantProfilePictureUseCase(sl()));
  // Repository
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(client: sl(), locationService: sl()),
  );
  sl.registerLazySingleton<RestaurantLocalDataSource>(
    () => RestaurantLocalDataSourceImpl(sharedPreferences: sl()),
  );


  ///***********************************************
  ///! Core
  /// sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(() => FacebookAuth.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => SmartAuth.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  // Debug-only Wi-Fi check
  if (kDebugMode) {
    _showWifiWarningIfNeeded();
  }
}

/// Check for internet and Wi-Fi connection, then show a warning dialog if needed
Future<void> _showWifiWarningIfNeeded() async {
  final hasInternet = await sl<InternetConnectionChecker>().hasConnection;

  if (!hasInternet) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (dialogContext) => AlertDialog(
          title: const Text('No Wi-Fi Connection'),
          content: const Text(
            'Your device is not connected to Wi-Fi. Please connect to Wi-Fi before testing.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
    return;
  }

  // Verify if connected via Wi-Fi or mobile data
  final interfaces = await NetworkInterface.list();
  final wifiConnected = interfaces.any((i) => i.name.toLowerCase().contains('wlan'));
  if (!wifiConnected) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        barrierDismissible: false,
        context: navigatorKey.currentContext!,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Not Connected via Wi-Fi', style: TextStyle(color: kError)),
          content: const Text(
            'You are connected to the internet, but not through Wi-Fi.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK, i Will connect to Wi-Fi now.'),
            ),
          ],
        ),
      );
    });
  }
}
