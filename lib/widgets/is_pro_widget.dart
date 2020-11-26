import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class IsProWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'user_is_pro'.tr(),
      ),
    );
  }
}