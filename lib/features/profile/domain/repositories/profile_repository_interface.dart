import 'package:sixam_mart_delivery/interface/repository_interface.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/features/address/domain/models/record_location_body_model.dart';
import 'package:sixam_mart_delivery/features/profile/domain/models/profile_model.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface {
  Future<dynamic> getProfileInfo();
  Future<dynamic> updateProfile(ProfileModel userInfoModel, XFile? data, String token);
  Future<dynamic> updateActiveStatus();
  Future<void> recordWebSocketLocation(RecordLocationBodyModel recordLocationBody);
  Future<dynamic> recordLocation(RecordLocationBodyModel recordLocationBody);
  Future<dynamic> deleteDriver();
}