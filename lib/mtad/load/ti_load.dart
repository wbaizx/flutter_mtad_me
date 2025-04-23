import 'package:me_top_sdk/at_interstitial.dart';

import '../cache.dart';
import '../res/ti_res.dart';
import 'base_load.dart';

class TiLoad extends BaseLoad {
  @override
  loadId(String id) {
    ATInterstitialManager.loadInterstitialAd(placementID: id, extraMap: {});
  }

  @override
  loadSus(Cache cache, Map<String, dynamic> itemData, String pid) {
    cache.putPidRes(TiRes(itemData), pid);
  }
}
