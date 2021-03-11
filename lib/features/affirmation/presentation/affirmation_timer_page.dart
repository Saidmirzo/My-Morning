import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morningmagic/dialog/affirmation_category_dialog.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/app_gradient_container.dart';
import 'package:morningmagic/services/timer_service.dart';
import 'package:morningmagic/utils/string_util.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/circular_progress_bar/circular_progress_bar.dart';
import 'package:morningmagic/widgets/customText.dart';

import '../../../analyticService.dart';

class AffirmationTimerPage extends StatefulWidget {
  const AffirmationTimerPage({Key key}) : super(key: key);

  @override
  _AffirmationTimerPageState createState() => _AffirmationTimerPageState();
}

class _AffirmationTimerPageState extends State<AffirmationTimerPage> {
  TimerService timerService = TimerService();
  String titleText = '';
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await timerService.init(this, context, 0, null);
      titleText = timerService.affirmationText;
      if (titleText.isNotEmpty) {
        setState(() {});
      }
    });
    AnalyticService.screenView('affirmation_timer_page');
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      timerService.buttonText = 'start'.tr;
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: AppGradientContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildTimerProgress(context),
                    if (titleText.isNotEmpty)
                      Center(child: _buildTitleWidget()),
                    _buildMenuButtons(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimerProgress(BuildContext context) {
    double _timerSize, _textSize;

    _timerSize = MediaQuery.of(context).size.width * 0.45;
    _textSize = 40;

    return Padding(
      padding: const EdgeInsets.only(top: 54.0, bottom: 16),
      child: Container(
        width: _timerSize,
        child: CircularProgressBar(
          text: StringUtil.createTimeString(timerService.time),
          foregroundColor: Colors.white.withOpacity(0.8),
          backgroundColor: Colors.white.withOpacity(0.4),
          value: timerService.createValue(),
          fontSize: _textSize,
        ),
      ),
    );
  }

  Widget _buildMenuButtons(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: AnimatedButton(() => timerService.startTimer(), 'rex',
              timerService.buttonText, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: AnimatedButton(() {
            timerService.skipTask();
          }, 'rex', 'skip'.tr, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: AnimatedButton(() {
            timerService.goToHome();
          }, 'rex', 'menu'.tr, 15, null, null),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: AnimatedButton(() async {
            final _affirmation = await _showAffirmationCategoryDialog(context);
            if (_affirmation != null)
              setState(() {
                titleText = _affirmation;
              });
          }, 'rex', 'affirmation_timer'.tr, 15, null, null),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Future<String> _showAffirmationCategoryDialog(BuildContext context) async {
    return await showDialog(
        context: context, builder: (context) => AffirmationCategoryDialog());
  }

  Widget _buildTitleWidget() {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 3 / 4,
          child: CustomText(
            text: titleText,
            size: 22,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    timerService.dispose();
  }
}
