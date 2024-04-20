import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/features/chat/domain/models/conversation_model.dart';
import 'package:sixam_mart_delivery/features/chat/domain/models/message_model.dart';
import 'package:sixam_mart_delivery/features/notification/domain/models/notification_body_model.dart';

abstract class ChatServiceInterface {
  Future<ConversationsModel?> getConversationList(int offset);
  Future<ConversationsModel?> searchConversationList(String name);
  Future<MessageModel?> getMessages(int offset, int? userId, String userType, int? conversationID);
  Future<MessageModel?> sendMessage(String message, List<MultipartBody> file, int? conversationId, int? userId, String userType);
  Future<MessageModel?> processGetMessage(int offset, NotificationBodyModel notificationBody, int? conversationID);
  List<MultipartBody> processMultipartBody(List<XFile> chatImage);
  Future<MessageModel?> processSendMessage(NotificationBodyModel? notificationBody, List<MultipartBody> chatImage, String message, int? conversationId);
}