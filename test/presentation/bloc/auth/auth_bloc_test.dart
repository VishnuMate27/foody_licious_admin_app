import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/usecase/usecase.dart';
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
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockSignInWithEmailUseCase extends Mock
    implements SignInWithEmailUseCase {}

class MockVerifyPhoneNumberForLoginUseCase extends Mock
    implements VerifyPhoneNumberForLoginUseCase {}

class MockSignInWithPhoneUseCase extends Mock
    implements SignInWithPhoneUseCase {}

class MockSignInWithGoogleUseCase extends Mock
    implements SignInWithGoogleUseCase {}

class MockSignInWithFacebookUseCase extends Mock
    implements SignInWithFacebookUseCase {}

class MockSendPasswordResetEmailUseCase extends Mock
    implements SendPasswordResetEmailUseCase {}

class MockSignUpWithEmailUseCase extends Mock
    implements SignUpWithEmailUseCase {}

class MockSendVerificationEmailUseCase extends Mock
    implements SendVerificationEmailUseCase {}

class MockWaitForEmailVerificationUsecase extends Mock
    implements WaitForEmailVerificationUsecase {}

class MockVerifyPhoneNumberForRegistrationUseCase extends Mock
    implements VerifyPhoneNumberForRegistrationUseCase {}

class MockSignUpWithPhoneUseCase extends Mock
    implements SignUpWithPhoneUseCase {}

class MockSignUpWithGoogleUseCase extends Mock
    implements SignUpWithGoogleUseCase {}

class MockSignUpWithFacebookUseCase extends Mock
    implements SignUpWithFacebookUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

void main() {
  group('AuthBloc', () {
    late AuthBloc authBloc;
    late SignInWithEmailUseCase mockSignInWithEmailUseCase;
    late VerifyPhoneNumberForLoginUseCase mockVerifyPhoneNumberForLoginUseCase;
    late SignInWithPhoneUseCase mockSignInWithPhoneUseCase;
    late SignInWithGoogleUseCase mockSignInWithGoogleUseCase;
    late SignInWithFacebookUseCase mockSignInWithFacebookUseCase;
    late SendPasswordResetEmailUseCase mockSendPasswordResetEmailUseCase;
    late SignUpWithEmailUseCase mockSignUpWithEmailUseCase;
    late SendVerificationEmailUseCase mockSendVerificationEmailUseCase;
    late WaitForEmailVerificationUsecase mockWaitForEmailVerificationUseCase;
    late VerifyPhoneNumberForRegistrationUseCase
        mockVerifyPhoneNumberForRegistrationUseCase;
    late SignUpWithPhoneUseCase mockSignUpWithPhoneUseCase;
    late SignUpWithGoogleUseCase mockSignUpWithGoogleUseCase;
    late SignUpWithFacebookUseCase mockSignUpWithFacebookUseCase;
    late SignOutUseCase mockSignOutUseCase;

    setUp(() {
      mockSignInWithEmailUseCase = MockSignInWithEmailUseCase();
      mockVerifyPhoneNumberForLoginUseCase =
          MockVerifyPhoneNumberForLoginUseCase();
      mockSignInWithPhoneUseCase = MockSignInWithPhoneUseCase();
      mockSignInWithGoogleUseCase = MockSignInWithGoogleUseCase();
      mockSignInWithFacebookUseCase = MockSignInWithFacebookUseCase();
      mockSendPasswordResetEmailUseCase = MockSendPasswordResetEmailUseCase();
      mockSignUpWithEmailUseCase = MockSignUpWithEmailUseCase();
      mockSendVerificationEmailUseCase = MockSendVerificationEmailUseCase();
      mockWaitForEmailVerificationUseCase =
          MockWaitForEmailVerificationUsecase();
      mockVerifyPhoneNumberForRegistrationUseCase =
          MockVerifyPhoneNumberForRegistrationUseCase();
      mockSignUpWithPhoneUseCase = MockSignUpWithPhoneUseCase();
      mockSignUpWithGoogleUseCase = MockSignUpWithGoogleUseCase();
      mockSignUpWithFacebookUseCase = MockSignUpWithFacebookUseCase();
      mockSignOutUseCase = MockSignOutUseCase();
      authBloc = AuthBloc(
          mockSignInWithEmailUseCase,
          mockVerifyPhoneNumberForLoginUseCase,
          mockSignInWithPhoneUseCase,
          mockSignInWithGoogleUseCase,
          mockSignInWithFacebookUseCase,
          mockSendPasswordResetEmailUseCase,
          mockSignUpWithEmailUseCase,
          mockSendVerificationEmailUseCase,
          mockWaitForEmailVerificationUseCase,
          mockVerifyPhoneNumberForRegistrationUseCase,
          mockSignUpWithPhoneUseCase,
          mockSignUpWithGoogleUseCase,
          mockSignUpWithFacebookUseCase,
          mockSignOutUseCase);
    });

    test('initial state should be AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    //_onSignInWithEmail
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailSuccess] when AuthSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [AuthLoading(), AuthSignInWithEmailSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailFailed] when AuthSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthSignInWithEmailFailed(ExceptionFailure("Error message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailFailed] when AuthSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () =>
          [AuthLoading(), AuthSignInWithEmailFailed(CredentialFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailFailed] when AuthSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthSignInWithEmailFailed(RestaurantAlreadyExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSignInWithEmailFailed] when AuthSignInWithEmail is added',
      build: () {
        when(() => mockSignInWithEmailUseCase(tSignInWithEmailParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithEmail(tSignInWithEmailParams)),
      expect: () => [AuthLoading(), AuthSignInWithEmailFailed(ServerFailure())],
    );

    //_onVerifyPhoneNumberForLogin
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSent] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [AuthLoading(), AuthVerificationSMSForLoginSent(unit)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(CredentialFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(CredentialFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(RestaurantNotExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(RestaurantNotExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationSMSForLoginSentFailed] when AuthVerifyPhoneNumberForLogin is added',
      build: () {
        when(() => mockVerifyPhoneNumberForLoginUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthVerifyPhoneNumberForLogin(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForLoginSentFailed(ServerFailure())
      ],
    );

    // _onSignInWithPhone
    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoading, AuthPhoneVerificationForLoginSuccess] when AuthSignInWithPhone is added',
      build: () {
        when(() => mockSignInWithPhoneUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithPhone(tSignInWithPhoneParams)),
      expect: () =>
          [AuthLoading(), AuthPhoneVerificationForLoginSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoading, AuthPhoneVerificationForLoginFailed] when AuthSignInWithPhone is added',
      build: () {
        when(() => mockSignInWithPhoneUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithPhone(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForLoginFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoading, AuthPhoneVerificationForLoginFailed] when AuthSignInWithPhone is added',
      build: () {
        when(() => mockSignInWithPhoneUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithPhone(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForLoginFailed(CredentialFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoading, AuthPhoneVerificationForLoginFailed] when AuthSignInWithPhone is added',
      build: () {
        when(() => mockSignInWithPhoneUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithPhone(tSignInWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForLoginFailed(RestaurantNotExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emit [AuthLoading, AuthPhoneVerificationForLoginFailed] when AuthSignInWithPhone is added',
      build: () {
        when(() => mockSignInWithPhoneUseCase(tSignInWithPhoneParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithPhone(tSignInWithPhoneParams)),
      expect: () =>
          [AuthLoading(), AuthPhoneVerificationForLoginFailed(ServerFailure())],
    );

    // _onSignInWithGoogle
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignInSuccess] when AuthSignInWithGoogle is added',
      build: () {
        when(() => mockSignInWithGoogleUseCase(any()))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithGoogle()),
      expect: () => [AuthLoading(), AuthGoogleSignInSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignInFailed] when AuthSignInWithGoogle is added',
      build: () {
        when(() => mockSignInWithGoogleUseCase(NoParams()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithGoogle()),
      expect: () => [
        AuthLoading(),
        AuthGoogleSignInFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignInFailed] when AuthSignInWithGoogle is added',
      build: () {
        when(() => mockSignInWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(AuthProviderMissMatchFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithGoogle()),
      expect: () => [
        AuthLoading(),
        AuthGoogleSignInFailed(AuthProviderMissMatchFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignInFailed] when AuthSignInWithGoogle is added',
      build: () {
        when(() => mockSignInWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithGoogle()),
      expect: () =>
          [AuthLoading(), AuthGoogleSignInFailed(RestaurantNotExistsFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignInFailed] when AuthSignInWithGoogle is added',
      build: () {
        when(() => mockSignInWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithGoogle()),
      expect: () => [AuthLoading(), AuthGoogleSignInFailed(ServerFailure())],
    );

    // _onSignInWithFacebook
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInSuccess when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () => [AuthLoading(), AuthFacebookSignInSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInFailed when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () => [
        AuthLoading(),
        AuthFacebookSignInFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInFailed when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () =>
          [AuthLoading(), AuthFacebookSignInFailed(CredentialFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInFailed when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(AuthProviderMissMatchFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () => [
        AuthLoading(),
        AuthFacebookSignInFailed(AuthProviderMissMatchFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInFailed when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () =>
          [AuthLoading(), AuthFacebookSignInFailed(RestaurantNotExistsFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignInFailed when AuthSignInWithFacebook is added]',
      build: () {
        when(() => mockSignInWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignInWithFacebook()),
      expect: () => [AuthLoading(), AuthFacebookSignInFailed(ServerFailure())],
    );

    // _onSendPasswordResetEmail
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPasswordResetEmailSent] when AuthSendPasswordResetEmail is added',
      build: () {
        when(() => mockSendPasswordResetEmailUseCase(
                tSendPasswordResetEmailParams))
            .thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthSendPasswordResetEmail(tSendPasswordResetEmailParams)),
      expect: () => [AuthLoading(), AuthPasswordResetEmailSent()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPasswordResetEmailSentFailed] when AuthSendPasswordResetEmail is added',
      build: () {
        when(() => mockSendPasswordResetEmailUseCase(
                tSendPasswordResetEmailParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthSendPasswordResetEmail(tSendPasswordResetEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthPasswordResetEmailSentFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPasswordResetEmailSentFailed] when AuthSendPasswordResetEmail is added',
      build: () {
        when(() => mockSendPasswordResetEmailUseCase(
                tSendPasswordResetEmailParams))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthSendPasswordResetEmail(tSendPasswordResetEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthPasswordResetEmailSentFailed(RestaurantNotExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPasswordResetEmailSentFailed] when AuthSendPasswordResetEmail is added',
      build: () {
        when(() => mockSendPasswordResetEmailUseCase(
                tSendPasswordResetEmailParams))
            .thenAnswer(
                (_) async => Left(AuthenticationFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthSendPasswordResetEmail(tSendPasswordResetEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthPasswordResetEmailSentFailed(AuthenticationFailure("Error Message"))
      ],
    );

    // _onSignUpWithEmail
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailRequested] when AuthSignUpWithEmail is added',
      build: () {
        when(() => mockSignUpWithEmailUseCase(tSignUpWithEmailParams))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithEmail(tSignUpWithEmailParams)),
      expect: () => [AuthLoading(), AuthVerificationEmailRequested(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailRequestFailed] when AuthSignUpWithEmail is added',
      build: () {
        when(() => mockSignUpWithEmailUseCase(tSignUpWithEmailParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithEmail(tSignUpWithEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationEmailRequestFailed(CredentialFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailRequestFailed] when AuthSignUpWithEmail is added',
      build: () {
        when(() => mockSignUpWithEmailUseCase(tSignUpWithEmailParams))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithEmail(tSignUpWithEmailParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationEmailRequestFailed(RestaurantAlreadyExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailRequestFailed] when AuthSignUpWithEmail is added',
      build: () {
        when(() => mockSignUpWithEmailUseCase(tSignUpWithEmailParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithEmail(tSignUpWithEmailParams)),
      expect: () =>
          [AuthLoading(), AuthVerificationEmailRequestFailed(ServerFailure())],
    );

    // _onSendVerificationEmail
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailSent] when AuthSendVerificationEmail is added.',
      build: () {
        when(() => mockSendVerificationEmailUseCase(any()))
            .thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendVerificationEmail()),
      expect: () => [AuthLoading(), AuthVerificationEmailSent()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailSentFailed] when AuthSendVerificationEmail is added.',
      build: () {
        when(() => mockSendVerificationEmailUseCase(any()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendVerificationEmail()),
      expect: () => [
        AuthLoading(),
        AuthVerificationEmailSentFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailSentFailed] when AuthSendVerificationEmail is added.',
      build: () {
        when(() => mockSendVerificationEmailUseCase(any()))
            .thenAnswer((_) async => Left(TooManyRequestsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendVerificationEmail()),
      expect: () => [
        AuthLoading(),
        AuthVerificationEmailSentFailed(TooManyRequestsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailSentFailed] when AuthSendVerificationEmail is added.',
      build: () {
        when(() => mockSendVerificationEmailUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendVerificationEmail()),
      expect: () => [
        AuthLoading(),
        AuthVerificationEmailSentFailed(RestaurantNotExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthVerificationEmailSentFailed] when AuthSendVerificationEmail is added.',
      build: () {
        when(() => mockSendVerificationEmailUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSendVerificationEmail()),
      expect: () =>
          [AuthLoading(), AuthVerificationEmailSentFailed(ServerFailure())],
    );

    // _onWaitForEmailVerification
    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerificationEmailSent, AuthEmailVerificationSuccess when AuthWaitForEmailVerification is added]',
      build: () {
        when(() => mockWaitForEmailVerificationUseCase(any()))
            .thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthWaitForEmailVerification()),
      expect: () => [AuthVerificationEmailSent(), AuthEmailVerificationSuccess()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerificationEmailSent, AuthEmailVerificationFailed when AuthWaitForEmailVerification is added]',
      build: () {
        when(() => mockWaitForEmailVerificationUseCase(any()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthWaitForEmailVerification()),
      expect: () => [
        AuthVerificationEmailSent(),
        AuthEmailVerificationFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerificationEmailSent, AuthEmailVerificationFailed when AuthWaitForEmailVerification is added]',
      build: () {
        when(() => mockWaitForEmailVerificationUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantNotExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthWaitForEmailVerification()),
      expect: () =>
          [AuthVerificationEmailSent(), AuthEmailVerificationFailed(RestaurantNotExistsFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthVerificationEmailSent, AuthEmailVerificationFailed when AuthWaitForEmailVerification is added]',
      build: () {
        when(() => mockWaitForEmailVerificationUseCase(any()))
            .thenAnswer((_) async => Left(TimeOutFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthWaitForEmailVerification()),
      expect: () =>
          [AuthVerificationEmailSent(), AuthEmailVerificationFailed(TimeOutFailure())],
    );

    // _onVerifyPhoneNumberForRegistration
    blocTest<AuthBloc, AuthState>(
      'emits[AuthLoading, AuthVerificationSMSForRegistrationSent] when AuthVerifyPhoneNumberForRegistration is added',
      build: () {
        when(() => mockVerifyPhoneNumberForRegistrationUseCase(
            tSignUpWithPhoneParams)).thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc
          .add(AuthVerifyPhoneNumberForRegistration(tSignUpWithPhoneParams)),
      expect: () =>
          [AuthLoading(), AuthVerificationSMSForRegistrationSent(unit)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits[AuthLoading, AuthVerificationSMSForRegistrationSentFailed] when AuthVerifyPhoneNumberForRegistration is added',
      build: () {
        when(() => mockVerifyPhoneNumberForRegistrationUseCase(
                tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc
          .add(AuthVerifyPhoneNumberForRegistration(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForRegistrationSentFailed(
            ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits[AuthLoading, AuthVerificationSMSForRegistrationSentFailed] when AuthVerifyPhoneNumberForRegistration is added',
      build: () {
        when(() => mockVerifyPhoneNumberForRegistrationUseCase(
                tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc
          .add(AuthVerifyPhoneNumberForRegistration(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForRegistrationSentFailed(RestaurantAlreadyExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits[AuthLoading, AuthVerificationSMSForRegistrationSentFailed] when AuthVerifyPhoneNumberForRegistration is added',
      build: () {
        when(() => mockVerifyPhoneNumberForRegistrationUseCase(
                tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc
          .add(AuthVerifyPhoneNumberForRegistration(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthVerificationSMSForRegistrationSentFailed(ServerFailure())
      ],
    );

    // _onSignUpWithPhone
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPhoneVerificationForRegistrationSuccess] when AuthSignUpWithPhone is added',
      build: () {
        when(() => mockSignUpWithPhoneUseCase(tSignUpWithPhoneParams))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithPhone(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForRegistrationSuccess(tRestaurantModel)
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPhoneVerificationForRegistrationFailed] when AuthSignUpWithPhone is added',
      build: () {
        when(() => mockSignUpWithPhoneUseCase(tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(ExceptionFailure("Failure Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithPhone(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForRegistrationFailed(
            ExceptionFailure("Failure Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPhoneVerificationForRegistrationFailed] when AuthSignUpWithPhone is added',
      build: () {
        when(() => mockSignUpWithPhoneUseCase(tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithPhone(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForRegistrationFailed(CredentialFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPhoneVerificationForRegistrationFailed] when AuthSignUpWithPhone is added',
      build: () {
        when(() => mockSignUpWithPhoneUseCase(tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithPhone(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForRegistrationFailed(RestaurantAlreadyExistsFailure())
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthPhoneVerificationForRegistrationFailed] when AuthSignUpWithPhone is added',
      build: () {
        when(() => mockSignUpWithPhoneUseCase(tSignUpWithPhoneParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithPhone(tSignUpWithPhoneParams)),
      expect: () => [
        AuthLoading(),
        AuthPhoneVerificationForRegistrationFailed(ServerFailure())
      ],
    );

    // _onSignUpWithGoogle
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignUpSuccess] when AuthSignUpWithGoogle is added',
      build: () {
        when(() => mockSignUpWithGoogleUseCase(any()))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithGoogle()),
      expect: () => [AuthLoading(), AuthGoogleSignUpSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignUpFailed] when AuthSignUpWithGoogle is added',
      build: () {
        when(() => mockSignUpWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithGoogle()),
      expect: () => [
        AuthLoading(),
        AuthGoogleSignUpFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignUpFailed] when AuthSignUpWithGoogle is added',
      build: () {
        when(() => mockSignUpWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithGoogle()),
      expect: () =>
          [AuthLoading(), AuthGoogleSignUpFailed(CredentialFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignUpFailed] when AuthSignUpWithGoogle is added',
      build: () {
        when(() => mockSignUpWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithGoogle()),
      expect: () =>
          [AuthLoading(), AuthGoogleSignUpFailed(RestaurantAlreadyExistsFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthGoogleSignUpFailed] when AuthSignUpWithGoogle is added',
      build: () {
        when(() => mockSignUpWithGoogleUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithGoogle()),
      expect: () => [AuthLoading(), AuthGoogleSignUpFailed(ServerFailure())],
    );

    // _onSignUpWithFacebook
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignUpSuccess] when AuthSignUpWithFacebook is added',
      build: () {
        when(() => mockSignUpWithFacebookUseCase(any()))
            .thenAnswer((_) async => Right(tRestaurantModel));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithFacebook()),
      expect: () => [AuthLoading(), AuthFacebookSignUpSuccess(tRestaurantModel)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignUpFailed] when AuthSignUpWithFacebook is added',
      build: () {
        when(() => mockSignUpWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(ExceptionFailure("Error Message")));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithFacebook()),
      expect: () => [
        AuthLoading(),
        AuthFacebookSignUpFailed(ExceptionFailure("Error Message"))
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignUpFailed] when AuthSignUpWithFacebook is added',
      build: () {
        when(() => mockSignUpWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithFacebook()),
      expect: () =>
          [AuthLoading(), AuthFacebookSignUpFailed(CredentialFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignUpFailed] when AuthSignUpWithFacebook is added',
      build: () {
        when(() => mockSignUpWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(RestaurantAlreadyExistsFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithFacebook()),
      expect: () =>
          [AuthLoading(), AuthFacebookSignUpFailed(RestaurantAlreadyExistsFailure())],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFacebookSignUpFailed] when AuthSignUpWithFacebook is added',
      build: () {
        when(() => mockSignUpWithFacebookUseCase(any()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUpWithFacebook()),
      expect: () => [AuthLoading(), AuthFacebookSignUpFailed(ServerFailure())],
    );

    // _onSignOut
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthLoggedOut] when AuthSignOut is added',
      build: () {
        when(() => mockSignOutUseCase(any()))
            .thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignOut()),
      expect: () => [AuthLoading(), AuthLoggedOut()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthLoggedFail] when signOutUseCase throws',
      build: () {
        when(() => mockSignOutUseCase(any()))
            .thenThrow(Exception('sign out failed')); // simulate error
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignOut()),
      expect: () => [
        AuthLoading(),
        isA<AuthLoggedFail>().having(
          (state) => state.failure,
          'failure',
          isA<ExceptionFailure>(),
        ),
      ],
    );
  });
}
