import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/delivery_man_body_model.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/vehicle_model.dart';

abstract class AuthServiceInterface {
  Future<Response> login(String phone, String password);
  Future<Response> updateToken();
  Future<bool> saveUserToken(String token, String zoneTopic);
  String getUserToken();
  bool isLoggedIn();
  Future<bool> clearSharedData();
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode);
  String getUserNumber();
  String getUserCountryCode();
  String getUserPassword();
  bool isNotificationActive();
  void setNotificationActive(bool isActive);
  Future<bool> clearUserNumberAndPassword();
  Future<bool> registerDeliveryMan(DeliveryManBodyModel deliveryManBody, List<MultipartBody> multiParts);
  Future<List<VehicleModel>?> getVehicleList();
  List<MultipartBody> prepareMultiPartsBody(XFile? pickedImage, List<XFile> pickedIdentities);
  List<int?> vehicleIds (List<VehicleModel>? vehicles);
  Future<XFile?> pickImageFromGallery();
}