import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:morningmagic/dialog/back_to_main_menu_dialog.dart';
import 'package:morningmagic/features/meditation_audio/data/meditation_audio_data.dart';
import 'package:morningmagic/features/meditation_audio/domain/entities/meditation_audio.dart';
import 'package:morningmagic/pages/meditation/selected_meditations_screen.dart';
import 'package:morningmagic/pages/menu/main_menu.dart';
import 'package:morningmagic/routing/app_routing.dart';
import 'package:morningmagic/routing/route_values.dart';
import 'package:morningmagic/services/analitics/all.dart';
import 'package:morningmagic/storage.dart';
import '../../features/meditation_audio/data/repositories/audio_repository_impl.dart';
import '../../features/meditation_audio/presentation/controller/meditation_audio_controller.dart';
import '../../resources/colors.dart';
import 'components/bg.dart';
import 'timer/meditation_timer_page.dart';

class MeditationPage extends StatefulWidget {
  final bool fromHomeMenu;
  const MeditationPage({Key key, this.fromHomeMenu = false}) : super(key: key);

  @override
  _MeditationPageState createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> {
  MediationAudioController _audioController;
  final List<MeditationAudio> _source = [];

  @override
  void initState() {
    super.initState();
    Get.put(MediationAudioController(repository: AudioRepositoryImpl()));
    _audioController = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: menuState == MenuState.MORNING
                ? AppColors.Bg_Gradient_1
                : AppColors.gradient_loading_night_bg),
        width: Get.width,
        height: Get.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            menuState == MenuState.MORNING ? bg() : bgNightMeditation(),
            Column(
              children: <Widget>[
                const Spacer(
                  flex: 3,
                ),
                BackButton(widget: widget),
                const Spacer(
                  flex: 4,
                ),
                Text(
                  'meditation'.tr.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 2,
                ),
                Text(
                  'meditation_title'.tr,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 5,
                ),
                Text(
                  'meditation_select'.tr.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const Spacer(
                  flex: 4,
                ),
                CategoryButton(
                  onClick: () {
                    onCategoryClick(
                      isMeditation: false,
                      isSilence: true,
                      newSource: [],
                      myStateNumber: isComplex ? 7 : 1,
                    );
                  },
                  text: 'meditation_menu_1'.tr,
                ),
                const Spacer(),
                CategoryButton(
                  onClick: () {
                    onCategoryClick(
                      isMeditation: false,
                      isSilence: false,
                      newSource: meditationAudioData.musicSource,
                      myStateNumber: isComplex ? 7 : 2,
                    );
                  },
                  text: 'meditation_menu_2'.tr,
                ),
                const Spacer(),
                CategoryButton(
                  onClick: () {
                    onCategoryClick(
                      newSource: Get.locale.languageCode == 'ru'
                          ? meditationAudioData.meditationRuSource
                          : meditationAudioData.meditationEnSource,
                      isMeditation: true,
                      isSilence: false,
                      myStateNumber: isComplex ? 7 : 3,
                    );
                  },
                  text: 'meditation_menu_3'.tr,
                ),
                const Spacer(),
                SelectedMusicsButton(
                  onClick: () {
                    Get.to(() => const SelectedMEditationsScreen());
                  },
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
            if (isComplex)
              Positioned(
                top: 40,
                right: 30,
                child: GestureDetector(
                  onTap: () {
                    appAnalitics.logEvent('first_menu_setings');
                    Navigator.pushNamed(context, settingsPageRoute);
                  },
                  child: Container(
                    width: 47.05,
                    height: 47.05,
                    padding: const EdgeInsets.all(12.76),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Image.asset(
                      'assets/images/home_menu/settings_icon_2.png',
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void onCategoryClick({
    Iterable<MeditationAudio> newSource,
    bool isSilence = false,
    bool isMeditation = false,
    @required int myStateNumber,
  }) {
    _audioController.selectedItemIndex.value = 0;
    _audioController.bufIdSelected.value = 0;
    _source.clear();
    _audioController = Get.find();
    _source.addAll(newSource);
    _audioController.changeAudioSource(_source);
    // _audioController.currentPage.value = MenuItems.yoga;
    Get.to(() => MeditationTimerPage(
        isSilence: isSilence,
        isMeditation: isMeditation,
        fromHomeMenu: widget.fromHomeMenu,
        mystateNumber: myStateNumber,
      ));
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({Key key, this.text, this.onClick}) : super(key: key);
  final String text;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GestureDetector(
        onTap: onClick,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 31),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(19),
                color: menuState == MenuState.NIGT
                    ? const Color(0xffFAF5FF)
                    : Colors.white.withOpacity(.56),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xff592F72),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedMusicsButton extends StatelessWidget {
  const SelectedMusicsButton({Key key, this.onClick}) : super(key: key);
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 31),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(19),
              color: const Color(0xff592F72),
              gradient: menuState == MenuState.NIGT
                  ? const LinearGradient(
                      // stops: [.1,.6,1],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffFFC672),
                        Color(0xffFF87B2),
                        Color(0xffAB49FF),
                      ],
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.53),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(5, 20),
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: menuState == MenuState.NIGT
                    ? const Color(0xff592F72)
                    : Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 5.5,
              ),
              Text(
                'Favorites'.tr,
                style: TextStyle(
                  color: menuState == MenuState.NIGT
                      ? const Color(0xff592F72)
                      : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final MeditationPage widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          if (isComplex) {
            showDialog(
              context: context,
              builder: (context) => const BackToMainMenuDialog(),
            );
          } else {
            return AppRouting.navigateToHomeWithClearHistory();
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 31),
          child: Icon(
            Icons.west,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 50),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: [
                //       SizedBox(
                //         height: 50,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             _audioController.selectedItemIndex.value = 0;
                //             _audioController.bufIdSelected.value = 0;
                //             _audioController = Get.find();
                //             _source.clear();

                //             _audioController.changeAudioSource(_source);
                //             Get.to(
                //               MeditationTimerPage(
                //                 fromHomeMenu: widget.fromHomeMenu,
                //                 isSilence: true,
                //               ),
                //             );
                //           },
                //           style: ElevatedButton.styleFrom(
                //             primary: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(100),
                //             ),
                //           ),
                //           child: Text(
                //             'meditation_menu_1'.tr.toUpperCase(),
                //             style: AppStyles.treaningSubtitle.copyWith(
                //                 color: HexColor("#592F72"),
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 17),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 15),
                //       SizedBox(
                //         height: 50,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             _audioController.selectedItemIndex.value = 0;
                //             _audioController.bufIdSelected.value = 0;
                //             _audioController = Get.find();
                //             _source.clear();
                //             _source.addAll(meditationAudioData.musicSource);
                //             _audioController.changeAudioSource(_source);
                //             Get.to(
                //               MeditationTimerPage(
                //                 fromHomeMenu: widget.fromHomeMenu,
                //               ),
                //             );
                //           },
                //           style: ElevatedButton.styleFrom(
                //             primary: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(100),
                //             ),
                //           ),
                //           child: Text(
                //             'meditation_menu_2'.tr.toUpperCase(),
                //             style: AppStyles.treaningSubtitle.copyWith(
                //                 color: HexColor("#592F72"),
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 17),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 15),
                //       SizedBox(
                //         height: 50,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             appAnalitics.logEvent('first_meditation_start');
                //             _audioController.selectedItemIndex.value = 0;
                //             _audioController.bufIdSelected.value = 0;
                //             _source.clear();
                //             _audioController = Get.find();
                //             _source.addAll(
                //               Get.locale.languageCode == 'ru'
                //                   ? meditationAudioData.meditationRuSource
                //                   : meditationAudioData.meditationEnSource,
                //             );
                //             _audioController.changeAudioSource(_source);
                //             _audioController.currentPage.value = MenuItems.yoga;
                //             Get.to(
                //               MeditationTimerPage(
                //                 isMeditation: true,
                //                 fromHomeMenu: widget.fromHomeMenu,
                //               ),
                //             );
                //           },
                //           style: ElevatedButton.styleFrom(
                //             primary: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(100),
                //             ),
                //           ),
                //           child: Text(
                //             'meditation_menu_3'.tr.toUpperCase(),
                //             style: AppStyles.treaningSubtitle.copyWith(
                //                 color: HexColor("#592F72"),
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 17),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),