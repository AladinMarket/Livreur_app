import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart_delivery/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/images.dart';
import 'package:sixam_mart_delivery/util/styles.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_image_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/widgets/payment_method_bottom_sheet_widget.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/widgets/wallet_attention_alert_widget.dart';

class CashInHandScreen extends StatefulWidget {
  const CashInHandScreen({super.key});

  @override
  State<CashInHandScreen> createState() => _CashInHandScreenState();
}

class _CashInHandScreenState extends State<CashInHandScreen> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Get.find<ProfileController>().getProfile();
    Get.find<CashInHandController>().getWalletPaymentList();
    Get.find<CashInHandController>().getWalletProvidedEarningList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(Get.find<ProfileController>().profileModel == null) {
      Get.find<ProfileController>().getProfile();
    }

    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'my_account'.tr,
        isBackButtonExist: true,
        actionWidget: GetBuilder<ProfileController>(builder: (profileController) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), border: Border.all(width: 1.5, color: Theme.of(context).primaryColor)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: CustomImageWidget(
                image: '${Get.find<SplashController>().configModel!.baseUrls!.deliveryManImageUrl}'
                    '/${(profileController.profileModel != null && Get.find<AuthController>().isLoggedIn()) ? profileController.profileModel!.image ?? '' : ''}',
                width: 35, height: 35, fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),

      body: GetBuilder<CashInHandController>(builder: (cashInHandController) {
        return GetBuilder<ProfileController>(builder: (profileController) {
          return (profileController.profileModel != null && cashInHandController.transactions != null) ? RefreshIndicator(
            onRefresh: () async {
              profileController.getProfile();
              Get.find<CashInHandController>().getWalletPaymentList();
              Get.find<CashInHandController>().getWalletProvidedEarningList();
              return await Future.delayed(const Duration(seconds: 1));
            },
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(children: [

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Container(
                        width: context.width, height: 129,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          color: const Color(0xff334257),
                          image: const DecorationImage(
                            image: AssetImage(Images.cashInHandBg),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                                Row(
                                  children: [
                                    Image.asset(Images.walletIcon, width: 40, height: 40),
                                    const SizedBox(width: Dimensions.paddingSizeSmall),
                                    Text('payable_amount'.tr, style: robotoMedium.copyWith(color: Theme.of(context).cardColor)),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.paddingSizeDefault),

                                Text(PriceConverterHelper.convertPrice(profileController.profileModel!.payableBalance), style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).cardColor)),
                              ]),
                            ),

                            Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                              profileController.profileModel!.adjustable! ? InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return GetBuilder<CashInHandController>(builder: (cashInHandController) {
                                        return AlertDialog(
                                          title: Center(child: Text('cash_adjustment'.tr)),
                                          content: Text('cash_adjustment_description'.tr, textAlign: TextAlign.center),
                                          actions: [

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(children: [

                                                Expanded(
                                                  child: SizedBox(
                                                    height: 45,
                                                    child: CustomButtonWidget(
                                                      onPressed: () => Get.back(),
                                                      backgroundColor: Theme.of(context).disabledColor.withOpacity(0.5),
                                                      buttonText: 'cancel'.tr,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: Dimensions.paddingSizeExtraLarge),

                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      cashInHandController.makeWalletAdjustment();
                                                    },
                                                    child: Container(
                                                      height: 45,
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                                        color: Theme.of(context).primaryColor,
                                                      ),
                                                      child: !cashInHandController.isLoading ? Text('ok'.tr, style: robotoBold.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeLarge),)
                                                        : const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)),
                                                    ),
                                                  ),
                                                ),

                                              ]),
                                            ),

                                          ],
                                        );
                                      });
                                    }
                                  );
                                },
                                child: Container(
                                  width: 115,
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Text('adjust_payments'.tr, textAlign: TextAlign.center, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)),
                                ),
                              ) : const SizedBox(),
                              SizedBox(height: profileController.profileModel!.adjustable! ? Dimensions.paddingSizeLarge : 0),

                              InkWell(
                                onTap: () {
                                  if(profileController.profileModel!.showPayNowButton!) {
                                    showModalBottomSheet(
                                      isScrollControlled: true, useRootNavigator: true, context: context,
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
                                      ),
                                      builder: (context) {
                                        return ConstrainedBox(
                                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                                          child: const PaymentMethodBottomSheetWidget(),
                                        );
                                      },
                                    );
                                  } else {
                                    if(Get.find<SplashController>().configModel!.activePaymentMethodList!.isEmpty || !Get.find<SplashController>().configModel!.digitalPayment!){
                                      showCustomSnackBar('currently_there_are_no_payment_options_available_please_contact_admin_regarding_any_payment_process_or_queries'.tr);
                                    }else if(Get.find<SplashController>().configModel!.minAmountToPayDm! > profileController.profileModel!.payableBalance!){
                                      showCustomSnackBar('${'you_do_not_have_sufficient_balance_to_pay_the_minimum_payable_balance_is'.tr} ${PriceConverterHelper.convertPrice(Get.find<SplashController>().configModel!.minAmountToPayDm)}');
                                    }
                                  }
                                },
                                child: Container(
                                  width: profileController.profileModel!.adjustable! ? 115 : null,
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeDefault),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    color: profileController.profileModel!.showPayNowButton! ? Theme.of(context).primaryColor : Theme.of(context).disabledColor.withOpacity(0.8),
                                  ),
                                  child: Text('pay_now'.tr, textAlign: TextAlign.center, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)),
                                ),
                              ),

                            ]),
                          ]),
                        ),

                      ),
                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      Row(children: [

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              color: Theme.of(context).cardColor,
                              boxShadow: Get.isDarkMode ? null : [BoxShadow(color: Colors.grey[200]!, spreadRadius: 0.5, blurRadius: 5)],
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                              Text(
                                PriceConverterHelper.convertPrice(profileController.profileModel!.cashInHands),
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),

                              Text('cash_in_hand'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),

                            ]),
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeDefault),

                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              color: Theme.of(context).cardColor,
                              boxShadow: Get.isDarkMode ? null : [BoxShadow(color: Colors.grey[200]!, spreadRadius: 0.5, blurRadius: 5)],
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                              Text(
                                PriceConverterHelper.convertPrice(profileController.profileModel!.totalWithdrawn),
                                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),

                              Text('total_withdrawn'.tr, style: robotoRegular.copyWith(color: Theme.of(context).disabledColor)),

                            ]),
                          ),
                        ),

                      ]),

                      Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraLarge),
                        child: Row(children: [

                          InkWell(
                            onTap: () {
                              if(cashInHandController.selectedIndex != 0) {
                                cashInHandController.setIndex(0);
                              }
                            },
                            hoverColor: Colors.transparent,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              Text('payment_history'.tr, style: robotoMedium.copyWith(
                                color: cashInHandController.selectedIndex == 0 ? Colors.blue : Theme.of(context).disabledColor,
                              )),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Container(
                                height: 3, width: 110,
                                margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                  color: cashInHandController.selectedIndex == 0 ? Colors.blue : null,
                                ),
                              ),

                            ]),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          InkWell(
                            onTap: () {
                              if(cashInHandController.selectedIndex != 1) {
                                cashInHandController.setIndex(1);
                              }
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              Text('wallet_provided_earning'.tr, style: robotoMedium.copyWith(
                                color: cashInHandController.selectedIndex == 1 ? Colors.blue : Theme.of(context).disabledColor,
                              )),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                              Container(
                                height: 3, width: 150,
                                margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                  color: cashInHandController.selectedIndex == 1 ? Colors.blue : null,
                                ),
                              ),

                            ]),
                          ),
                        ]),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

                        Text("transaction_history".tr, style: robotoMedium),

                        (cashInHandController.selectedIndex == 0 && cashInHandController.transactions!.isEmpty) ||
                        (cashInHandController.selectedIndex == 1 && cashInHandController.walletProvidedTransactions!.isEmpty) ? const SizedBox() : InkWell(
                          onTap: () {
                            if(cashInHandController.selectedIndex == 0) {
                              Get.toNamed(RouteHelper.getTransactionHistoryRoute());
                            }
                            if(cashInHandController.selectedIndex == 1) {
                              Get.toNamed(RouteHelper.getWalletProvidedEarningRoute());
                            }

                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: Text('view_all'.tr, style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor,
                            )),
                          ),
                        ),

                      ]),
                      const SizedBox(height: Dimensions.paddingSizeSmall),

                      if(cashInHandController.selectedIndex == 0)
                        cashInHandController.transactions != null ? cashInHandController.transactions!.isNotEmpty ? ListView.builder(
                          itemCount: cashInHandController.transactions!.length > 25 ? 25 : cashInHandController.transactions!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                          return Column(children: [

                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                              child: Row(children: [
                                Expanded(
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    Text(PriceConverterHelper.convertPrice(cashInHandController.transactions![index].amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), textDirection: TextDirection.ltr,),
                                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                    Text('${'paid_via'.tr} ${cashInHandController.transactions![index].method?.replaceAll('_', ' ').capitalize??''}', style: robotoRegular.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
                                    )),
                                  ]),
                                ),
                                Text(cashInHandController.transactions![index].paymentTime.toString(),
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                ),
                              ]),
                            ),

                            const Divider(height: 1),
                          ]);
                        },
                      ) : Center(child: Padding(padding: const EdgeInsets.only(top: 250), child: Text('no_transaction_found'.tr)))
                          : const Center(child: Padding(padding: EdgeInsets.only(top: 250), child: CircularProgressIndicator())),

                      if(cashInHandController.selectedIndex == 1)
                        cashInHandController.walletProvidedTransactions != null ? cashInHandController.walletProvidedTransactions!.isNotEmpty ? ListView.builder(
                          itemCount: cashInHandController.walletProvidedTransactions!.length > 25 ? 25 : cashInHandController.walletProvidedTransactions!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
                                child: Row(children: [
                                  Expanded(
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                      Text(PriceConverterHelper.convertPrice(cashInHandController.walletProvidedTransactions![index].amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), textDirection: TextDirection.ltr,),
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
                        ) : Center(child: Padding(padding: const EdgeInsets.only(top: 250), child: Text('no_transaction_found'.tr)))
                            : const Center(child: Padding(padding: EdgeInsets.only(top: 250), child: CircularProgressIndicator())),

                    ]),

                  ),
                ),

                (profileController.profileModel!.overFlowWarning! || profileController.profileModel!.overFlowBlockWarning!)
                  ? WalletAttentionAlertWidget(isOverFlowBlockWarning: profileController.profileModel!.overFlowBlockWarning!) : const SizedBox(),

              ]),
            ),
          ) : const Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}
