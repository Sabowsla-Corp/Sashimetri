import 'package:get_it/get_it.dart';

import 'models/app_data.dart';
var locator = GetIt.instance;
AppData setupLocator (){
  AppData appData = AppData();

  locator.registerLazySingleton(() => AppData());
  return appData;
}