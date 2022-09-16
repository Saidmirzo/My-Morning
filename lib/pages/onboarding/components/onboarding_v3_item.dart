import 'package:flutter/material.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/routing/app_routing.dart' as routing;
import 'package:morningmagic/utils/navigation_animation.dart';

class OnboardingV3Item extends StatelessWidget {
  const OnboardingV3Item(
      {Key key,
      this.img,
      this.title1,
      this.title2,
      this.isLast = false,
      this.page})
      : super(key: key);
  final String img;
  final String title1;
  final String title2;
  final dynamic page;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isLast) {
          routing.AppRouting.replace(const MainMenuPage());
        }
        Navigator.of(context).push(
          createRoute(
            page,
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(
          left: 18,
          right: 18,
          bottom: 18,
        ),
        height: 95,
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(img),
            alignment: Alignment.centerRight,
            fit: BoxFit.fitHeight,
          ),
        ),
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Color(0xff010000),
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: 'Montserrat',
            ),
            text: title1,
            children: [
              TextSpan(
                text: title2,
                style: const TextStyle(
                  color: Color(0xff6b0495),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
