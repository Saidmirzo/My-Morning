import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:morningmagic/features/fitness/data/fitness_data_generator.dart';
import 'package:morningmagic/features/fitness/domain/entities/exercise/fitness_exercise.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialog_header_button.dart';
import 'package:morningmagic/features/fitness/presentation/widgets/dialogs/create_own_exercise_dialog.dart';
import 'package:morningmagic/resources/colors.dart';
import '../dialog_footer_button.dart';
import '../styled_text.dart';

typedef FitnessExerciseCallback = void Function(FitnessExercise exercise);

class AddExerciseDialog extends StatefulWidget {
  final List<FitnessExercise> initialExercises;

  const AddExerciseDialog({Key key, @required this.initialExercises})
      : super(key: key);

  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final List<FitnessExercise> _defaultExercises =
      FitnessDataGenerator.generateDefaultExercises();

  List<FitnessExercise> _initialExercises;

  final List<FitnessExercise> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
    _initialExercises = _defaultExercises
        .where((element) => !(widget.initialExercises.contains(element)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                DialogHeaderButton(
                    text: 'back_button'.tr,
                    onTap: () => Navigator.pop(context)),
                const Spacer(),
                DialogHeaderButton(
                  text: 'save'.tr,
                  onTap: () => Navigator.pop(context, _selectedExercises),
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              StyledText(
                'exercises'.tr,
                fontSize: 20,
                color: Colors.blueGrey,
              ),
              const SizedBox(
                height: 8,
              ),
              (_initialExercises.isEmpty)
                  ? Expanded(
                      child: Center(
                          child: StyledText(
                      'initial_exercises_empty'.tr,
                      textAlign: TextAlign.center,
                      fontSize: 18,
                      color: Colors.blueGrey,
                    )))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _initialExercises.length,
                        itemBuilder: (context, index) =>
                            ExerciseAddExerciseDialogItem(
                          exercise: _initialExercises[index],
                          isSelected: _selectedExercises
                              .contains(_initialExercises[index]),
                          onItemSelected: (value) {
                            if (_selectedExercises.contains(value)) {
                              _selectedExercises.remove(value);
                            } else {
                              _selectedExercises.add(value);
                            }
                          },
                        ),
                      ),
                    ),
              DialogFooterButton(
                  text: 'add_yours'.tr,
                  onPressed: () => _openCreateOwnExerciseDialog(context)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCreateOwnExerciseDialog(BuildContext context) async {
    final _exerciseResult = await showDialog(
      context: context,
      builder: (context) => const CreateOwnExerciseDialog(),
    );
    if (_exerciseResult != null) {
      setState(() {
        _initialExercises.add(_exerciseResult);
        _selectedExercises.add(_exerciseResult);
      });
    }
  }
}

class ExerciseAddExerciseDialogItem extends StatefulWidget {
  final FitnessExercise exercise;
  final bool isSelected;
  final FitnessExerciseCallback onItemSelected;

  const ExerciseAddExerciseDialogItem(
      {Key key,
      @required this.exercise,
      @required this.isSelected,
      @required this.onItemSelected})
      : super(key: key);

  @override
  _ExerciseAddExerciseDialogItemState createState() =>
      _ExerciseAddExerciseDialogItemState();
}

class _ExerciseAddExerciseDialogItemState
    extends State<ExerciseAddExerciseDialogItem> {
  bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _selectItem,
        child: isSelected ? _buildSelectedItem() : _buildUnselectedItem());
  }

  Container _buildSelectedItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: const BoxDecoration(
          color: AppColors.LIGHT_VIOLET,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8.0, top: 12, bottom: 8),
              child: StyledText(
                widget.exercise.name,
                color: AppColors.WHITE,
                fontSize: 18,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.check,
              color: AppColors.WHITE,
            ),
          ),
        ],
      ),
    );
  }

  Container _buildUnselectedItem() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColors.LIGHT_VIOLET),
          borderRadius: const BorderRadius.all(Radius.circular(40))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 8.0, top: 12, bottom: 8),
              child: StyledText(
                widget.exercise.name,
                color: AppColors.LIGHT_VIOLET,
                fontSize: 18,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.add,
              color: AppColors.LIGHT_VIOLET,
            ),
          ),
        ],
      ),
    );
  }

  void _selectItem() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onItemSelected(widget.exercise);
  }
}
