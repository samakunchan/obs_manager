import 'package:get_it/get_it.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/o_b_s_service.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton<OBSService>(OBSService.new)
    ..registerLazySingleton<OBSScenesService>(OBSScenesService.new)
    ..registerLazySingleton<OBSSourcesService>(OBSSourcesService.new);
}
