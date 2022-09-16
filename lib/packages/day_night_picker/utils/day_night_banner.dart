
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:morningmagic/packages/day_night_picker/utils/sun_moon.dart';

class DayNightBanner extends StatelessWidget {
  const DayNightBanner({Key key, @required this.hour}) : super(key: key);
  final int hour;

  double mapRange(
    double value,
    double iMin,
    double iMax, [
    double oMin = 0,
    double oMax = 1,
  ]) {
    return ((value - iMin) * (oMax - oMin)) / (iMax - iMin) + oMin;
  }

  /// Get the background color of the container, representing the time of day
  Color getColor(bool isDay, bool isDusk) {
    if (!isDay) {
      return Colors.blueGrey[900];
    }
    if (isDusk) {
      return Colors.orange[400];
    }
    return Colors.blue[200];
  }

  @override
  Widget build(BuildContext context) {
    // PickerProvider prov = context.watch<PickerProvider>();
    // final timeState = TimeModelBinding.of(context);
    bool isDay = hour >= 6 && hour <= 18;
    bool isDusk = hour >= 16 && hour <= 18;

    // if (!timeState.widget.displayHeader!) {
    //   return Container(height: 25, color: Theme.of(context).cardColor);
    // }

    final displace = mapRange(hour * 1.0, 0, 23);

    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      duration: const Duration(seconds: 1),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(19),
          topRight: Radius.circular(19),
        ),
        color: getColor(isDay, isDusk),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth.round() - 100;
          final top = sin(pi * displace) * 1.8;
          final left = maxWidth * displace;
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AnimatedPositioned(
                curve: Curves.ease,
                bottom: top * 20,
                left: left,
                duration: const Duration(milliseconds: 200),
                child: SunMoon(
                  isSun: isDay,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}