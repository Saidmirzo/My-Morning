import 'package:flutter/material.dart';

import '../packages/day_night_picker/brand_buttons/brand_buttons.dart';
import '../packages/day_night_picker/brand_divider/brand_divider.dart';
import '../packages/day_night_picker/brand_icons/brand_icons_icons.dart';

class PesonalizationScreen extends StatelessWidget {
  const PesonalizationScreen({
    Key key,
    @required this.onClose,
  }) : super(key: key);

  final VoidCallback onClose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/main/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xff664EFF).withOpacity(0.8),
                    const Color(0xff664EFF).withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 130,
                        width: 130,
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Personalization\n',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          height: 44 / 36,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'app',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 210,
                      child: Text(
                        'Permission, you agree to provide us with device data, similar cookies, so that we can:',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          height: 19.5 / 16,
                          color: const Color(0xFFFFFFFF).withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(flex: 2),
                    const BuildCookiesRow(
                        icon: BrandIcons.brokenarrow,
                        text: 'Improve application\nperformance with analytics\nand bug reports'),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: BrandDivider(),
                    ),
                    const SizedBox(height: 20),
                    const BuildCookiesRow(
                        icon: BrandIcons.winkingsmile,
                        text: 'You help make Productive\navailable to millions of\nusers'),
                    const Spacer(flex: 2),
                    _buildPrivacyBlock(),
                    const Spacer(flex: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: BrandButtons(
                        color: const Color(0xff372A86),
                        borderColor: const Color(0xff372A86),
                        text: 'Continue',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          height: 25 / 18,
                          color: Colors.white,
                        ),
                        onTap: onClose,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          text: 'Our ',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400, height: 15 / 12, color: Colors.white),
                          children: [
                            TextSpan(
                              text: 'privacy policy',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400, height: 15 / 12, color: Color(0xff372A86)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 18),
          child: Icon(
            BrandIcons.privacy,
            color: Color(0xff372A86),
            size: 20,
          ),
        ),
        const SizedBox(width: 3),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            text: 'We ',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              height: 18 / 15,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'always ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 18 / 15,
                  color: Color(0xff372A86),
                ),
              ),
              TextSpan(
                text: 'take care of\nyour privacy',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  height: 18 / 15,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BuildCookiesRow extends StatelessWidget {
  const BuildCookiesRow({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.17),
            ),
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 18 / 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
