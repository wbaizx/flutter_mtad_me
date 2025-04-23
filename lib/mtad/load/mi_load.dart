import 'package:applovin_max/applovin_max.dart';

import '../cache.dart';
import '../res/mi_res.dart';
import 'base_load.dart';

class MiLoad extends BaseLoad {
  @override
  loadId(String id) {
    AppLovinMAX.loadInterstitial(id);
  }

  @override
  loadSus(Cache cache, Map<String, dynamic> itemData, String pid) {
    cache.putPidRes(MiRes(itemData), pid);
  }
}
