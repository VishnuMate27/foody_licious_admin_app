import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/add_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/decrease_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/delete_menu_item_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/get_all_menu_items_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/increase_item_quantity_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/menuItem/update_menu_item_usecase.dart';
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

const tRestaurantResponseModel = RestaurantResponseModel(
  restaurant: tRestaurantModel,
);

//params
//User
var tUploadRestaurantProfilePictureParams =
    UploadRestaurantProfilePictureParams(
      imageFilePath: "path/to/image/file.jpg",
    );

var tUpdateRestaurantParams = UpdateRestaurantParams(
  id: "RcrNpesIeKSd3afH67ndyDLUaMJ3",
  name: "Test Name",
  phone: "+919876543210",
);

var tAddMenuItemParams = AddMenuItemParams(
  itemId: "10",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 10,
  imageFilePaths: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tUpdateMenuItemParams = UpdateMenuItemParams(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 10,
  images: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tGetAllMenuItemsParams = GetAllMenuItemsParams(
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  page: 1,
  limit: 10,
);

var tDeleteMenuItemsParams = DeleteMenuItemParams(
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
);

var tMenuItemModel = MenuItemModel(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 10,
  images: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tIncreaseItemQuantityParams = IncreaseItemQuantityParams(
  itemId: "6905eb543f1a415430e9f2b3",
);

var tDecreaseItemQuantityParams = DecreaseItemQuantityParams(
  itemId: "6905eb543f1a415430e9f2b3",
);

var tMenuItem = MenuItem(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 10,
  images: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tMenuItemResponseModel = MenuItemResponseModel(
  menuItemResponseModel: tMenuItemModel,
);

var tMenuItemList = [tMenuItem];

var tMenuItemsResponseModel = MenuItemsResponseModel(
  menuItems: [tMenuItemModel],
);
//Auth
var tSignInWithEmailParams = SignInWithEmailParams(
  email: "test@gmail.com",
  password: "testPassword",
  authProvider: "email",
);
var tSignInWithPhoneParams = SignInWithPhoneParams(
  phone: "+9198796543210",
  code: "1234",
  authProvider: "phone",
);
var tSendPasswordResetEmailParams = SendPasswordResetEmailParams(
  email: "test@gmail.com",
);
var tSignUpWithEmailParams = SignUpWithEmailParams(
  ownerName: "Test User",
  email: "test@gmail.com",
  password: "testPassword",
  authProvider: "email",
);
var tSignUpWithPhoneParams = SignUpWithPhoneParams(
  ownerName: "Test User",
  phone: "+9198796543210",
  code: "1234",
  authProvider: "phone",
);
