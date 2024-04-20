import 'package:get/get.dart';
import 'dart:async';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/services/cash_in_hand_service_interface.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';

class CashInHandController extends GetxController implements GetxService {
  final CashInHandServiceInterface cashInHandServiceInterface;
  CashInHandController({required this.cashInHandServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Transactions>? _transactions;
  List<Transactions>? get transactions => _transactions;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Transactions>? _walletProvidedTransactions;
  List<Transactions>? get walletProvidedTransactions => _walletProvidedTransactions;

  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await cashInHandServiceInterface.makeCollectCashPayment(amount, paymentGatewayName);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getWalletPaymentList() async {
    _transactions = null;
    List<Transactions>? transactions = await cashInHandServiceInterface.getWalletPaymentList();
    if(transactions != null) {
      _transactions = [];
      _transactions!.addAll(transactions);
    }
    update();
  }

  Future<void> getWalletProvidedEarningList() async {
    _walletProvidedTransactions = null;
    List<Transactions>? walletProvidedTransactions = await cashInHandServiceInterface.getWalletProvidedEarningList();
    if(walletProvidedTransactions != null) {
      _walletProvidedTransactions = [];
      _walletProvidedTransactions!.addAll(walletProvidedTransactions);
    }
    update();
  }

  Future<void> makeWalletAdjustment() async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await cashInHandServiceInterface.makeWalletAdjustment();
    if(responseModel.isSuccess) {
      Get.find<ProfileController>().getProfile();
      Get.back();
      showCustomSnackBar(responseModel.message, isError: false);
    }else{
      Get.back();
      showCustomSnackBar(responseModel.message, isError: true);
    }
    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void changeDigitalPaymentName(String? name, {bool canUpdate = true}){
    _digitalPaymentName = name;
    if(canUpdate) {
      update();
    }
  }

  void setIndex(int index) {
    _selectedIndex = index;
    update();
  }

}