import 'package:flutter/material.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/presentation/view/menuItem/add_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/menuItem/all_menu_view.dart';
import 'package:foody_licious_admin_app/presentation/view/dashboard/dashboard.dart';
import 'package:foody_licious_admin_app/presentation/view/delivery/delivery_view.dart';
import 'package:foody_licious_admin_app/presentation/view/feedback/feedback_view.dart';
import 'package:foody_licious_admin_app/presentation/view/menuItem/menu_item_details_view.dart';
import 'package:foody_licious_admin_app/presentation/view/onboarding/onboarding_view.dart';
import 'package:foody_licious_admin_app/presentation/view/profile/profile_view.dart';
import 'package:foody_licious_admin_app/presentation/view/authentication/login_view.dart';
import 'package:foody_licious_admin_app/presentation/view/authentication/set_location_view.dart';
import 'package:foody_licious_admin_app/presentation/view/authentication/signup_view.dart';
import 'package:foody_licious_admin_app/presentation/view/onboarding/splash_view.dart';
import 'package:foody_licious_admin_app/presentation/view/authentication/verification_view.dart';

class AppRouter {
  //splash & onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  //authentication
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String setLocation = '/set-location';
  //main menu
  static const String dashboard = '/dashboard';
  //post_auth
  static const String allMenu = '/all-menu';
  static const String addMenu = '/add-menu';
  static const String menuItemDetails = '/menu-item-details';
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
          builder:
              (_) => VerificationView(
                nameController: args['nameController'],
                emailOrPhoneController: args['emailOrPhoneController'],
                authProvider: args['authProvider'],
              ),
        );
      case setLocation:
        final args = routeSettings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SetLocationView(previousCity: args?['previousCity']),
        );
      //post_auth
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case allMenu:
        return MaterialPageRoute(builder: (_) => AllMenuView());
      case menuItemDetails:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => MenuItemDetailsView(menuItem: args['menuItem']),
        );
      case addMenu:
        return MaterialPageRoute(builder: (_) => AddMenuView());
      case delivery:
        return MaterialPageRoute(builder: (_) => DeliveryView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case feedback:
        return MaterialPageRoute(builder: (_) => FeedbackView());
      default:
        throw ExceptionFailure("Route not found!");
    }
  }
}
