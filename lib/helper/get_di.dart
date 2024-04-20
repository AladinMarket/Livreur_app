import 'dart:convert';
import 'package:sixam_mart_delivery/common/controllers/theme_controller.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/features/address/controllers/address_controller.dart';
import 'package:sixam_mart_delivery/features/address/domain/repositories/address_repository.dart';
import 'package:sixam_mart_delivery/features/address/domain/repositories/address_repository_interface.dart';
import 'package:sixam_mart_delivery/features/address/domain/services/address_service.dart';
import 'package:sixam_mart_delivery/features/address/domain/services/address_service_interface.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/auth/domain/repositories/auth_repository.dart';
import 'package:sixam_mart_delivery/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:sixam_mart_delivery/features/auth/domain/services/auth_service.dart';
import 'package:sixam_mart_delivery/features/auth/domain/services/auth_service_interface.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/repositories/cash_in_hand_repository.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/repositories/cash_in_hand_repository_interface.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/services/cash_in_hand_service.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/services/cash_in_hand_service_interface.dart';
import 'package:sixam_mart_delivery/features/chat/controllers/chat_controller.dart';
import 'package:sixam_mart_delivery/features/chat/domain/repositories/chat_repository.dart';
import 'package:sixam_mart_delivery/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:sixam_mart_delivery/features/chat/domain/services/chat_service.dart';
import 'package:sixam_mart_delivery/features/chat/domain/services/chat_service_interface.dart';
import 'package:sixam_mart_delivery/features/disbursement/controllers/disbursement_controller.dart';
import 'package:sixam_mart_delivery/features/disbursement/domain/repositories/disbursement_repository.dart';
import 'package:sixam_mart_delivery/features/disbursement/domain/repositories/disbursement_repository_interface.dart';
import 'package:sixam_mart_delivery/features/disbursement/domain/services/disbursement_service.dart';
import 'package:sixam_mart_delivery/features/disbursement/domain/services/disbursement_service_interface.dart';
import 'package:sixam_mart_delivery/features/forgot_password/controllers/forgot_password_controller.dart';
import 'package:sixam_mart_delivery/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:sixam_mart_delivery/features/forgot_password/domain/repositories/forgot_password_repository_interface.dart';
import 'package:sixam_mart_delivery/features/forgot_password/domain/services/forgot_password_service.dart';
import 'package:sixam_mart_delivery/features/forgot_password/domain/services/forgot_password_service_interface.dart';
import 'package:sixam_mart_delivery/features/html/controllers/html_controller.dart';
import 'package:sixam_mart_delivery/features/html/domain/repositories/html_repository.dart';
import 'package:sixam_mart_delivery/features/html/domain/repositories/html_repository_interface.dart';
import 'package:sixam_mart_delivery/features/html/domain/services/html_service.dart';
import 'package:sixam_mart_delivery/features/html/domain/services/html_service_interface.dart';
import 'package:sixam_mart_delivery/features/language/controllers/language_controller.dart';
import 'package:sixam_mart_delivery/features/language/domain/repositories/language_repository.dart';
import 'package:sixam_mart_delivery/features/language/domain/repositories/language_repository_interface.dart';
import 'package:sixam_mart_delivery/features/language/domain/services/language_service.dart';
import 'package:sixam_mart_delivery/features/language/domain/services/language_service_interface.dart';
import 'package:sixam_mart_delivery/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart_delivery/features/notification/domain/repositories/notification_repository.dart';
import 'package:sixam_mart_delivery/features/notification/domain/repositories/notification_repository_interface.dart';
import 'package:sixam_mart_delivery/features/notification/domain/services/notification_service.dart';
import 'package:sixam_mart_delivery/features/notification/domain/services/notification_service_interface.dart';
import 'package:sixam_mart_delivery/features/order/controllers/order_controller.dart';
import 'package:sixam_mart_delivery/features/order/domain/repositories/order_repository.dart';
import 'package:sixam_mart_delivery/features/order/domain/repositories/order_repository_interface.dart';
import 'package:sixam_mart_delivery/features/order/domain/services/order_service.dart';
import 'package:sixam_mart_delivery/features/order/domain/services/order_service_interface.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart_delivery/features/profile/domain/repositories/profile_repository.dart';
import 'package:sixam_mart_delivery/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:sixam_mart_delivery/features/profile/domain/services/profile_service.dart';
import 'package:sixam_mart_delivery/features/profile/domain/services/profile_service_interface.dart';
import 'package:sixam_mart_delivery/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart_delivery/features/splash/domain/repositories/splash_repository.dart';
import 'package:sixam_mart_delivery/features/splash/domain/repositories/splash_repository_interface.dart';
import 'package:sixam_mart_delivery/features/splash/domain/services/splash_service.dart';
import 'package:sixam_mart_delivery/features/splash/domain/services/splash_service_interface.dart';
import 'package:sixam_mart_delivery/util/app_constants.dart';
import 'package:sixam_mart_delivery/features/language/domain/models/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {

  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  /// Repository
  //Get.lazyPut(() => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  //Get.lazyPut(() => LanguageRepo());
 // Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Get.lazyPut(() => OrderRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Get.lazyPut(() => NotificationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Get.lazyPut(() => ChatRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  //Get.lazyPut(() => DisbursementRepo(apiClient: Get.find()));

  /// Controller
  // Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  //Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  //Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  //Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  //Get.lazyPut(() => AuthController(authRepo: Get.find()));
  //Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  //Get.lazyPut(() => NotificationController(notificationRepo: Get.find()));
  //Get.lazyPut(() => ChatController(chatRepo: Get.find()));
  //Get.lazyPut(() => DisbursementController(disbursementRepo: Get.find()));

  /// Repository Interface
  HtmlRepositoryInterface htmlRepositoryInterface = HtmlRepository(apiClient: Get.find());
  Get.lazyPut(() => htmlRepositoryInterface);

  DisbursementRepositoryInterface disbursementRepositoryInterface = DisbursementRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => disbursementRepositoryInterface);

  CashInHandRepositoryInterface cashInHandRepositoryInterface = CashInHandRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => cashInHandRepositoryInterface);

  ForgotPasswordRepositoryInterface forgotPasswordRepositoryInterface = ForgotPasswordRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => forgotPasswordRepositoryInterface);

  ChatRepositoryInterface chatRepositoryInterface = ChatRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => chatRepositoryInterface);

  LanguageRepositoryInterface languageRepositoryInterface = LanguageRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => languageRepositoryInterface);

  SplashRepositoryInterface splashRepositoryInterface = SplashRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => splashRepositoryInterface);

  NotificationRepositoryInterface notificationRepositoryInterface = NotificationRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => notificationRepositoryInterface);

  ProfileRepositoryInterface profileRepositoryInterface = ProfileRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => profileRepositoryInterface);

  AddressRepositoryInterface addressRepositoryInterface = AddressRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => addressRepositoryInterface);

  AuthRepositoryInterface authRepositoryInterface = AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => authRepositoryInterface);

  OrderRepositoryInterface orderRepositoryInterface = OrderRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => orderRepositoryInterface);

  /// Service Interface
  HtmlServiceInterface htmlServiceInterface = HtmlService(htmlRepositoryInterface: Get.find());
  Get.lazyPut(() => htmlServiceInterface);

  DisbursementServiceInterface disbursementServiceInterface = DisbursementService(disbursementRepositoryInterface: Get.find());
  Get.lazyPut(() => disbursementServiceInterface);

  CashInHandServiceInterface cashInHandServiceInterface = CashInHandService(cashInHandRepositoryInterface: Get.find());
  Get.lazyPut(() => cashInHandServiceInterface);

  ForgotPasswordServiceInterface forgotPasswordServiceInterface = ForgotPasswordService(forgotPasswordRepositoryInterface: Get.find());
  Get.lazyPut(() => forgotPasswordServiceInterface);

  ChatServiceInterface chatServiceInterface = ChatService(chatRepositoryInterface: Get.find());
  Get.lazyPut(() => chatServiceInterface);

  LanguageServiceInterface languageServiceInterface = LanguageService(languageRepositoryInterface: Get.find());
  Get.lazyPut(() => languageServiceInterface);

  SplashServiceInterface splashServiceInterface = SplashService(splashRepositoryInterface: Get.find());
  Get.lazyPut(() => splashServiceInterface);

  NotificationServiceInterface notificationServiceInterface = NotificationService(notificationRepositoryInterface: Get.find());
  Get.lazyPut(() => notificationServiceInterface);

  ProfileServiceInterface profileServiceInterface = ProfileService(profileRepositoryInterface: Get.find());
  Get.lazyPut(() => profileServiceInterface);

  AddressServiceInterface addressServiceInterface = AddressService(addressRepositoryInterface: Get.find());
  Get.lazyPut(() => addressServiceInterface);

  AuthServiceInterface authServiceInterface = AuthService(authRepositoryInterface: Get.find());
  Get.lazyPut(() => authServiceInterface);

  OrderServiceInterface orderServiceInterface = OrderService(orderRepositoryInterface: Get.find());
  Get.lazyPut(() => orderServiceInterface);

  /// Service
  Get.lazyPut(() => HtmlService(htmlRepositoryInterface: Get.find()));
  Get.lazyPut(() => DisbursementService(disbursementRepositoryInterface: Get.find()));
  Get.lazyPut(() => CashInHandService(cashInHandRepositoryInterface: Get.find()));
  Get.lazyPut(() => ForgotPasswordService(forgotPasswordRepositoryInterface: Get.find()));
  Get.lazyPut(() => ChatService(chatRepositoryInterface: Get.find()));
  Get.lazyPut(() => LanguageService(languageRepositoryInterface: Get.find()));
  Get.lazyPut(() => SplashService(splashRepositoryInterface: Get.find()));
  Get.lazyPut(() => NotificationService(notificationRepositoryInterface: Get.find()));
  Get.lazyPut(() => ProfileService(profileRepositoryInterface: Get.find()));
  Get.lazyPut(() => AddressService(addressRepositoryInterface: Get.find()));
  Get.lazyPut(() => AuthService(authRepositoryInterface: Get.find()));
  Get.lazyPut(() => OrderService(orderRepositoryInterface: Get.find()));

  /// Controller
  Get.lazyPut(() => HtmlController(htmlServiceInterface: Get.find()));
  Get.lazyPut(() => DisbursementController(disbursementServiceInterface: Get.find()));
  Get.lazyPut(() => CashInHandController(cashInHandServiceInterface: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => ForgotPasswordController(forgotPasswordServiceInterface: Get.find()));
  Get.lazyPut(() => ChatController(chatServiceInterface: Get.find()));
  Get.lazyPut(() => LocalizationController(languageServiceInterface: Get.find()));
  Get.lazyPut(() => SplashController(splashServiceInterface: Get.find()));
  Get.lazyPut(() => NotificationController(notificationServiceInterface: Get.find()));
  Get.lazyPut(() => ProfileController(profileServiceInterface: Get.find()));
  Get.lazyPut(() => AddressController(addressServiceInterface: Get.find()));
  Get.lazyPut(() => AuthController(authServiceInterface: Get.find()));
  Get.lazyPut(() => OrderController(orderServiceInterface: Get.find()));

  /// Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
