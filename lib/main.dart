import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/local/sql/sql_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/root/app_root.dart';

import 'cubit/observer/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await SqlHelper.initDB();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  print(CacheKeysManger.getUserTokenFromCache());
  runApp(const AppRoot());
}
