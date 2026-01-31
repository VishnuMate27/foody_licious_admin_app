import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_item_response_model.dart';
import 'package:foody_licious_admin_app/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious_admin_app/data/models/order/order_menu_item_model.dart';
import 'package:foody_licious_admin_app/data/models/order/order_model.dart';
import 'package:foody_licious_admin_app/data/models/order/order_response_model.dart';
import 'package:foody_licious_admin_app/data/models/order/orders_response_model.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_model.dart';
import 'package:foody_licious_admin_app/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious_admin_app/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious_admin_app/domain/entities/order/order.dart';
import 'package:foody_licious_admin_app/domain/entities/order/orderMenuItem.dart';
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
import 'package:foody_licious_admin_app/domain/usecases/order/get_all_order_usecase.dart';
import 'package:foody_licious_admin_app/domain/usecases/order/update_order_status_usecase.dart';
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
  name: "Test Item Name Edited",
  price: 150,
  description: "Test Description Edited",
  availableQuantity: 10,
  images: [],
  ingredients: ['ingredient1', 'ingredient2', 'ingredient3'],
);

var tGetAllMenuItemsParams = GetAllMenuItemsParams(
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  page: 1,
  limit: 10,
);

var tGetAllMenuItemsParams2 = GetAllMenuItemsParams(
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  page: 2,
  limit: 10,
);

var tDeleteMenuItemsParams = DeleteMenuItemParams(
  itemId: "6905eb543f1a415430e9f2b3",
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

var tUpdatedMenuItem = MenuItem(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name Edited",
  price: 150,
  description: "Test Description Edited",
  availableQuantity: 10,
  images: [],
  ingredients: ['ingredient1', 'ingredient2', 'ingredient3'],
);

var tIncreasedQuantityMenuItem = MenuItem(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 11,
  images: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tDecreasedQuantityMenuItem = MenuItem(
  id: "6905eb543f1a415430e9f2b3",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name",
  price: 150,
  description: "Test Description",
  availableQuantity: 9,
  images: [],
  ingredients: ['ingredient1', 'ingredient2'],
);

var tMenuItem2 = MenuItem(
  id: "6905ec15f3fabd415a4a54db",
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  name: "Test Item Name 2",
  price: 200,
  description: "Test Description 2",
  availableQuantity: 11,
  images: [],
  ingredients: ['ingredient1', 'ingredient2', 'ingredient3'],
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

// Orders
var tOrderMenuItem1 = OrderMenuItem(
  id: '695c03364b2976a391deaa78',
  quantity: 1,
  totalPrice: 80,
  menuItemDetails: tMenuItem,
);

var tOrderMenuItem2 = OrderMenuItem(
  id: '6910bf3bdb83f7f42c810bce',
  quantity: 1,
  totalPrice: 500,
  menuItemDetails: tMenuItem2,
);

var tOrderMenuItemModel = OrderMenuItemModel(
  id: '695c03364b2976a391deaa78',
  quantity: 1,
  totalPrice: 80,
  price: 80,
  availableQuantity: 50,
  menuItemDetails: tMenuItem,
);

var tOrderEntity1 = OrderEntity(
  id: '697de19a572443b4056ffc89',
  restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
  userId: 'qK3kv062JvQ2NOZrRZYhtl8wX7v2',
  status: 'CONFIRMED',
  paymentStatus: 'PENDING',
  items: [tOrderMenuItem1, tOrderMenuItem2],
  name: 'Vishnu Mate',
  address: 'tests update address, Mumbai',
  phone: '9876543210',
  totalCartAmount: 480,
  gstCharges: 24,
  platformFees: 4.8,
  deliveryCharges: 40,
  grandTotalAmount: 548.8,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

var tOrderEntity2 = OrderEntity(
  id: '697de19a572443b4056ffc90',
  restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
  userId: 'qK3kv062JvQ2NOZrRZYhtl8wX7v2',
  status: 'DISPATCHED',
  paymentStatus: 'PENDING',
  items: [tOrderMenuItem1, tOrderMenuItem2],
  name: 'Gopal Mate',
  address: 'tests update address, Pune',
  phone: '9877665544',
  totalCartAmount: 500,
  gstCharges: 25,
  platformFees: 5,
  deliveryCharges: 40,
  grandTotalAmount: 570,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

var tOrderModel1 = OrderModel(
  id: '697de19a572443b4056ffc89',
  restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
  userId: 'qK3kv062JvQ2NOZrRZYhtl8wX7v2',
  status: 'CONFIRMED',
  paymentStatus: 'PENDING',
  items: [tOrderMenuItem1, tOrderMenuItem2],
  name: 'Vishnu Mate',
  address: 'tests update address, Mumbai',
  phone: '9876543210',
  totalCartAmount: 480,
  gstCharges: 24,
  platformFees: 4.8,
  deliveryCharges: 40,
  grandTotalAmount: 548.8,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

var tOrderModel2 = OrderModel(
  id: '697de19a572443b4056ffc90',
  restaurantId: 'pygupNfZONbMeMmBJb2htMxzAR23',
  userId: 'qK3kv062JvQ2NOZrRZYhtl8wX7v2',
  status: 'DISPATCHED',
  paymentStatus: 'PENDING',
  items: [tOrderMenuItem1, tOrderMenuItem2],
  name: 'Gopal Mate',
  address: 'tests update address, Pune',
  phone: '9877665544',
  totalCartAmount: 500,
  gstCharges: 25,
  platformFees: 5,
  deliveryCharges: 40,
  grandTotalAmount: 570,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

var orderEntityList = [tOrderEntity1, tOrderEntity2];

var tGetAllOrdersParams = GetAllOrdersParams(
  restaurantId: "pygupNfZONbMeMmBJb2htMxzAR23",
  page: 1,
  limit: 1,
  statuses: [OrderStatus.CONFIRMED.name, OrderStatus.PREPARING.name],
);

var tUpdateOrderStatusParams = UpdateOrderStatusParams(
  orderId: "697de19a572443b4056ffc89",
  status: "CONFIRMED",
);

var tOrdersResponseModel = OrdersResponseModel(
  orders: [tOrderModel1, tOrderModel2],
);

var tOrderResponseModel = OrderResponseModel(orderResponseModel: tOrderModel1);
