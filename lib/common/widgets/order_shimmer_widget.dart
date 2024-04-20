import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class OrderShimmerWidget extends StatelessWidget {
  final bool isEnabled;
  const OrderShimmerWidget({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: Get.isDarkMode ? null : [BoxShadow(color: Colors.grey[200]!, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        enabled: isEnabled,
        child: Column(children: [

          Row(children: [
            Container(height: 15, width: 100, color: Colors.grey[300]),
            const Expanded(child: SizedBox()),
            Container(width: 7, height: 7, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle)),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Container(height: 15, width: 70, color: Colors.grey[300]),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
            Image.asset(Images.house, width: 20, height: 15),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Container(height: 15, width: 200, color: Colors.grey[300]),
          ]),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start, children: [
            const Icon(Icons.location_on, size: 20),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Container(height: 15, width: 200, color: Colors.grey[300]),
          ]),
          const SizedBox(height: Dimensions.paddingSizeDefault),

          Row(children: [
            Expanded(child: Container(height: 50, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)))),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(child: Container(height: 50, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(5)))),
          ]),

        ]),
      ),
    );
  }
}
