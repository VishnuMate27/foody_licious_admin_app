import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious_admin_app/core/constants/colors.dart';
import 'package:foody_licious_admin_app/core/constants/images.dart';
import 'package:foody_licious_admin_app/core/error/failures.dart';
import 'package:foody_licious_admin_app/core/extension/failure_extension.dart';
import 'package:foody_licious_admin_app/core/router/app_router.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';
import 'package:foody_licious_admin_app/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'package:foody_licious_admin_app/presentation/widgets/gradient_button.dart';
import 'package:foody_licious_admin_app/presentation/widgets/image_upload_field.dart';
import 'package:foody_licious_admin_app/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious_admin_app/utils/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SetLocationView extends StatefulWidget {
  final String? previousCity;
  const SetLocationView({this.previousCity, super.key});

  @override
  State<SetLocationView> createState() => _SetLocationViewState();
}

class _SetLocationViewState extends State<SetLocationView>
    with WidgetsBindingObserver {
  late String dropdownValue;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _restaurantNameController =
      TextEditingController();
  final TextEditingController _restaurantEmailController =
      TextEditingController();
  final TextEditingController _restaurantPhoneController =
      TextEditingController(text: "+91");
  final TextEditingController _restaurantDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<RestaurantBloc>().add(CheckRestaurant());
    context.read<RestaurantBloc>().add(UpdateRestaurantLocation());
    dropdownValue = widget.previousCity ?? availableCitiesList.first;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<RestaurantBloc>().add(UpdateRestaurantLocation());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RestaurantBloc, RestaurantState>(
      listener: (BuildContext context, RestaurantState state) async {
        EasyLoading.dismiss();
        if (state is RestaurantLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is RestaurantLocationUpdating) {
          EasyLoading.show(status: 'Fetching Location...');
        } else if (state is RestaurantUpdateLocationFailed) {
          if (state.failure is LocationServicesDisabledFailure) {
            await showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text("Enable Location Services"),
                    content: const Text(
                      "Location services are disabled. Please enable them.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await Geolocator.openLocationSettings();
                        },
                        child: const Text("Open Settings"),
                      ),
                    ],
                  ),
            );
          } else if (state.failure
              is LocationPermissionPermanentlyDeniedFailure) {
            await showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    title: const Text("Permission Required"),
                    content: const Text(
                      "Location permission is permanently denied. Please enable it in app settings.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await openAppSettings();
                        },
                        child: const Text("Open App Settings"),
                      ),
                    ],
                  ),
            );
          } else if (state.failure is LocationPermissionDeniedFailure) {
            EasyLoading.showError("Location Permission Denied!");
          } else {
            EasyLoading.showError(
              state.failure.toMessage(
                defaultMessage: "Failed to fetch Location!",
              ),
            );
          }
        } else if (state is RestaurantUpdateSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.dashboard,
            (Route<dynamic> route) => false,
          );
        } else if (state is RestaurantUpdateFailed) {
          EasyLoading.showError(
            state.failure.toMessage(defaultMessage: "Failed to update city!"),
          );
        }
      },
      buildWhen: (previous, current) {
        // Only rebuild UI when data changes, not during loading or error
        return current is RestaurantAuthenticated ||
            current is RestaurantInitial;
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 64.h),
                    Center(
                      child: Image.asset(kLogo, width: 90.w, height: 90.h),
                    ),
                    Center(
                      child: Text(
                        "Foody Licious",
                        style: GoogleFonts.yeonSung(
                          color: kTextRed,
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Restaurant Details",
                        style: GoogleFonts.lato(
                          color: kTextRedDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (state is RestaurantAuthenticated)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.restaurant.name == "" ||
                              state.restaurant.name == null) ...[
                            Text(
                              "Name of Restaurant",
                              style: GoogleFonts.yeonSung(
                                color: kTextRedDark,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(height: 4.h),
                            InputTextFormField(
                              textController: _restaurantNameController,
                              labelText: "Name of Restaurant",
                              hintText: "Enter Name of Restaurant",
                              prefixIconData: Icons.person_2_outlined,
                              keyboardType: TextInputType.name,
                              validatorText:
                                  "Please enter your Restaurant Name",
                              showlabelTextOnBorder: false,
                            ),
                          ],
                          if (state.restaurant.email == "" ||
                              state.restaurant.email == null) ...[
                            SizedBox(height: 12.h),
                            InputTextFormField(
                              textController: _restaurantEmailController,
                              labelText: "Email",
                              hintText: "Enter email",
                              prefixIconData: Icons.mail_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validatorText: "Please enter your valid email",
                            ),
                          ],
                          if (state.restaurant.phone == "" ||
                              state.restaurant.phone == null) ...[
                            SizedBox(height: 12.h),
                            InputTextFormField(
                              textController: _restaurantPhoneController,
                              labelText: "Phone",
                              hintText: "Enter phone number",
                              prefixIconData: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validatorText:
                                  "Please enter your valid phone number",
                            ),
                          ],
                          if (state.restaurant.description == "" ||
                              state.restaurant.description == null) ...[
                            SizedBox(height: 12.h),
                            InputTextFormField(
                              textController: _restaurantDescriptionController,
                              labelText: "Description",
                              hintText:
                                  "Enter a short description of your restaurant",
                              keyboardType: TextInputType.text,
                              validatorText:
                                  "Please enter valid short description.",
                              maxLength: 500,
                            ),
                          ],
                          Text(
                            "Choose Your Location",
                            style: GoogleFonts.yeonSung(
                              color: kTextRedDark,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: 4.h),
                          DropdownMenu<String>(
                            trailingIcon: Icon(
                              Icons.arrow_circle_down,
                              size: 30,
                              color: kBlack,
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      kBorderLight, // Make the border transparent
                                  width: 1, // Set the border width to 0
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      kBorder, // Transparent border when not focused
                                  width: 1.sp,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      kBorder, // Transparent border when focused
                                  width: 1,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      kError, // Transparent border for error state
                                  width: 1,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color:
                                      kBorder, // Transparent border when disabled
                                  width: 1,
                                ),
                              ),
                            ),
                            initialSelection: availableCitiesList.first,
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            dropdownMenuEntries:
                                availableCitiesList
                                    .map<DropdownMenuEntry<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuEntry<String>(
                                        value: value,
                                        label: value,
                                      );
                                    })
                                    .toList(),
                            expandedInsets: EdgeInsets.zero,
                          ),
                          if (state.restaurant.photoUrl == "" ||
                              state.restaurant.photoUrl == null ||
                              !state.restaurant.photoUrl!.contains(
                                "foodylicious",
                              )) ...[
                            SizedBox(height: 16.h),
                            ImageUploadField(
                              label: "Restaurant Photo",
                              onImageSelected: (file) {
                                context.read<RestaurantBloc>().add(
                                  UploadRestaurantProfilePicture(
                                    UploadRestaurantProfilePictureParams(
                                      imageFilePath: file.path,
                                    ),
                                  ),
                                );
                              },
                              onImageRemoved: () {
                                context.read<RestaurantBloc>().add(
                                  RemoveRestaurantProfilePicture(),
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    SizedBox(height: 12.h),
                    Center(
                      child: GradientButton(
                        buttonText: "Submit",
                        onTap: () {
                          if (state is! RestaurantAuthenticated) {
                            EasyLoading.showError(
                              "Please wait until restaurant data loads!",
                            );
                            return;
                          }

                          final restaurant = state.restaurant;

                          // Perform conditional checks
                          final isRestaurantNameRequired =
                              restaurant.name == null ||
                              restaurant.name!.isEmpty;
                          final isRestaurantDescriptionRequired =
                              restaurant.description == null ||
                              restaurant.description!.isEmpty;
                          final isEmailRequired =
                              restaurant.email == null ||
                              restaurant.email!.isEmpty;
                          final isPhoneRequired =
                              restaurant.phone == null ||
                              restaurant.phone!.isEmpty;

                          // Additional manual checks for required fields
                          if (isRestaurantNameRequired &&
                              _restaurantNameController.text.trim().isEmpty) {
                            EasyLoading.showError(
                              "Restaurant name is required!",
                            );
                            return;
                          }

                          if (isRestaurantDescriptionRequired &&
                              _restaurantDescriptionController.text
                                  .trim()
                                  .isEmpty) {
                            EasyLoading.showError(
                              "Restaurant description is required!",
                            );
                            return;
                          }
                          if (_restaurantEmailController.text.trim().isEmpty &&
                              isEmailRequired) {
                            EasyLoading.showError("Email is required!");
                            return;
                          } else if (!RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              ).hasMatch(
                                _restaurantEmailController.text.trim(),
                              ) &&
                              isEmailRequired) {
                            EasyLoading.showError(
                              "Please enter a valid email!",
                            );
                            return;
                          }

                          final cleanedPhone = _restaurantPhoneController.text
                              .trim()
                              .replaceAll(RegExp(r'[\s\+\-]'), '');

                          if (_restaurantPhoneController.text.trim().isEmpty &&
                              isPhoneRequired) {
                            EasyLoading.showError("Phone is required!");
                            return;
                          } else if (!_restaurantPhoneController.text
                              .trim()
                              .startsWith("+91") && isPhoneRequired) {
                            EasyLoading.showError(
                              "Only Phone number starting from +91 is allowed.",
                            );
                            return;
                          } else if (!RegExp(
                                r'^[0-9]{12}$',
                              ).hasMatch(cleanedPhone) &&
                              isPhoneRequired) {
                            EasyLoading.showError(
                              "Please enter a valid phone number!",
                            );
                            return;
                          }

                          // Form validation
                          if (!_formKey.currentState!.validate()) return;

                          // If all validations pass
                          context.read<RestaurantBloc>().add(
                            UpdateRestaurant(
                              UpdateRestaurantParams(
                                name: _restaurantNameController.text.trim(),
                                description:
                                    _restaurantDescriptionController.text
                                        .trim(),
                                email:
                                    isEmailRequired
                                        ? _restaurantEmailController.text
                                            .toLowerCase()
                                            .trim()
                                        : restaurant.email,
                                phone:
                                    isPhoneRequired
                                        ? _restaurantPhoneController.text.trim()
                                        : restaurant.phone,
                                address: AddressModel(city: dropdownValue),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
