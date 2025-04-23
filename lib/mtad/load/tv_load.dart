import 'package:me_top_sdk/at_rewarded.dart';

import '../cache.dart';
import '../res/tv_res.dart';
import 'base_load.dart';

class TvLoad extends BaseLoad {
  @override
  loadId(String id) {
    ATRewardedManager.loadRewardedVideo(placementID: id, extraMap: {});
  }

  @override
  loadSus(Cache cache, Map<String, dynamic> itemData, String pid) {
    cache.putPidRes(TvRes(itemData), pid);
  }
}
