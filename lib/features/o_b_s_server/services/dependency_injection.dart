import 'package:get_it/get_it.dart';
import 'package:obs_manager/features/o_b_s_server/services/o_b_s_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<OBSService>(OBSService.new);
}
