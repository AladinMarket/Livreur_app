import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_app_bar_widget.dart';

class WalletProvidedHistoryScreen extends StatefulWidget {
  const WalletProvidedHistoryScreen({super.key});

  @override
  State<WalletProvidedHistoryScreen> createState() => _WalletProvidedHistoryScreenState();
}

class _WalletProvidedHistoryScreenState extends State<WalletProvidedHistoryScreen> {

  @override
  void initState() {
    Get.find<CashInHandController>().getWalletProvidedEarningList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'wallet_provided_earning_history'.tr),

      body: GetBuilder<CashInHandController>(builder: (cashInHandController) {
        return cashInHandController.walletProvidedTransactions != null ? cashInHandController.walletProvidedTransactions!.isNotEmpty ? ListView.builder(
          itemCount: cashInHandController.walletProvidedTransactions!.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(children: [

              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                child: Row(children: [

                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                      Text(PriceConverterHelper.convertPrice(cashInHandController.walletProvidedTransactions![index].amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                      Text('${'wallet'.tr} ${cashInHandController.walletProvidedTransactions![index].method?.replaceAll('_', ' ').capitalize??''}', style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
                      )),

                    ]),
                  ),

                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

                    Text(cashInHandController.walletProvidedTransactions![index].paymentTime.toString(),
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                    Text(cashInHandController.walletProvidedTransactions![index].status!.tr, style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: cashInHandController.walletProvidedTransactions![index].status == 'approved' ? Theme.of(context).primaryColor : cashInHandController.walletProvidedTransactions![index].status == 'denied'
                          ? Theme.of(context).colorScheme.error : Colors.blue,
                    )),

                  ]),
                ]),
              ),
              const Divider(height: 1),

            ]);
          },
        ) : Center(child: Text('no_transaction_found'.tr)) : const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
