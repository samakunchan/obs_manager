import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:obs_manager/features/app_lifecycle/app_lifecycle.dart';
import 'package:obs_manager/features/o_b_s_scenes/o_b_s_scenes.dart';
import 'package:obs_manager/features/o_b_s_server/services/fake_services.dart';
import 'package:obs_manager/features/o_b_s_server/services/o_b_s_service.dart';
import 'package:obs_manager/features/o_b_s_sound/o_b_s_sound.dart';
import 'package:obs_manager/features/o_b_s_sources/o_b_s_sources.dart';
import 'package:obs_manager/features/persistances/persistances.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

void setupLocator(SharedPreferences prefs) {
  getIt
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerLazySingleton<PersistancesService>(() => PersistancesService(getIt<SharedPreferences>()))
    ..registerLazySingleton<PersistancesLogsService>(() => PersistancesLogsService(getIt<SharedPreferences>()))
    ..registerLazySingleton<PersistancesScenesService>(() => PersistancesScenesService(getIt<SharedPreferences>()));

  if (kIsWeb) {
    getIt
      ..registerLazySingleton<OBSService>(FakeOBSService.new)
      ..registerLazySingleton<OBSScenesService>(FakeOBSScenesService.new)
      ..registerLazySingleton<OBSSourcesService>(FakeOBSSourcesService.new)
      ..registerLazySingleton<OBSSoundService>(FakeOBSSoundService.new);
  } else {
    getIt
      ..registerLazySingleton<OBSService>(OBSService.new)
      ..registerLazySingleton<OBSScenesService>(OBSScenesService.new)
      ..registerLazySingleton<OBSSourcesService>(OBSSourcesService.new)
      ..registerLazySingleton<OBSSoundService>(OBSSoundService.new);
  }

  getIt.registerLazySingleton<AppLifecycleService>(AppLifecycleService.new);
}
