import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/add_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/all_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/delivery_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/feedback_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/onboarding_view.dart';
import 'package:foody_licious_admin_app/presentation/view/post_auth/profile_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/login_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/set_location_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/signup_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/splash_view.dart';
import 'package:foody_licious_admin_app/presentation/view/pre_auth/verification_view.dart';

class AppRouter {
  //splash & onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  //main menu
  static const String dashboard = '/dashboard';
  //authentication
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String setLocation = '/set-location';
  //post_auth
  static const String addMenu = '/add-menu';
  static const String allMenu = '/all-menu';
  static const String delivery = '/delivery';
  static const String profile = '/profile';
  static const String feedback = '/feedback';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //splash & onboarding
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      //authentication
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case verification:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerificationView(
            nameController: args['nameController'],
            emailOrPhoneController: args['emailOrPhoneController'],
            authProvider: args['authProvider'],
          ),
        );
      case setLocation:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SetLocationView(
            // previousCity: args?['previousCity'],
          ),
        );
      //post_auth
      case addMenu:
        return MaterialPageRoute(builder: (_) => AddMenuView());
      case allMenu:
        return MaterialPageRoute(builder: (_) => AllMenuView());
      case delivery:
        return MaterialPageRoute(builder: (_) => DeliveryView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case feedback:
        return MaterialPageRoute(builder: (_) => FeedbackView());
      default:
        throw ExceptionFailure("Route not found!");
      // throw const RouteException('Route not found!');
    }
  }
}
