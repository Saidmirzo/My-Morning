import 'package:get_it/get_it.dart';
import 'package:morningmagic/services/ab_testing_service.dart';

GetIt injection = GetIt.I;

// TODO: - add all services to di
// TODO: - add all services via constructor through whole app
Future setInjections() async {
  injection.registerLazySingleton<ABTestingService>(
    () => ABTestingService(),
  );
}
