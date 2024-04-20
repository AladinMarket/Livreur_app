import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class EarningWidget extends StatelessWidget {
  final String title;
  final double? amount;
  const EarningWidget({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(children: [
      Text(
        title,
        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
      ),
      const SizedBox(height: Dimensions.paddingSizeSmall),
      amount != null ? Text(
        PriceConverterHelper.convertPrice(amount),
        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
        maxLines: 2, overflow: TextOverflow.ellipsis,
      ) : Shimmer(
        duration: const Duration(seconds: 2),
        enabled: amount == null,
        color: Colors.grey[500]!,
        child: Container(height: 20, width: 40, color: Colors.white),
      ),
    ]));
  }
}
