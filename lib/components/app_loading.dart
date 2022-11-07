
import 'package:flutter/material.dart';

import '../resources/colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.violet,
      ),
    );
  }

}