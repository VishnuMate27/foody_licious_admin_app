import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
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

//params
//User
var tUpdateRestaurantParams = UpdateRestaurantParams(
  id: "RcrNpesIeKSd3afH67ndyDLUaMJ3",
  name: "Test Name",
  phone: "+919876543210",
);

var tUploadRestaurantProfilePictureParams =
    UploadRestaurantProfilePictureParams(
      restaurantId: "RcrNpesIeKSd3afH67ndyDLUaMJ3",
      imageFilePath: "sample_path",
    );
