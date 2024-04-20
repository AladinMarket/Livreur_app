import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/address/domain/models/zone_model.dart';

abstract class AddressServiceInterface {
  Future<List<ZoneModel>?> getZoneList();
  Future<Response> getZone(String lat, String lng);
  String? getUserAddress();
  Future<bool> saveUserAddress(String address, List<int>? zoneIDs);
  int? setSelectedZoneIndex(List<int>? zoneIds, int? selectedZoneIndex, List<ZoneModel>? zoneList);
}