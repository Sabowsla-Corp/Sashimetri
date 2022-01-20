import 'package:get_it/get_it.dart';

import 'models/sashimetrimodel.dart';
var locator = GetIt.instance;
AppData setupLocator (){
  AppData appData = AppData();

  locator.registerLazySingleton(() => AppData());
  return appData;
}