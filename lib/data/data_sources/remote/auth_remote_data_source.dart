import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/authentication_reponsse_model.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthenticationResponseModel> signInWithEmail(
    SignInWithEmailParams params,
  );
  Future<Unit> verifyPhoneNumberForLogin(SignInWithPhoneParams params);
  Future<AuthenticationResponseModel> signInWithPhone(
    SignInWithPhoneParams params,
  );
  Future<AuthenticationResponseModel> signInWithGoogle();
  Future<AuthenticationResponseModel> signInWithFacebook();
  Future<Unit> sendPasswordResetEmail(SendPasswordResetEmailParams params);
  Future<AuthenticationResponseModel> signUpWithEmail(
    SignUpWithEmailParams params,
  );
  Future<Unit> sendVerificationEmail();
  Future<Unit> waitForEmailVerification();
  Future<Unit> verifyPhoneNumberForRegistration(SignUpWithPhoneParams params);
  Future<AuthenticationResponseModel> signUpWithPhone(
    SignUpWithPhoneParams params,
  );
  Future<AuthenticationResponseModel> signUpWithGoogle();
  Future<AuthenticationResponseModel> signUpWithFacebook();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  User? user;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.client,
    required this.googleSignIn,
    required this.facebookAuth,
  });

  @override
  Future<AuthenticationResponseModel> signInWithEmail(
    SignInWithEmailParams params,
  ) async {
    User? user;
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      user = userCredential.user;
      return await _sendLoginRequest(user!, params: params);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw RestaurantNotExistsFailure();
      } else if (e.code == 'wrong-password') {
        throw CredentialFailure();
      } else {
        throw AuthenticationFailure(e.message ?? 'Unknown error');
      }
    }
  }

  @override
  Future<Unit> verifyPhoneNumberForLogin(SignInWithPhoneParams params) async {
    final requestBody = json.encode({"phone": params.phone ?? ""});

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/sendVerificationCodeForLogin'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<AuthenticationResponseModel> signInWithPhone(
    SignInWithPhoneParams params,
  ) async {
    return await _sendLoginWithPhoneRequest(params);
  }

  @override
  Future<AuthenticationResponseModel> signInWithGoogle() async {
    try {
      googleSignIn.initialize(serverClientId: kServerClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
      if (googleUser == null) {
        throw ExceptionFailure("Google authentication cancelled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      user = userCredential.user;

      if (user == null) throw ExceptionFailure("Google sign-in failed.");
    } catch (e) {
      throw ExceptionFailure(e.toString());
    }
    return await _sendLoginRequest(user!, authProvider: "google");
  }

  @override
  Future<AuthenticationResponseModel> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await facebookAuth.login();
      if (loginResult.status != LoginStatus.success) {
        throw ExceptionFailure("Facebook login failed.");
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      final userCredential = await firebaseAuth.signInWithCredential(
        facebookAuthCredential,
      );
      user = userCredential.user;

      if (user == null) throw ExceptionFailure("Facebook sign-in failed.");
    } catch (e) {
      throw ExceptionFailure(e.toString());
    }
    return await _sendLoginRequest(user!, authProvider: "facebook");
  }

  @override
  Future<Unit> sendPasswordResetEmail(
    SendPasswordResetEmailParams params,
  ) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: params.email);
      return Future.value(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw RestaurantNotExistsFailure();
      } else {
        throw AuthenticationFailure(e.message ?? 'Unknown error');
      }
    } catch (e) {
      throw AuthenticationFailure(e.toString() ?? 'Unknown error');
    }
  }

  @override
  Future<AuthenticationResponseModel> signUpWithEmail(
    SignUpWithEmailParams params,
  ) async {
    // Create user
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
    user = userCredential.user;
    return await _sendRegisterRequest(user!, params: params);
  }

  @override
  Future<Unit> sendVerificationEmail() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.reload();
        await user.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'too-many-requests') {
          throw TooManyRequestsFailure();
        } else {
          throw ServerFailure();
        }
      } catch (e) {
        throw ServerFailure();
      }
    } else {
      throw RestaurantNotExistsFailure();
    }
    return Future.value(unit);
  }

  @override
  Future<Unit> waitForEmailVerification({
    Duration checkInterval = const Duration(seconds: 3),
    Duration timeout = const Duration(minutes: 5),
  }) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw RestaurantNotExistsFailure();
    }

    final stopwatch = Stopwatch()..start();

    while (true) {
      await user.reload(); // Refresh user state
      final refreshedUser = firebaseAuth.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        //TODO: Update user verified to true in database
        return Future.value(unit);
      }

      if (stopwatch.elapsed >= timeout) {
        throw TimeOutFailure();
      }

      await Future.delayed(checkInterval);
    }
  }

  @override
  Future<Unit> verifyPhoneNumberForRegistration(
    SignUpWithPhoneParams params,
  ) async {
    final requestBody = json.encode({"phone": params.phone ?? ""});

    final response = await client.post(
      Uri.parse(
        '$kBaseUrl/api/restaurant/auth/sendVerificationCodeForRegistration',
      ),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      throw RestaurantAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUpWithPhone(
    SignUpWithPhoneParams params,
  ) async {
    return await _sendRegisterWithPhoneRequest(params);
  }

  @override
  Future<AuthenticationResponseModel> signUpWithGoogle() async {
    try {
      googleSignIn.initialize(serverClientId: kServerClientId);
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
      if (googleUser == null) {
        throw ExceptionFailure("Google authentication cancelled.");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await firebaseAuth.signInWithCredential(
        credential,
      );
      user = userCredential.user;

      if (user == null) throw ExceptionFailure("Google sign-in failed.");
    } catch (e) {
      print("Exception is: $e");
      throw ExceptionFailure(e.toString());
    }
    return await _sendRegisterRequest(user!, authProvider: "google");
  }

  @override
  Future<AuthenticationResponseModel> signUpWithFacebook() async {
    try {
      final LoginResult loginResult = await facebookAuth.login();
      if (loginResult.status != LoginStatus.success) {
        throw ExceptionFailure("Facebook login failed.");
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      final userCredential = await firebaseAuth.signInWithCredential(
        facebookAuthCredential,
      );
      user = userCredential.user;

      if (user == null) throw ExceptionFailure("Facebook sign-in failed.");
    } catch (e) {
      throw ExceptionFailure(e.toString());
    }
    return await _sendRegisterRequest(user!, authProvider: "facebook");
  }

  Future<AuthenticationResponseModel> _sendLoginRequest(
    User restaurant, {
    SignInWithEmailParams? params,
    String? authProvider,
  }) async {
    Object? requestBody;
    if (params != null) {
      requestBody = json.encode({
        "email": restaurant.email ?? params.email,
        "id": restaurant.uid,
        "phone": restaurant.phoneNumber ?? "",
        "authProvider": params.authProvider,
      });
    } else {
      requestBody = json.encode({
        "email": restaurant.email,
        "id": restaurant.uid,
        "phone": restaurant.phoneNumber ?? "",
        "authProvider": authProvider,
      });
    }

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/restaurant/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 401) {
      throw AuthProviderMissMatchFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<AuthenticationResponseModel> _sendLoginWithPhoneRequest(
    SignInWithPhoneParams params,
  ) async {
    final requestBody = json.encode({
      "phone": params.phone ?? "",
      "authProvider": params.authProvider,
      "code": params.code,
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/auth/verifyCodeAndLoginWithPhone'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<AuthenticationResponseModel> _sendRegisterRequest(
    User restaurant, {
    SignUpWithEmailParams? params,
    String? authProvider,
  }) async {
    Object? requestBody;
    if (params != null) {
      requestBody = json.encode({
        "email": restaurant.email ?? params.email,
        "id": restaurant.uid,
        "name": params.name,
        "phone": restaurant.phoneNumber ?? "",
        "authProvider": params.authProvider,
      });
    } else {
      requestBody = json.encode({
        "email": restaurant.email,
        "id": restaurant.uid,
        "name": restaurant.displayName,
        "phone": restaurant.phoneNumber ?? "",
        "authProvider": authProvider,
      });
    }

    try {
      final response = await client.post(
        Uri.parse('$kBaseUrl/api/restaurant/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 201) {
        return authenticationResponseModelFromJson(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw CredentialFailure();
      } else if (response.statusCode == 409) {
        throw RestaurantAlreadyExistsFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      debugPrint('Exception is :$e');
    }
    throw ExceptionFailure("Unknown exception");
  }

  Future<AuthenticationResponseModel> _sendRegisterWithPhoneRequest(
    SignUpWithPhoneParams params,
  ) async {
    final requestBody = json.encode({
      "phone": params.phone ?? "",
      "name": params.name ?? "",
      "authProvider": params.authProvider,
      "code": params.code,
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/restaurant/auth/verifyCodeAndRegisterWithPhone'),
      headers: {'Content-Type': 'application/json'},
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      throw RestaurantAlreadyExistsFailure();
    } else {
      throw ServerFailure();
    }
  }
}
