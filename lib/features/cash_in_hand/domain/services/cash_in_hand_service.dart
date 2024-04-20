import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/repositories/cash_in_hand_repository_interface.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/services/cash_in_hand_service_interface.dart';

class CashInHandService implements CashInHandServiceInterface {
  final CashInHandRepositoryInterface cashInHandRepositoryInterface;
  CashInHandService({required this.cashInHandRepositoryInterface});

  @override
  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName) async {
    return await cashInHandRepositoryInterface.makeCollectCashPayment(amount, paymentGatewayName);
  }

  @override
  Future<List<Transactions>?> getWalletPaymentList() async {
    return await cashInHandRepositoryInterface.getList();
  }

  @override
  Future<List<Transactions>?> getWalletProvidedEarningList() async {
    return await cashInHandRepositoryInterface.getWalletProvidedEarningList();
  }

  @override
  Future<ResponseModel> makeWalletAdjustment() async {
    return await cashInHandRepositoryInterface.makeWalletAdjustment();
  }

}