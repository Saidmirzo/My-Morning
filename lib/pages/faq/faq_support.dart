import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/other.dart';
import 'package:morningmagic/widgets/primary_circle_button.dart';

class FaqSupportPage extends StatefulWidget {
  @override
  _FaqSupportPageState createState() => _FaqSupportPageState();
}

class _FaqSupportPageState extends State<FaqSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientContainer(
        gradient: AppColors.Bg_Gradient_Menu,
        child: Stack(
          children: [
            clouds,
            SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    backBtn(),
                    Spacer(),
                    buildInstagram(),
                    const SizedBox(height: 100),
                    buildEmail(),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backBtn() {
    return Align(
      alignment: Alignment.topLeft,
      child: PrimaryCircleButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => Get.back(),
        size: 40,
      ),
    );
  }

  Widget buildInstagram() {
    String url = 'https://instagram.com/mymorningapp/';
    return GestureDetector(
      onTap: () {
        openUrl(url);
      },
      child: Column(
        children: [
          SvgPicture.asset('assets/images/svg/instagram.svg', width: Get.width / 4),
          Text(
            '@mymorningapp',
            style: TextStyle(color: Colors.white, fontSize: Get.width * .04),
          ),
        ],
      ),
    );
  }

  Widget buildEmail() {
    return GestureDetector(
      onTap: () {
        openEmail('morning@good-apps.org', '');
      },
      child: Column(
        children: [
          Icon(Icons.mail, size: Get.width / 4, color: Colors.blue),
          Text(
            'morning@good-apps.org',
            style: TextStyle(color: Colors.white, fontSize: Get.width * .04),
          )
        ],
      ),
    );
  }

  Widget get clouds => Positioned(
        bottom: 0,
        child: Container(
          width: Get.width,
          child: Image.asset(
            'assets/images/faq/clouds.png',
            fit: BoxFit.cover,
          ),
        ),
      );
}
