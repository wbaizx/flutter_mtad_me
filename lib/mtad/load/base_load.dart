import 'dart:async';

import '../cache.dart';
import '../flutter_mtad_me.dart';
import '../mtad_ad_lis.dart';
import '../mtad_key.dart';
import '../mtad_log.dart';

abstract class BaseLoad {
  Future load(MtadKey key, Map<String, dynamic> itemData, String pid) async {
    String id = itemData[FlutterMtadMe.jsonMapping[MTAD_JSON_ID]];

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
