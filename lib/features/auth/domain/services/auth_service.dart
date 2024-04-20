import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/delivery_man_body_model.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/vehicle_model.dart';
import 'package:sixam_mart_delivery/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:sixam_mart_delivery/features/auth/domain/services/auth_service_interface.dart';

class AuthService implements AuthServiceInterface {
  final AuthRepositoryInterface authRepositoryInterface;
  AuthService({required this.authRepositoryInterface});

  @override
  Future<Response> login(String phone, String password) async {
    return await authRepositoryInterface.login(phone, password);
  }

  @override
  Future<bool> registerDeliveryMan(DeliveryManBodyModel deliveryManBody, List<MultipartBody> multiParts) async {
    return await authRepositoryInterface.registerDeliveryMan(deliveryManBody, multiParts);
  }

  @override
  Future<List<VehicleModel>?> getVehicleList() async {
    return await authRepositoryInterface.getList();
  }

  @override
  Future<Response> updateToken() async {
    return await authRepositoryInterface.updateToken();
  }

  @override
  Future<bool> saveUserToken(String token, String zoneTopic) async {
    return await authRepositoryInterface.saveUserToken(token, zoneTopic);
  }

  @override
  String getUserToken() {
    return authRepositoryInterface.getUserToken();
  }

  @override
  bool isLoggedIn() {
    return authRepositoryInterface.isLoggedIn();
  }

  @override
  Future<bool> clearSharedData() async {
    return await authRepositoryInterface.clearSharedData();
  }

  @override
  Future<void> saveUserNumberAndPassword(String number, String password, String countryCode) async {
    await authRepositoryInterface.saveUserNumberAndPassword(number, password, countryCode);
  }

  @override
  String getUserNumber() {
    return authRepositoryInterface.getUserNumber();
  }

  @override
  String getUserCountryCode() {
    return authRepositoryInterface.getUserCountryCode();
  }

  @override
  String getUserPassword() {
    return authRepositoryInterface.getUserPassword();
  }

  @override
  bool isNotificationActive() {
    return authRepositoryInterface.isNotificationActive();
  }

  @override
  void setNotificationActive(bool isActive) {
    authRepositoryInterface.setNotificationActive(isActive);
  }

  @override
  Future<bool> clearUserNumberAndPassword() async {
    return await authRepositoryInterface.clearUserNumberAndPassword();
  }

  @override
  List<MultipartBody> prepareMultiPartsBody(XFile? pickedImage, List<XFile> pickedIdentities) {
    List<MultipartBody> multiParts = [];
    multiParts.add(MultipartBody('image', pickedImage));
    for(XFile file in pickedIdentities) {
      multiParts.add(MultipartBody('identity_image[]', file));
    }
    return multiParts;
  }
  @override
  List<int?> vehicleIds (List<VehicleModel>? vehicles) {
    List<int?>? vehicleIds = [];
    vehicleIds.add(0);
    for(VehicleModel vehicle in vehicles!) {
      vehicleIds.add(vehicle.id);
    }
    return vehicleIds;
  }

  @override
  Future<XFile?> pickImageFromGallery() async{
    XFile? pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickImage != null) {
      pickImage.length().then((value) {
        if (value > 2000000) {
          showCustomSnackBar('please_upload_lower_size_file'.tr);
        } else {
          return pickImage;
        }
      });
    }
    return pickImage;
  }

}