import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';

class CacheKeysManger {
  static String getUserTokenFromCache() =>
      CacheHelper.getData(key: 'accessToken') ?? '';

  static String getUserIdFromCache() =>
      CacheHelper.getData(key: 'userId') ?? '';

  static String getLastQuizFromCache() =>
      CacheHelper.getData(key: 'lastQuiz') ?? '';

}