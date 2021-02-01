import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/audios/data/audio_data.dart';
import 'package:morningmagic/features/audios/presentation/dialogs/audio_meditation_dialog_item.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/widgets/sound_waves_diagram/my/line_box.dart';

class AudioMeditationDialog extends StatefulWidget {
  @override
  _AudioMeditationDialogState createState() => _AudioMeditationDialogState();
}

class _AudioMeditationDialogState extends State<AudioMeditationDialog> {
  LineBox lineBox = LineBox(lines: 36);

  @override
  Widget build(BuildContext context) {
    final _audioTrackNames = AudioData.audioSources.keys.toList();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'back_button'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'rex',
                              fontStyle: FontStyle.normal,
                              color: AppColors.VIOLET),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'choose'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontFamily: 'rex',
                              fontStyle: FontStyle.normal,
                              color: AppColors.VIOLET),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: _audioTrackNames.length,
                  //appStates.meditationPlaylist.value.audios.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    print(index);
                    return AudioMeditationDialogItem(
                      // audio: appStates
                      //     .meditationPlaylist.value.audios[index].path,
                      name: _audioTrackNames[index],
                      lineBox: lineBox,
                      id: index,
                      // modalSetState: modalSetState,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: lineBox,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
