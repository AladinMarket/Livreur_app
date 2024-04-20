import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/withdraw_method_model.dart';
import 'package:sixam_mart_delivery/features/disbursement/domain/models/disbursement_method_model.dart' as disburse;
import 'package:sixam_mart_delivery/features/disbursement/domain/models/disbursement_report_model.dart' as report;

abstract class DisbursementServiceInterface {
  Future<bool> addWithdraw(Map<String?, String> data);
  Future<disburse.DisbursementMethodBody?> getDisbursementMethodList();
  Future<bool> makeDefaultMethod(Map<String?, String> data);
  Future<bool> deleteMethod(int id);
  Future<report.DisbursementReportModel?> getDisbursementReport(int offset);
  Future<List<WidthDrawMethodModel>?> getWithdrawMethodList();
}