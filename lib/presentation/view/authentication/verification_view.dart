import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/core/extension/failure_extension.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/auth/auth_bloc.dart';
// import 'package:foody_licious/core/constant/colors.dart';
// import 'package:foody_licious/core/constant/images.dart';
// import 'package:foody_licious/core/extension/failure_extension.dart';
// import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious_admin_app/core/utils/sms_retriever.dart';
import 'package:foody_licious_admin_app/presentation/widgets/alerts.dart';
import 'package:foody_licious_admin_app/presentation/widgets/bouncy_icon.dart';
import 'package:foody_licious_admin_app/presentation/widgets/countdown.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
// import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
// import 'package:foody_licious/domain/usecase/auth/sign_up_with_phone_usecase.dart';
// import 'package:foody_licious/presentation/widgets/alerts.dart';
// import 'package:foody_licious/presentation/widgets/bouncy_icon.dart';
// import 'package:foody_licious/presentation/widgets/countdown.dart';
// import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:open_mail_app_plus/open_mail_app_plus.dart';

class VerificationView extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailOrPhoneController;
  final String? authProvider;
  const VerificationView({
    super.key,
    this.nameController,
    this.emailOrPhoneController,
    this.authProvider,
  });

  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  final smartAuth = SmartAuth.instance;
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  AuthState? _currentState;
  bool _checking = false;
  AnimationController? _controller;
  int otpTimer = 30;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: otpTimer),
    );
    _controller!.forward();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(smartAuth);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    pinController.dispose();
    focusNode.dispose();
    _controller!.dispose();
    super.dispose();
  }

  // Future<void> _startVerificationCheck() async {
  //   if (_checking) return;
  //   _checking = true;
  //   try {
  //     context.read<AuthBloc>().add(WaitForEmailVerificationAuth());
  //     if (mounted) {
  //       // directly navigate if you don't want to use bloc
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         AppRouter.setLocation,
  //         (Route<dynamic> route) => false,
  //       );
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Error: $e")),
  //       );
  //     }
  //   } finally {
  //     _checking = false;
  //   }
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        (_currentState is AuthVerificationEmailSent ||
            _currentState is AuthEmailVerificationFailed)) {
      context.read<AuthBloc>().add(AuthWaitForEmailVerification());
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: kTextSecondary),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: kBorder),
      ),
    );
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        _currentState = state;
        if (state is AuthLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is AuthPhoneVerificationForRegistrationSuccess) {
          EasyLoading.dismiss();

          // Add a small delay to ensure loading is dismissed
          await Future.delayed(Duration(milliseconds: 10));

          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.setLocation,
              (Route<dynamic> route) => false,
            );
          }
        } else if (state is AuthPhoneVerificationForLoginSuccess) {
          EasyLoading.dismiss();
          await Future.delayed(Duration(milliseconds: 10));
          if (mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.setLocation,
              (Route<dynamic> route) => false,
              arguments: {'previousCity': state.user.address?.city},
            );
          }
        } else if (state is AuthPhoneVerificationForLoginFailed) {
          EasyLoading.dismiss();
          await Future.delayed(Duration(milliseconds: 10));
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to verify phone number!",
            ),
          );
        } else if (state is AuthEmailVerificationFailed) {
          EasyLoading.dismiss();
          await Future.delayed(Duration(milliseconds: 10));
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Email Verification Failed!",
            ),
            duration: const Duration(seconds: 3),
          );
        } else if (state is AuthPhoneVerificationForRegistrationFailed) {
          EasyLoading.dismiss();
          await Future.delayed(Duration(milliseconds: 10));
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to verify phone number!",
            ),
          );
        } else {
          EasyLoading.dismiss();
        }
      },
      buildWhen: (previous, current) {
        if (current is AuthLoading ||
            current is AuthPhoneVerificationForLoginSuccess ||
            current is AuthPhoneVerificationForRegistrationSuccess ||
            current is AuthPhoneVerificationForLoginFailed ||
            current is AuthPhoneVerificationForRegistrationFailed) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        _currentState = state;
        if (state is AuthVerificationEmailSent ||
            state is AuthEmailVerificationFailed) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 82.h),
                    Center(
                      child: Image.asset(kLogo, width: 90.w, height: 90.h),
                    ),
                    Text(
                      "Foody Licious",
                      style: GoogleFonts.yeonSung(
                        color: kTextRed,
                        fontSize: 40,
                      ),
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
                      "Email Verification",
                      style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BouncyIcon(
                      icon: Icons.mark_email_read_rounded,
                      size: 50,
                      color: kTextRed,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "We’ve sent you a verification email!",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Please check your inbox and click the link to verify your email address. Once verified, you can start enjoying delicious food with Foodylicious.",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GradientButton(
                            height: 30.h,
                            width: 140.h,
                            buttonText: "Open Mail App",
                            fontSize: 14,
                            onTap: () async {
                              var result = await OpenMailAppPlus.openMailApp(
                                nativePickerTitle: 'Select email app to open',
                              );
                              if (!result.didOpen && !result.canOpen) {
                                showNoMailAppsDialog(context);
                              } else if (!result.didOpen && result.canOpen) {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MailAppPickerDialog(
                                      mailApps: result.options,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          GradientButton(
                            height: 30.h,
                            width: 140.h,
                            buttonText: "Resend Email",
                            fontSize: 14,
                            isActive: state is AuthEmailVerificationFailed,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                AuthSendVerificationEmail(),
                              );
                              context.read<AuthBloc>().add(
                                AuthWaitForEmailVerification(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is AuthEmailVerificationSuccess) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 82.h),
                    Center(
                      child: Image.asset(kLogo, width: 90.w, height: 90.h),
                    ),
                    Text(
                      "Foody Licious",
                      style: GoogleFonts.yeonSung(
                        color: kTextRed,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Deliver Favorite Food",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      "Verification Successful!",
                      style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BouncyIcon(
                      icon: Icons.verified_rounded,
                      size: 60,
                      color: kGreen,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Your email has been verified!",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Welcome to Foodylicious Admin 🎉 You’re now ready to deliver excellence — manage, monitor, and make customers happy!",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(seconds: 10),
                      onEnd: () {
                        // Auto continue after 5 seconds
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRouter.setLocation,
                          (Route<dynamic> route) => false,
                        );
                      },
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRouter.setLocation,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            height: 45.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [kTextRed, kTextRedDark],
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Positioned.fill(
                                  child: LinearProgressIndicator(
                                    value: value,
                                    backgroundColor: Colors.transparent,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      kBackground.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Continue",
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is AuthVerificationSMSForRegistrationSent ||
            state is AuthVerificationSMSForLoginSent) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 82.h),
                      Center(
                        child: Image.asset(kLogo, width: 90.w, height: 90.h),
                      ),
                      Text(
                        "Foody Licious",
                        style: GoogleFonts.yeonSung(
                          color: kTextRed,
                          fontSize: 40,
                        ),
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
                        "OTP Verification",
                        style: GoogleFonts.yeonSung(
                          color: kTextRedDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Enter the code sent to the",
                        style: GoogleFonts.lato(
                          color: kTextRedDark,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        widget.emailOrPhoneController != null
                            ? widget.emailOrPhoneController!.value.text
                            : "",
                        style: GoogleFonts.lato(
                          color: kTextRedDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Pinput(
                            smsRetriever: smsRetriever,
                            controller: pinController,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder:
                                (index) => const SizedBox(width: 8),
                            validator: (value) {
                              // return value!.length != 4 ? null : 'Pin is incomplete!';
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: kBorder,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kBorder),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(color: kBorder),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: kError),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Countdown(
                            animation: StepTween(
                              begin: otpTimer, // THIS IS A USER ENTERED NUMBER
                              end: 0,
                            ).animate(_controller!),
                            onResendOTPTapped: () {
                              if (state
                                  is AuthVerificationSMSForRegistrationSent) {
                                context.read<AuthBloc>().add(
                                  AuthVerifyPhoneNumberForRegistration(
                                    SignUpWithPhoneParams(
                                      ownerName:
                                          widget.nameController!.text.trim(),
                                      phone:
                                          widget.emailOrPhoneController!.text
                                              .trim(),
                                      authProvider: "phone",
                                    ),
                                  ),
                                );
                              } else {
                                context.read<AuthBloc>().add(
                                  AuthVerifyPhoneNumberForLogin(
                                    SignInWithPhoneParams(
                                      phone:
                                          widget.emailOrPhoneController!.text
                                              .trim(),
                                      authProvider: "phone",
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      GradientButton(
                        buttonText: "Verify",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            _onVerify(context, formKey, state);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is AuthVerificationEmailSentFailed) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(height: 82.h),
                    Center(
                      child: Image.asset(kLogo, width: 90.w, height: 90.h),
                    ),
                    Text(
                      "Foody Licious",
                      style: GoogleFonts.yeonSung(
                        color: kTextRed,
                        fontSize: 40,
                      ),
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
                      "Email Verification",
                      style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    BouncyIcon(
                      icon: Icons.mark_email_read_rounded,
                      size: 50,
                      color: kTextRed,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "We’ve already sent you a verification email!",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Please check your inbox, spam/promotional section and click the link to verify your email address. Once verified, you can start enjoying delicious food with Foodylicious.",
                      style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GradientButton(
                            height: 30.h,
                            width: 140.h,
                            buttonText: "Open Mail App",
                            fontSize: 14,
                            onTap: () async {
                              var result = await OpenMailAppPlus.openMailApp(
                                nativePickerTitle: 'Select email app to open',
                              );
                              if (!result.didOpen && !result.canOpen) {
                                showNoMailAppsDialog(context);
                              } else if (!result.didOpen && result.canOpen) {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MailAppPickerDialog(
                                      mailApps: result.options,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          GradientButton(
                            height: 30.h,
                            width: 140.h,
                            buttonText: "Resend Email",
                            fontSize: 14,
                            isActive: false,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                AuthSendVerificationEmail(),
                              );
                              context.read<AuthBloc>().add(
                                AuthWaitForEmailVerification(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Text(
              "State is $state",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }

  _onVerify(
    BuildContext context,
    GlobalKey<FormState> key,
    AuthState state,
  ) async {
    if (key.currentState!.validate()) {
      final verificationCode = pinController.text.trim();
      if (state is AuthVerificationSMSForRegistrationSent) {
        context.read<AuthBloc>().add(
          AuthSignUpWithPhone(
            SignUpWithPhoneParams(
              ownerName: widget.nameController!.text,
              phone: widget.emailOrPhoneController!.text,
              code: verificationCode,
              authProvider: widget.authProvider!,
            ),
          ),
        );
      } else if (state is AuthVerificationSMSForLoginSent) {
        context.read<AuthBloc>().add(
          AuthSignInWithPhone(
            SignInWithPhoneParams(
              phone: widget.emailOrPhoneController!.text,
              code: verificationCode,
              authProvider: widget.authProvider!,
            ),
          ),
        );
      }
    }
  }
}
