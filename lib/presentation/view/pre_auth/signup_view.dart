import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/extension/failure_extension.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious_admin_app/presentation/widgets/social_auth_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Listen to changes in email/phone field and dispatch to BLoC
    _emailOrPhoneController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _emailOrPhoneController.removeListener(_onInputChanged);
    _nameController.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    final text = _emailOrPhoneController.text.trim();
    context.read<AuthBloc>().add(ValidateEmailOrPhone(text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        String? errorMessage;
        EasyLoading.dismiss();
        if (state is AuthLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is AuthLoggedFail) {
          String errorMessage = "An error occurred. Please try again.";
          if (state.failure is CredentialFailure) {
            errorMessage = "Incorrect username or password.";
          } else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your connection.";
          }
          // EasyLoading.showError(errorMessage);
          print(errorMessage);
        } else if (state is InputValidationState) {
          if (!state.isEmail && _passwordController.text.isNotEmpty) {
            _passwordController.clear();
          }
        } else if (state is AuthVerificationEmailRequested) {
          context.read<AuthBloc>().add(AuthSendVerificationEmail());
        } else if (state is AuthVerificationEmailSent) {
          context.read<AuthBloc>().add(AuthWaitForEmailVerification());
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.verification,
            (Route<dynamic> route) => false,
            arguments: {
              'nameController': _nameController,
              'emailOrPhoneController': _emailOrPhoneController,
              'authProvider': 'email',
            },
          );
        } else if (state is AuthVerificationSMSForRegistrationSent) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.verification,
            (Route<dynamic> route) => false,
            arguments: {
              'nameController': _nameController,
              'emailOrPhoneController': _emailOrPhoneController,
              'authProvider': 'phone',
            },
          );
        } else if (state is AuthGoogleSignUpSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.setLocation,
            (Route<dynamic> route) => false,
            arguments: {'previousCity': state.user.address?.city},
          );
        } else if (state is AuthFacebookSignUpSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.setLocation,
            (Route<dynamic> route) => false,
            arguments: {'previousCity': state.user.address?.city},
          );
        } else if (state is AuthVerificationEmailRequestFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Verification Email Request Failed!",
            ),
          );
        } else if (state is AuthVerificationEmailSentFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to send verification email!",
            ),
          );
        } else if (state is AuthEmailVerificationFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Email Verification Failed!",
            ),
          );
        } else if (state is AuthVerificationSMSForRegistrationSentFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to send verification SMS!",
            ),
          );
        } else if (state is AuthPhoneVerificationForRegistrationFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to verify phone number!",
            ),
          );
        } else if (state is AuthGoogleSignUpFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to sign up with google!",
            ),
          );
        } else if (state is AuthFacebookSignUpFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to sign up with facebook!",
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 82.h),
                  Center(child: Image.asset(kLogo, width: 90.w, height: 90.h)),
                  Text(
                    "Foody Licious",
                    style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Deliever Favorite Food",
                    style: GoogleFonts.lato(
                      color: kTextRedDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    "Sign Up Here For Your\nAdmin Dashboard",
                    style: GoogleFonts.lato(
                      color: kTextRedDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  InputTextFormField(
                    textController: _nameController,
                    labelText: "Name of Owner",
                    hintText: "Enter your full name",
                    prefixIconData: Icons.person_2_outlined,
                    keyboardType: TextInputType.name,
                    validatorText: "Please enter your name",
                  ),
                  SizedBox(height: 12.h),
                  InputTextFormField(
                    textController: _emailOrPhoneController,
                    labelText: "Email or Phone Number",
                    hintText: "Enter email or phone Number",
                    prefixIconData: Icons.mail_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validatorText:
                        "Please enter your valid email or phone Number",
                  ),
                  SizedBox(height: 12.h),
                  InputTextFormField(
                    textController: _passwordController,
                    labelText: "Password",
                    hintText: "Enter password",
                    prefixIconData: Icons.lock_outline,
                    keyboardType: TextInputType.text,
                    validatorText: "Please set your Password",
                    obscureText: true,
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    "Or",
                    style: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    "Sign Up With",
                    style: GoogleFonts.yeonSung(
                      color: kTextPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialAuthButton(
                        authProviderName: "Facebook",
                        authProviderlogoImagePath: kFacebookIcon,
                        onTap: () {
                          context.read<AuthBloc>().add(
                            AuthSignUpWithFacebook(),
                          );
                        },
                      ),
                      SocialAuthButton(
                        authProviderName: "Google",
                        authProviderlogoImagePath: kGoogleIcon,
                        onTap: () {
                          context.read<AuthBloc>().add(AuthSignUpWithGoogle());
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return GradientButton(
                        buttonText: "Create Account",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _onSignUp(context, _formKey, state);
                          }
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.login,
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Already Have An Account?",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUp(
    BuildContext context,
    GlobalKey<FormState> key,
    AuthState state,
  ) {
    if (key.currentState!.validate()) {
      final emailOrPhone = _emailOrPhoneController.text.toLowerCase().trim();
      bool isEmail = false;
      bool isPhone = false;

      if (state is InputValidationState) {
        isEmail = state.isEmail;
        isPhone = state.isPhone;
      }

      if (isEmail) {
        context.read<AuthBloc>().add(
          AuthSignUpWithEmail(
            SignUpWithEmailParams(
              ownerName: _nameController.text.trim(),
              email: emailOrPhone,
              password: _passwordController.text,
              authProvider: "email",
            ),
          ),
        );
      } else if (isPhone) {
        context.read<AuthBloc>().add(
          AuthVerifyPhoneNumberForRegistration(
            SignUpWithPhoneParams(
              ownerName: _nameController.text.trim(),
              phone: emailOrPhone,
              authProvider: "phone",
            ),
          ),
        );
      }
    }
  }
}
