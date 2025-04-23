import 'dart:async';

import '../../mtad_log.dart';
import '../cache.dart';
import '../cong/vnakz_config.dart';
import '../mtad_ad_lis.dart';
import '../mtad_key.dart';

abstract class BaseLoad {
  Future load(MtadKey key, Map<String, dynamic> itemData, String pid) async {
    String id = itemData[VnakzConfig.rbdxakdf];
    mtadLog("loader $pid id=$id");

    Completer completer = Completer();

    var lis = MtadAdLis.getLis(id);
    lis.onAdLoadedCallback = (ad) {
      mtadLog("loader success $pid id=$id");
      loadSus(key.getCache(), itemData, pid);
      completer.complete();
    };

    lis.onAdLoadFailedCallback = (adUnitId, error) {
      mtadLog("loader failed $pid id=$adUnitId error=$error");
      completer.complete();
    };

    loadId(id);

    return completer.future;
  }

  loadSus(Cache cache, Map<String, dynamic> itemData, String pid);

  loadId(String id);
}
