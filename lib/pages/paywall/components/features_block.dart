import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class FeaturesBlockPaywall extends StatelessWidget {
  FeaturesBlockPaywall({Key key}) : super(key: key);
  final List itemsInfo1 = [
    {
      "img": MyImages.onboardingV2page12Icon1,
      "text": "Fitness".tr,
      "w": 88.21,
      "h": 57.14
    },
    {
      "img": MyImages.onboardingV2page12Icon2,
      "text": "Visualization".tr,
      "w": 104.81,
      "h": 55.5
    },
    {
      "img": MyImages.onboardingV2page12Icon3,
      "text": "Meditations".tr,
      "w": 68.53,
      "h": 68.91
    },
  ];
  final List itemsInfo2 = [
    {
      "img": MyImages.onboardingV2page12Icon4,
      "text": "Reading".tr,
      "w": 81.0,
      "h": 90.0
    },
    {
      "img": MyImages.onboardingV2page12Icon5,
      "text": "Notes".tr,
      "w": 91.67,
      "h": 71.02
    },
    {
      "img": MyImages.onboardingV2page12Icon6,
      "text": "Affirmations".tr,
      "w": 64.54,
      "h": 93.29,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 13,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(
                  3,
                  (i) => FeatureBlockItem(
                    img: itemsInfo1[i]["img"],
                    text: itemsInfo1[i]["text"],
                    w: itemsInfo1[i]["w"] * 1,
                    h: itemsInfo1[i]["h"] * 1,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(
                  3,
                  (i) => FeatureBlockItem(
                    img: itemsInfo2[i]["img"],
                    text: itemsInfo2[i]["text"],
                    w: itemsInfo2[i]["w"] * 1,
                    h: itemsInfo2[i]["h"] * 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureBlockItem extends StatelessWidget {
  const FeatureBlockItem({Key key, this.img, this.text, this.w, this.h})
      : super(key: key);
  final String img;
  final String text;
  final double w;
  final double h;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        height: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Image.asset(
                img,
                // fit: BoxFit.fitHeight,
                // width: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat',
                fontSize: 12.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
