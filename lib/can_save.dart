
import 'package:morningmagic/db/hive.dart';
import 'package:morningmagic/storage.dart';

class CanSave {
  static SavingModel savingModel = SavingModel();

  static bool get canSave => _canSave();

  static void changeMeditation() {
    savingModel = savingModel.copyWith(meditationWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void changeAffirmation() {
    savingModel = savingModel.copyWith(affirmationWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void changeFitness() {
    savingModel = savingModel.copyWith(affirmationWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void changeDairy() {
    savingModel = savingModel.copyWith(dairyWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void changeVisualisation() {
    savingModel = savingModel.copyWith(visualisationWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void changeReading() {
    savingModel = savingModel.copyWith(readingWasCompleted: true);
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static void resetSavingModel() {
    savingModel = SavingModel();
    myDbBox.put('savingModel', savingModel.toMap());
  }

  static final bool _whenPro = billingService.isPro()
      ? savingModel.fitnessWasCompleted &&
          savingModel.dairyWasCompleted &&
          savingModel.visualisationWasCompleted &&
          savingModel.readingWasCompleted
      : true;

  static bool _canSave() {
    return savingModel.meditationWasCompleted &&
        savingModel.affirmationWasCompleted &&
        _whenPro;
  }
}

class SavingModel {
  bool meditationWasCompleted = false;
  bool affirmationWasCompleted = false;
  bool fitnessWasCompleted = false;
  bool dairyWasCompleted = false;
  bool visualisationWasCompleted = false;
  bool readingWasCompleted = false;

  SavingModel({
    this.meditationWasCompleted = false,
    this.affirmationWasCompleted = false,
    this.fitnessWasCompleted = false,
    this.dairyWasCompleted = false,
    this.visualisationWasCompleted = false,
    this.readingWasCompleted = false,
  });

  SavingModel copyWith({
    bool meditationWasCompleted,
    bool affirmationWasCompleted,
    bool fitnessWasCompleted,
    bool dairyWasCompleted,
    bool visualisationWasCompleted,
    bool readingWasCompleted,
  }) {
    return SavingModel(
      meditationWasCompleted:
          meditationWasCompleted ?? this.meditationWasCompleted,
      affirmationWasCompleted:
          affirmationWasCompleted ?? this.affirmationWasCompleted,
      fitnessWasCompleted: fitnessWasCompleted ?? this.fitnessWasCompleted,
      dairyWasCompleted: dairyWasCompleted ?? this.dairyWasCompleted,
      visualisationWasCompleted:
          visualisationWasCompleted ?? this.visualisationWasCompleted,
      readingWasCompleted: readingWasCompleted ?? this.readingWasCompleted,
    );
  }

  

  Map<String, dynamic> toMap() {
    return {
      'meditationWasCompleted': meditationWasCompleted,
      'affirmationWasCompleted': affirmationWasCompleted,
      'fitnessWasCompleted': fitnessWasCompleted,
      'dairyWasCompleted': dairyWasCompleted,
      'visualisationWasCompleted': visualisationWasCompleted,
      'readingWasCompleted': readingWasCompleted,
    };
  }

  factory SavingModel.fromMap(Map<String, dynamic> map) {
    return SavingModel(
      meditationWasCompleted: map['meditationWasCompleted'] ?? false,
      affirmationWasCompleted: map['affirmationWasCompleted'] ?? false,
      fitnessWasCompleted: map['fitnessWasCompleted'] ?? false,
      dairyWasCompleted: map['dairyWasCompleted'] ?? false,
      visualisationWasCompleted: map['visualisationWasCompleted'] ?? false,
      readingWasCompleted: map['readingWasCompleted'] ?? false,
    );
  }
}
