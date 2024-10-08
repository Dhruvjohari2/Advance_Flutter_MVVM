import 'package:advance_mvvm/data/network/error_handler.dart';
import 'package:advance_mvvm/data/responses/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHome() {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMills = DateTime.now().microsecondsSinceEpoch;

    bool isCacheValid = currentTimeInMills - expirationTime < cacheTime;
    return isCacheValid;
  }
}
