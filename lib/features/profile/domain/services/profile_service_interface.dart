import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/address/domain/models/record_location_body_model.dart';
import 'package:sixam_mart_delivery/features/profile/domain/models/profile_model.dart';

abstract class ProfileServiceInterface {
  Future<ProfileModel?> getProfileInfo();
  Future<ResponseModel> updateProfile(ProfileModel userInfoModel, XFile? data, String token);
  Future<ResponseModel> updateActiveStatus();
  Future<void> recordWebSocketLocation(RecordLocationBodyModel recordLocationBody);
  Future<Response> recordLocation(RecordLocationBodyModel recordLocationBody);
  Future<ResponseModel> deleteDriver();
  void checkPermission(Function callback);
  Future<String> addressPlaceMark(Position locationResult);
}