import 'cache.dart';

class MtadKey {
  final String pidS;
  final String pidOne;
  final String pidTwo;

  static final Map<String, Cache> _cacheM = {};
  static final Map<String, bool> _lockMap = {};

  const MtadKey(this.pidS, this.pidOne, this.pidTwo);

  Cache getCache() {
    var cache = _cacheM[pidOne] ?? Cache(pidOne, pidTwo);
    _cacheM[pidOne] = cache;
    return cache;
  }

  bool getLock() => _lockMap[pidOne] ?? false;

  setLock(bool lock) {
    _lockMap[pidOne] = lock;
  }
}
