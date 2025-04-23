import 'package:applovin_max/applovin_max.dart';

import '../cache.dart';
import '../res/mv_res.dart';
import 'base_load.dart';

class MvLoad extends BaseLoad {
  @override
  loadId(String id) {
    AppLovinMAX.loadRewardedAd(id);
  }

  @override
  loadSus(Cache cache, Map<String, dynamic> itemData, String pid) {
    cache.putPidRes(MvRes(itemData), pid);
  }
}