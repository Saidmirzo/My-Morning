import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/features/instruments_audio/controllers/instruments_audio_controller.dart';
import 'package:morningmagic/resources/colors.dart';

class TrackBar extends StatefulWidget {
  @override
  final String tag;
  double volume;
  final dialogMode;
  final bool fromTimer;

  TrackBar(
      {@required this.tag,
      this.volume = 0.5,
      this.dialogMode = false,
      this.fromTimer = false});

  @override
  TrackBarState createState() => TrackBarState();
}

class TrackBarState extends State<TrackBar> {
  final InstrumentAudioController _audioController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: CustomTrackShape(),
        activeTrackColor: AppColors.TRACKBAR_ACTIVE,
        inactiveTrackColor: AppColors.purchaseDesc,
        trackHeight: 2.0,
        thumbColor: AppColors.THUMB,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
        overlayColor: AppColors.THUMB.withAlpha(32),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
      ),
      child: GestureDetector(
        //  onHorizontalDragEnd: (detail) => _audioController
        //    .updateVolumeInTotalList(widget.volume, tag: widget.tag),
        child: Slider(
          max: 1,
          min: 0,
          value: widget.volume,
          onChanged: (value) {
            setState(() {
              widget.volume = value;
              _audioController.setVolume(value,
                  tag: widget.tag,
                  inDialog:
                      widget.fromTimer == true ? false : widget.dialogMode);
            });
          },
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
