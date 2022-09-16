import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/pages/paywall/paywall_provider.dart';
import 'package:provider/provider.dart';

class StartButtonPaywall extends StatelessWidget {
  const StartButtonPaywall({
    Key key,
    @required this.onClick,
  }) : super(key: key);
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    PayWallProvider prov = context.watch<PayWallProvider>();

    return Expanded(
      flex: 3,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          width: double.maxFinite,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xff6B0496),
              borderRadius: BorderRadius.circular(19)),
          child: Text(
            prov.openedProductIndex == 1
                ? "Start 3 days free trial".tr
                : "Starting".tr,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.white,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}
