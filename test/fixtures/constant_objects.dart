import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/update_restaurant_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/restaurant/upload_restaurant_profile_picture_usecase.dart';

const tRestaurantModel = RestaurantModel(
  id: 'foody_licious_admin_001',
  ownerName: "",
  name: 'Foody Licious Admin App',
  email: 'test@gmail.com',
  phone: '+919876543210',
  authProvider: 'email',
  address: AddressModel(
    addressText: "Abc Address",
    city: "Delhi",
    coordinates: CoordinatesModel(type: "Point", coordinates: [78.087, 87.098]),
  ),
  description: "description",
  photoUrl: "photoUrl",
  menuItems: [],
);

const tRestaurantResponseModel = RestaurantResponseModel(restaurant: tRestaurantModel);

//params
//User
var tUploadRestaurantProfilePictureParams = UploadRestaurantProfilePictureParams(
  imageFilePath: "path/to/image/file.jpg"
);

var tUpdateRestaurantParams = UpdateRestaurantParams(
  id: "RcrNpesIeKSd3afH67ndyDLUaMJ3",
  name: "Test Name",
  phone: "+919876543210",
);

//Auth
var tSignInWithEmailParams = SignInWithEmailParams(
    email: "test@gmail.com", password: "testPassword", authProvider: "email");
var tSignInWithPhoneParams = SignInWithPhoneParams(
    phone: "+9198796543210", code: "1234", authProvider: "phone");
var tSendPasswordResetEmailParams =
    SendPasswordResetEmailParams(email: "test@gmail.com");
var tSignUpWithEmailParams = SignUpWithEmailParams(
    ownerName: "Test User",
    email: "test@gmail.com",
    password: "testPassword",
    authProvider: "email");
var tSignUpWithPhoneParams = SignUpWithPhoneParams(
    ownerName: "Test User",
    phone: "+9198796543210",
    code: "1234",
    authProvider: "phone");
