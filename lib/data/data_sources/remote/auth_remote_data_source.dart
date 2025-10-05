import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foody_licious_admin_app/core/constants/strings.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/authentication_reponsse_model.dart';
import 'package:foody_licious_admin_app/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<AuthenticationResponseModel> signUpWithEmail(
    SignUpWithEmailParams params,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FacebookAuth facebookAuth;
  Restaurant? restaurant;
  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.client,
    required this.googleSignIn,
    required this.facebookAuth,
  });

  @override
  Future<AuthenticationResponseModel> signUpWithEmail(
    SignUpWithEmailParams params,
  ) async {
    User? user;
    // Create user
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email!,
      password: params.password!,
    );
    user = userCredential.user;
    return await _sendRegisterRequest(user!, params: params);
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
        Uri.parse('$kBaseUrl/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 201) {
        return authenticationResponseModelFromJson(response.body);
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw CredentialFailure();
      } else if (response.statusCode == 409) {
        throw UserAlreadyExistsFailure();
      } else {
        throw ServerFailure();
      }
    } catch (e) {
      debugPrint('Exception is :$e');
    }
    throw ExceptionFailure("Unknown exception");
  }
}
