import 'package:foody_licious_admin_app/core/error/failures.dart';

extension FailureMessage on Failure {
  String toMessage({String defaultMessage = "An error occurred"}) {
    if (this is CredentialFailure) return "Invalid Credential!";
    if (this is UserAlreadyExistsFailure) return "User Already Exists!";
    if (this is ServerFailure) return "Server Failure!";
    if (this is UserNotExistsFailure) return "User not exist!";
    if (this is AuthProviderMissMatchFailure) return "You have login with different provider.!";
    if (this is UserNotExistsFailure) return "User not exist!";
    if (this is TooManyRequestsFailure) return "Too many requests!";
    if (this is TimeOutFailure) return "Checking Time Out!";
    if (this is NetworkFailure) return "Network error. Check your connection.";
    return defaultMessage;
  }
}
