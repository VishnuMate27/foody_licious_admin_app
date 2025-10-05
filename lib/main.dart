import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/services/service_locator.dart' as di;
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/add_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/all_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/create_new_admin_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/dashboard.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/delivery_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/feedback_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/profile_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/login_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/set_location_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/signup_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthBloc>()..add(AuthCheck()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: 'Foody Licious',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SignUpView(),
        ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = kWhite
    ..backgroundColor = kPrimaryRed
    ..indicatorColor = kWhite
    ..textColor = kWhite
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}