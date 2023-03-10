import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/db/model/exercise/exercise_holder.dart';
import 'package:morningmagic/db/model/exercise/exercise_title.dart';
import 'package:morningmagic/db/model/user_program/user_program.dart';
import 'package:morningmagic/db/resource.dart';
import 'package:morningmagic/resources/colors.dart';

import 'package:morningmagic/widgets/exerciseDeskButton.dart';
import 'package:random_string/random_string.dart';

import 'exerciseTrashButton.dart';

class ExerciseDragTarget extends StatefulWidget {
  @override
  ExerciseDragTargetState createState() {
    return ExerciseDragTargetState();
  }
}

class ExerciseDragTargetState extends State<ExerciseDragTarget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (BuildContext context, List<ExerciseDeskTag> candidateData,
          List<dynamic> rejectedData) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width * 0.2,
                      bottom: MediaQuery.of(context).size.width * 0.2),
                  decoration: BoxDecoration(
                      color: candidateData.isEmpty
                          ? AppColors.transparent
                          : AppColors.transparentWhite),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisSize: MainAxisSize.min,
//                  children: getTrashButtonsList(),
//                ),
                  child: FutureBuilder(
                    future: getTrashButtonsList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ExerciseTrashTag>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: snapshot.data,
                        );
                      } else {
                        print("EMPTY !!!");
                        return Container();
                      }
                    },
                  )),
            ),
          ],
        );
      },
      onAccept: (ExerciseDeskTag button) {
        print(button.text);
        saveExerciseToHolder(button);
        saveExerciseProgram(button);

        setState(() {});
      },
    );
  }

//  List<ExerciseTrashTag> getTrashButtonsList() {
//    List<ExerciseTrashTag> list = new List<ExerciseTrashTag>();
//    if (box == null) {
//      print("BOX +++ NULL");
//      return list;
//    }
//    ExerciseHolder holder = box.get(Resource.EXERCISES_HOLDER,
//        defaultValue:
//            new ExerciseHolder(List<ExerciseTitle>(), List<ExerciseTitle>()));
//
//    for (int i = 0; i < holder.freshExercises.length; i++) {
//      list.add(new ExerciseTrashTag(holder.freshExercises[i].title,
//          holder.freshExercises[i].size, holder.freshExercises[i].key, () {
//        setState(() {});
//      }));
//    }
//
//    return list;
//  }

  List<ExerciseTrashTag> doStuff() {
    List<ExerciseTrashTag> list = <ExerciseTrashTag>[];
    UserProgram program = MyDB().getBox().get(MyResource.USER_PROGRAM_HOLDER,
        defaultValue: UserProgram(<ExerciseTitle>[]));

    ExerciseHolder holder = MyDB().getBox().get(MyResource.EXERCISES_HOLDER,
        defaultValue: ExerciseHolder(<ExerciseTitle>[], <ExerciseTitle>[]));

    holder.freshExercises.clear();
    holder.freshExercises.addAll(program.exercises);

    for (int i = 0; i < holder.freshExercises.length; i++) {
      list.add(ExerciseTrashTag(holder.freshExercises[i].title,
          holder.freshExercises[i].size, holder.freshExercises[i].key, () {
        setState(() {});
      }));
    }
    return list;
  }

  Future<List<ExerciseTrashTag>> getTrashButtonsList() async {
    List<ExerciseTrashTag> list = <ExerciseTrashTag>[];
    list = doStuff();
    return list;
  }

  void saveExerciseToHolder(ExerciseDeskTag button) {
    ExerciseHolder holder = MyDB().getBox().get(MyResource.EXERCISES_HOLDER,
        defaultValue: ExerciseHolder(<ExerciseTitle>[], <ExerciseTitle>[]));

    String key = randomAlpha(5);
    holder.freshExercises.add(ExerciseTitle(button.text, button.size, key));

    print("FRESH " + holder.freshExercises.length.toString());
    print(holder.freshExercises.toString());

    MyDB().getBox().put(MyResource.EXERCISES_HOLDER, holder);
  }

  void saveExerciseProgram(ExerciseDeskTag button) {
    UserProgram program = MyDB().getBox().get(MyResource.USER_PROGRAM_HOLDER,
        defaultValue: UserProgram(<ExerciseTitle>[]));

    String key = randomAlpha(5);
    program.exercises.add(ExerciseTitle(button.text, button.size, key));

    MyDB().getBox().put(MyResource.USER_PROGRAM_HOLDER, program);
  }
}
