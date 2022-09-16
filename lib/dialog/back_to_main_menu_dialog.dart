import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:morningmagic/routing/app_routing.dart';

class BackToMainMenuDialog extends StatelessWidget {
  const BackToMainMenuDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(color: Colors.white.withOpacity(.1)),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(17, 19, 17, 39.3),
                margin: const EdgeInsets.symmetric(horizontal: 31),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: Color(0xff592F72),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      'Are you sure you want to leave the complex'.tr,
                      style: const TextStyle(
                        color: Color(0xff592F72),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        AppRouting.navigateToHomeWithClearHistory();
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 61.25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xff592F72),
                          borderRadius: BorderRadius.circular(17),
                        ),
                        child: Text(
                          'leave'.tr,
                          style: const TextStyle(
                            color: Color(0xffFFFFFE),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
