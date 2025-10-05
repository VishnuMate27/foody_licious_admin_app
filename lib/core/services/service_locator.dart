import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foody_licious_admin_app/core/network/network_info.dart';
import 'package:foody_licious_admin_app/data/repositories/auth_repository_impl.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/firebase_options.dart';
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
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

Future<void> init() async {
  // Must be first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: "assets/utils/.env");

  //Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));
  // Use cases
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      // localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(), client: sl(), googleSignIn: sl(),facebookAuth:sl()),
  );

  ///***********************************************
  ///! Core
  /// sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // sl.registerLazySingleton<LocationService>(() => LocationServiceImpl());

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
}
