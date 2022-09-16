import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_fake.dart';
import 'package:morningmagic/resources/svg_assets.dart';

class CloseButtonPaywall extends StatelessWidget {
  const CloseButtonPaywall({Key key, @required this.onClick}) : super(key: key);
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.only(right: 27, top: 20),
        child: Image.asset(
          MyImages.newPaywallCloseIcon,
          width: 18,
          height: 18,
        ),
      ),
    );
  }
}
