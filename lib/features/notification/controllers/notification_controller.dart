import 'package:sixam_mart_delivery/features/notification/domain/models/notification_model.dart';
import 'package:sixam_mart_delivery/helper/date_converter_helper.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/notification/domain/services/notification_service_interface.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationServiceInterface notificationServiceInterface;
  NotificationController({required this.notificationServiceInterface});

  List<NotificationModel>? _notificationList;
  List<NotificationModel>? get notificationList => _notificationList;

  bool _hasNotification = false;
  bool get hasNotification => _hasNotification;

  bool _hideNotificationButton = false;
  bool get hideNotificationButton => _hideNotificationButton;

  Future<void> getNotificationList() async {
    List<NotificationModel>? notificationList = await notificationServiceInterface.getNotificationList();
    if (notificationList != null) {
      _notificationList = [];
      _notificationList!.addAll(notificationList);
      _notificationList!.sort((a, b) {
        return DateConverterHelper.isoStringToLocalDate(a.updatedAt!).compareTo(DateConverterHelper.isoStringToLocalDate(b.updatedAt!));
      });
      Iterable iterable = _notificationList!.reversed;
      _notificationList = iterable.toList() as List<NotificationModel>?;
      _hasNotification = _notificationList!.length != getSeenNotificationCount();
    }
    update();
  }

  Future<bool> sendDeliveredNotification(int? orderID) async {
    _hideNotificationButton = true;
    update();
    bool isSuccess = await notificationServiceInterface.sendDeliveredNotification(orderID);
    bool success;
    isSuccess ? success = true : success = false;
    _hideNotificationButton = false;
    update();
    return success;
  }

  void saveSeenNotificationCount(int count) {
    notificationServiceInterface.saveSeenNotificationCount(count);
  }

  int? getSeenNotificationCount() {
    return notificationServiceInterface.getSeenNotificationCount();
  }

}