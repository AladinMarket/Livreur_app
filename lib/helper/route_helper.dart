import 'dart:convert';
import 'package:sixam_mart_delivery/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart_delivery/features/chat/domain/models/conversation_model.dart';
import 'package:sixam_mart_delivery/features/auth/screens/sign_in_screen.dart';
import 'package:sixam_mart_delivery/features/auth/screens/delivery_man_registration_screen.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/screens/cash_in_hand_screen.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/screens/transaction_history_screen.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/screens/wallet_provided_earning_history_screen.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/screens/payment_screen.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/widgets/payment_successful_widget.dart';
import 'package:sixam_mart_delivery/features/chat/screens/chat_screen.dart';
import 'package:sixam_mart_delivery/features/chat/screens/conversation_screen.dart';
import 'package:sixam_mart_delivery/features/dashboard/screens/dashboard_screen.dart';
import 'package:sixam_mart_delivery/features/disbursement/screens/add_withdraw_method_screen.dart';
import 'package:sixam_mart_delivery/features/disbursement/screens/disbursement_screen.dart';
import 'package:sixam_mart_delivery/features/disbursement/screens/withdraw_method_screen.dart';
import 'package:sixam_mart_delivery/features/forgot_password/screens/forget_pass_screen.dart';
import 'package:sixam_mart_delivery/features/forgot_password/screens/new_pass_screen.dart';
import 'package:sixam_mart_delivery/features/forgot_password/screens/verification_screen.dart';
import 'package:sixam_mart_delivery/features/html/screens/html_viewer_screen.dart';
import 'package:sixam_mart_delivery/features/language/screens/language_screen.dart';
import 'package:sixam_mart_delivery/features/notification/screens/notification_screen.dart';
import 'package:sixam_mart_delivery/features/order/screens/order_details_screen.dart';
import 'package:sixam_mart_delivery/features/order/screens/running_order_screen.dart';
import 'package:sixam_mart_delivery/features/profile/screens/update_profile_screen.dart';
import 'package:sixam_mart_delivery/features/splash/screens/splash_screen.dart';
import 'package:sixam_mart_delivery/features/update/screens/update_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String signIn = '/sign-in';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String orderDetails = '/order-details';
  static const String updateProfile = '/update-profile';
  static const String notification = '/notification';
  static const String runningOrder = '/running-order';
  static const String terms = '/terms-and-condition';
  static const String privacy = '/privacy-policy';
  static const String language = '/language';
  static const String update = '/update';
  static const String chatScreen = '/chat-screen';
  static const String conversationListScreen = '/conversation-list-screen';
  static const String deliveryManRegistration = '/delivery-man-registration';
  static const String disbursement = '/disbursement';
  static const String withdrawMethod = '/withdraw-method';
  static const String addWithdrawMethod = '/add-withdraw-method';
  static const String success = '/success';
  static const String payment = '/payment';
  static const String transactionHistory = '/transaction-history';
  static const String cashInHand = '/cash-in-hand';
  static const String walletProvidedEarning = '/wallet-provided-earning';

  static String getInitialRoute({bool? fromOrderDetails}) => '$initial?from_order_details=${fromOrderDetails.toString()}';
  static String getSplashRoute(NotificationBodyModel? body) {
    String data = 'null';
    if(body != null) {
      List<int> encoded = utf8.encode(jsonEncode(body.toJson()));
      data = base64Encode(encoded);
    }
    return '$splash?data=$data';
  }
  static String getSignInRoute() => signIn;
  static String getVerificationRoute(String number) => '$verification?number=$number';
  static String getMainRoute(String page) => '$main?page=$page';
  static String getForgotPassRoute() => forgotPassword;
  static String getResetPasswordRoute(String? phone, String token, String page) => '$resetPassword?phone=$phone&token=$token&page=$page';
  static String getOrderDetailsRoute(int? id, {bool? fromNotification, bool? fromLocationScreen}) => '$orderDetails?id=$id&from=${fromNotification.toString()}&from_location_screen=${fromLocationScreen.toString()}';
  static String getUpdateProfileRoute() => updateProfile;
  static String getNotificationRoute({bool? fromNotification}) => '$notification?from=${fromNotification.toString()}';
  static String getRunningOrderRoute() => runningOrder;
  static String getTermsRoute() => terms;
  static String getPrivacyRoute() => privacy;
  static String getLanguageRoute() => language;
  static String getUpdateRoute(bool isUpdate) => '$update?update=${isUpdate.toString()}';
  static String getChatRoute({required NotificationBodyModel? notificationBody, User? user, int? conversationId, bool? fromNotification}) {

    String notificationBody0 = 'null';
    String user0 = 'null';

    if(notificationBody != null) {
      notificationBody0 = base64Encode(utf8.encode(jsonEncode(notificationBody)));
    }
    if(user != null) {
      user0 = base64Encode(utf8.encode(jsonEncode(user.toJson())));
    }
    return '$chatScreen?notification_body=$notificationBody0&user=$user0&conversation_id=$conversationId&from=${fromNotification.toString()}';
  }
  static String getConversationListRoute() => conversationListScreen;
  static String getDeliverymanRegistrationRoute() => deliveryManRegistration;
  static String getDisbursementRoute() => disbursement;
  static String getWithdrawMethodRoute({bool isFromDashBoard = false}) => '$withdrawMethod?is_from_dashboard=${isFromDashBoard.toString()}';
  static String getAddWithdrawMethodRoute() => addWithdrawMethod;
  static String getSuccessRoute(String status) => '$success?status=$status';
  static String getPaymentRoute(String? redirectUrl) {
    return '$payment?redirect-url=$redirectUrl';
  }
  static String getTransactionHistoryRoute() => transactionHistory;
  static String getCashInHandRoute() => cashInHand;
  static String getWalletProvidedEarningRoute() => walletProvidedEarning;


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => DashboardScreen(pageIndex: 0, fromOrderDetails: Get.parameters['from_order_details'] == 'true')),
    GetPage(name: splash, page: () {
      NotificationBodyModel? data;
      if(Get.parameters['data'] != 'null') {
        List<int> decode = base64Decode(Get.parameters['data']!.replaceAll(' ', '+'));
        data = NotificationBodyModel.fromJson(jsonDecode(utf8.decode(decode)));
      }
      return SplashScreen(body: data);
    }),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: verification, page: () => VerificationScreen(number: Get.parameters['number'])),
    GetPage(name: main, page: () => DashboardScreen(
      pageIndex: Get.parameters['page'] == 'home' ? 0 : Get.parameters['page'] == 'order-request' ? 1
          : Get.parameters['page'] == 'order' ? 2 : Get.parameters['page'] == 'profile' ? 3 : 0,
    )),
    GetPage(name: forgotPassword, page: () => const ForgetPassScreen()),
    GetPage(name: resetPassword, page: () => NewPassScreen(
      resetToken: Get.parameters['token'], number: Get.parameters['phone'], fromPasswordChange: Get.parameters['page'] == 'password-change',
    )),
    GetPage(name: orderDetails, page: () {
      OrderDetailsScreen? orderDetails = Get.arguments;
      return orderDetails ?? OrderDetailsScreen(
        fromNotification: Get.parameters['from'] == 'true', isRunningOrder: null, orderIndex: null, orderId: int.parse(Get.parameters['id']!),
        fromLocationScreen: Get.parameters['from_location_screen'] == 'true',
      );
    }),
    GetPage(name: updateProfile, page: () => const UpdateProfileScreen()),
    GetPage(name: notification, page: () => NotificationScreen(fromNotification: Get.parameters['from'] == 'true')),
    GetPage(name: runningOrder, page: () => const RunningOrderScreen()),
    GetPage(name: terms, page: () => const HtmlViewerScreen(isPrivacyPolicy: false)),
    GetPage(name: privacy, page: () => const HtmlViewerScreen(isPrivacyPolicy: true)),
    GetPage(name: language, page: () => const ChooseLanguageScreen()),
    GetPage(name: update, page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(name: chatScreen, page: () {

      NotificationBodyModel? notificationBody;
      if(Get.parameters['notification_body'] != 'null') {
        notificationBody = NotificationBodyModel.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['notification_body']!.replaceAll(' ', '+')))));
      }
      User? user;
      if(Get.parameters['user'] != 'null') {
        user = User.fromJson(jsonDecode(utf8.decode(base64Url.decode(Get.parameters['user']!.replaceAll(' ', '+')))));
      }
      return ChatScreen(
        notificationBody : notificationBody, user: user, fromNotification: Get.parameters['from'] == 'true',
        conversationId: Get.parameters['conversation_id'] != null && Get.parameters['conversation_id'] != 'null' ? int.parse(Get.parameters['conversation_id']!) : null,
      );
    }),
    GetPage(name: conversationListScreen, page: () => const ConversationScreen()),
    GetPage(name: deliveryManRegistration, page: () => const DeliveryManRegistrationScreen()),
    GetPage(name: disbursement, page: () => const DisbursementScreen()),
    GetPage(name: withdrawMethod, page: () => WithdrawMethodScreen(isFromDashboard: Get.parameters['is_from_dashboard'] == 'true')),
    GetPage(name: addWithdrawMethod, page: () => const AddWithDrawMethodScreen()),
    GetPage(name: success, page: () => PaymentSuccessfulWidget(success: Get.parameters['status'] == 'success')),
    GetPage(name: payment, page: () {
      String walletPayment = Get.parameters['redirect-url']!;
      return PaymentScreen(redirectUrl: walletPayment);
    }),
    GetPage(name: transactionHistory, page: () => const TransactionHistoryScreen()),
    GetPage(name: cashInHand, page: () => const CashInHandScreen()),
    GetPage(name: walletProvidedEarning, page: () => const WalletProvidedHistoryScreen()),
  ];
}