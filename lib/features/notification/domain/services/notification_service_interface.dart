import 'package:sixam_mart_delivery/features/notification/domain/models/notification_model.dart';

abstract class NotificationServiceInterface {
  Future<List<NotificationModel>?> getNotificationList();
  void saveSeenNotificationCount(int count);
  int? getSeenNotificationCount();
  Future<bool> sendDeliveredNotification(int? orderID);
}