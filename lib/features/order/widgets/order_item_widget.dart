import 'package:sixam_mart_delivery/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/order_model.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_image_widget.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel order;
  final OrderDetailsModel orderDetails;
  const OrderItemWidget({super.key, required this.order, required this.orderDetails});
  
  @override
  Widget build(BuildContext context) {
    String addOnText = '';
    for (var addOn in orderDetails.addOns!) {
      addOnText = '$addOnText${(addOnText.isEmpty) ? '' : ',  '}${addOn.name} (${addOn.quantity})';
    }

    String? variationText = '';
    if(orderDetails.variation!.isNotEmpty) {
      List<String> variationTypes = orderDetails.variation![0].type!.split('-');
      if(variationTypes.length == orderDetails.itemDetails!.choiceOptions!.length) {
        int index = 0;
        for (var choice in orderDetails.itemDetails!.choiceOptions!) {
          variationText = '${variationText!}${(index == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index]}';
          index = index + 1;
        }
      }else {
        variationText = orderDetails.itemDetails!.variations![0].type;
      }
    }else if(orderDetails.foodVariation!.isNotEmpty) {
      for(FoodVariation variation in orderDetails.foodVariation!) {
        variationText = '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${variation.name} (';
        for(VariationValue value in variation.variationValues!) {
          variationText = '${variationText!}${variationText.endsWith('(') ? '' : ', '}${value.level}';
        }
        variationText = '${variationText!})';
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Row(children: [

        orderDetails.itemDetails!.image != null ? ClipRRect(
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          child: CustomImageWidget(
            height: 50, width: 50, fit: BoxFit.cover,
            image: '${order.itemCampaignId != null ? Get.find<SplashController>().configModel!.baseUrls!.campaignImageUrl
                : Get.find<SplashController>().configModel!.baseUrls!.itemImageUrl}/${orderDetails.itemDetails!.image}',
          ),
        ) : const SizedBox(),
        SizedBox(width: orderDetails.itemDetails!.image != null ? Dimensions.paddingSizeSmall : 0),

        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Row(children: [

              Expanded(child: Text(
                orderDetails.itemDetails!.name!,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              )),

              Text('${'quantity'.tr}:', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

              Text(
                orderDetails.quantity.toString(),
                style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
              ),

            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Row(children: [

              Text(
                PriceConverterHelper.convertPrice(orderDetails.price! - orderDetails.discountOnItem!),
                style: robotoMedium,
              ),
              const SizedBox(width: 5),

              orderDetails.discountOnItem! > 0 ? Expanded(child: Text(
                PriceConverterHelper.convertPrice(orderDetails.price),
                style: robotoMedium.copyWith(
                  decoration: TextDecoration.lineThrough,
                  fontSize: Dimensions.fontSizeSmall,
                  color: Theme.of(context).disabledColor,
                ),
              )) : const Expanded(child: SizedBox()),

              ((Get.find<SplashController>().getModule(order.moduleType).unit! && orderDetails.itemDetails!.unitType != null)
              || (Get.find<SplashController>().configModel!.toggleVegNonVeg! && Get.find<SplashController>().getModule(order.moduleType).vegNonVeg!)) ? Container(
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                child: Text(
                  Get.find<SplashController>().getModule(order.moduleType).unit! ? orderDetails.itemDetails!.unitType ?? ''
                      : orderDetails.itemDetails!.veg == 0 ? 'non_veg'.tr : 'veg'.tr,
                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                ),
              ) : const SizedBox(),

            ]),

          ]),
        ),
      ]),

      (Get.find<SplashController>().getModule(order.moduleType).addOn! && addOnText.isNotEmpty) ? Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
        child: Row(children: [

          const SizedBox(width: 60),
          Text('${'addons'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),

          Flexible(child: Text(
            addOnText,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
          )),
        ]),
      ) : const SizedBox(),

      variationText!.isNotEmpty ? Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
        child: Row(children: [

          const SizedBox(width: 60),
          Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),

          Flexible(child: Text(
            variationText,
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
          )),

        ]),
      ) : const SizedBox(),

      const Divider(height: Dimensions.paddingSizeLarge),
      const SizedBox(height: Dimensions.paddingSizeSmall),
    ]);
  }
}
