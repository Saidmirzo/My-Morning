import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/app_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/custom_exercise_holder.dart';
import 'package:morningmagic/db/model/app_and_custom_exercises/exercise_name.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/dialog/exerciseDialog.dart';
import 'package:morningmagic/resources/colors.dart';
import 'package:morningmagic/utils/progress_util.dart';
import 'package:morningmagic/utils/toastUtils.dart';
import 'package:morningmagic/widgets/animatedButton.dart';
import 'package:morningmagic/widgets/exerciseDragTarget.dart';
import 'package:morningmagic/widgets/exerciseMenu.dart';

class ExerciseDeskScreen extends StatefulWidget {
  final pageId;

  const ExerciseDeskScreen({Key key, @required this.pageId}) : super(key: key);

  @override
  ExerciseDeskScreenState createState() {
    return ExerciseDeskScreenState();
  }
}

class ExerciseDeskScreenState extends State<ExerciseDeskScreen> {
  List<ExerciseName> appExercises;
  List<ExerciseName> customExercises;
  List<ExerciseName> allExercises;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    ExerciseUtils().saveExercisesNames(await MyDB().getBox());

    allExercises = new List<ExerciseName>();

    AppExerciseHolder appExerciseHolder =
        await MyDB().getBox().get(MyResource.APP_EXERCISES_HOLDER);
    appExercises = appExerciseHolder.list;
    CustomExerciseHolder customExerciseHolder = await MyDB().getBox().get(
        MyResource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));
    customExercises = customExerciseHolder.list;

    allExercises.addAll(appExercises);
    allExercises.addAll(customExercises);

    print("all exercises size " + allExercises.length.toString());
  }

  Future<List<ExerciseName>> initExerciseList() async {
    ExerciseUtils().saveExercisesNames(MyDB().getBox());
    List<ExerciseName> allList = new List<ExerciseName>();
    List<ExerciseName> appExercisesList = new List<ExerciseName>();
    List<ExerciseName> customExercisesList = new List<ExerciseName>();

    AppExerciseHolder appExerciseHolder =
        MyDB().getBox().get(MyResource.APP_EXERCISES_HOLDER);
    appExercisesList = appExerciseHolder.list;
    CustomExerciseHolder customExerciseHolder = MyDB().getBox().get(
        MyResource.CUSTOM_EXERCISES_HOLDER,
        defaultValue: CustomExerciseHolder(List<ExerciseName>()));
    customExercisesList = customExerciseHolder.list;

    allList.addAll(appExercisesList);
    allList.addAll(customExercisesList);

    print("future allList length" + allList.length.toString());

    return allList;
  }

  Widget checkWidget() {
    if (allExercises == null) {
      return FutureBuilder(
        future: initExerciseList(),
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<ExerciseName>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            allExercises = snapshot.data;
            return ExerciseMenu(allExercises, () {
              setState(() {});
            });
          } else {
            return Container();
          }
        },
      );
    } else {
      return ExerciseMenu(allExercises, () {
        setState(() {});
      });
    }
  }

  Future<bool> _onWillPop() async {
    clearExercisesHolder();
    return true;
  }

  void clearExercisesHolder() async {
    List<ExerciseTitle> skip = List<ExerciseTitle>();
    List<ExerciseTitle> fresh = List<ExerciseTitle>();
    await MyDB()
        .getBox()
        .put(MyResource.EXERCISES_HOLDER, ExerciseHolder(fresh, skip));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width, // match parent(all screen)
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.TOP_GRADIENT,
              AppColors.MIDDLE_GRADIENT,
              AppColors.BOTTOM_GRADIENT
            ],
          )),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 12),
                        child: Text(
                          'delete_hint'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontFamily: "rex",
                            color: AppColors.VIOLET,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 15),
                        child: checkWidget(),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 12),
                        child: Text(
                          'pull_program'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontFamily: "rex",
                            color: AppColors.VIOLET,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 5),
                        child: AnimatedButton(() {
                          _openDialog();
                        }, "rex", 'add_exercises'.tr(), 20, null, null),
                      ),
                      Container(
                        child: ExerciseDragTarget(),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width / 17,
                            bottom: MediaQuery.of(context).size.width / 17),
                        child: AnimatedButton(() {
                          goNextPage();
                        }, 'rex', 'start'.tr(), 20, null, null),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExerciseDialog(TextEditingController(), () {
            Navigator.pop(context, true);
          }, () {
            setState(() {});
          }, allExercises);
        });
  }

  void goNextPage() {
    saveDataToBox();
  }

  void saveDataToBox() {
    ExerciseHolder holder = MyDB().getBox().get(MyResource.EXERCISES_HOLDER);
    if (holder != null && holder.freshExercises.length > 0) {
      ExerciseTitle first = holder.freshExercises.first;
      holder.freshExercises.removeAt(0);
      holder.skipExercises.add(first);
      MyDB().getBox().put(MyResource.EXERCISES_HOLDER, holder);
      print(first.title);
      ExerciseUtils()
          .chooseExerciseAndRoute(context, first.title, widget.pageId);
    } else {
      ToastUtils.showCustomToast(context, 'add_exercise'.tr());
    }
  }

  void clearExerciseHolder() async {
    List<ExerciseTitle> skip = List<ExerciseTitle>();
    List<ExerciseTitle> fresh = List<ExerciseTitle>();
    await MyDB()
        .getBox()
        .put(MyResource.EXERCISES_HOLDER, new ExerciseHolder(fresh, skip));
  }
}
