import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/address/domain/models/zone_model.dart';
import 'package:sixam_mart_delivery/features/address/domain/repositories/address_repository_interface.dart';
import 'package:sixam_mart_delivery/features/address/domain/services/address_service_interface.dart';

class AddressService implements AddressServiceInterface {
  final AddressRepositoryInterface addressRepositoryInterface;
  AddressService({required this.addressRepositoryInterface});

  @override
  Future<List<ZoneModel>?> getZoneList() async {
    return await addressRepositoryInterface.getList();
  }

  @override
  Future<Response> getZone(String lat, String lng) async {
    return await addressRepositoryInterface.getZone(lat, lng);
  }

  @override
  String? getUserAddress() {
    return addressRepositoryInterface.getUserAddress();
  }

  @override
  Future<bool> saveUserAddress(String address, List<int>? zoneIDs) async {
    return await addressRepositoryInterface.saveUserAddress(address, zoneIDs);
  }

  @override
  int? setSelectedZoneIndex(List<int>? zoneIds, int? selectedZoneIndex, List<ZoneModel>? zoneList) {
    int? zoneIndex = selectedZoneIndex;
      for(int index = 0; index < zoneList!.length; index++) {
        if(zoneIds!.contains(zoneList[index].id)) {
          zoneIndex = index;
          break;
        }
      }
    return zoneIndex;
  }

}