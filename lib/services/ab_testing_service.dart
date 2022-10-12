import 'package:flutter/material.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_one/onboarding_1_page.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_three/onboarding_page_1.dart';
import 'package:morningmagic/pages/onboarding/onboarding_version_two/on_boardingpage_1.dart';
import 'package:morningmagic/resources/remote_config_keys.dart';

class ABTestingService {
  String _paywallVersion;
  String _onboardingVersion;

  void setup(Map<String, dynamic> data) {
    _paywallVersion = data[AdaptyCustomPayloadKeys.paywallVersion];
    _onboardingVersion = data[AdaptyCustomPayloadKeys.onboardingVersion];
  }

// not usable
  Widget testPaywall() {
    switch (_paywallVersion) {
      case 'v1':
        return const Text('data');
      case 'v2':
        return const Text('data');
      default:
        return const Text('data');
    }
  }

  Widget testOnboarding() {
    switch (_onboardingVersion) {
      case 'v1_11pages':
        return const OnBoarding1Page();
      case 'v2_14pages':
        return const OnboardingVersionSecondPage1();
      case 'v3_6pages':
        return const OnboardingVersionThirdPageOne();
      default:
        // for catch in test
        throw Error();
    }
  }
}
