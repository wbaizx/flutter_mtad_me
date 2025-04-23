import 'dart:async';

import 'package:flutter_mtad_me/mtad/load/ti_load.dart';
import 'package:flutter_mtad_me/mtad/load/tv_load.dart';

import '../../flutter_mtad_me.dart';
import '../../mtad_log.dart';
import '../cong/vnakz_config.dart';
import '../mtad_key.dart';
import 'base_load.dart';
import 'mi_load.dart';
import 'mv_load.dart';

extension BaseLoadExt on MtadKey {
  static Map<String, Map<String, BaseLoad>> loadMap = {
    "max": {"interstitial": MiLoad(), "reward": MvLoad()},
    "topon": {"interstitial": TiLoad(), "reward": TvLoad()},
  };

  load() async {
    if (!FlutterMtadMe.isInit || FlutterMtadMe.isLimit() || getCache().fullRes() || getLock()) {
      mtadLog("load block $pidS");
      return;
    }

    mtadLog("load $pidS");

    setLock(true);

    while (true) {
      var list = await Future.wait([loadItem(pidOne), loadItem(pidTwo)]);
      if (list.every((v) => v)) break;

      await Future.delayed(const Duration(milliseconds: 2500));
    }
    setLock(false);

    mtadLog("load end ------");
  }

  Future<bool> loadItem(String pid) async {
    if (getCache().checkPidRes(pid)) {
      return true;
    }

    List<Map<String, dynamic>>? items = getItems(pid);
    if (items == null || items.isEmpty) return true;

    for (var itemData in items) {
      if (FlutterMtadMe.showIngId == itemData[VnakzConfig.rbdxakdf]) {
        return true;
      }

      var loader = getLoad(itemData);
      if (loader != null) {
        try {
          await loader.load(this, itemData, pid).timeout(const Duration(seconds: 50));
        } catch (e) {
          mtadLog("loadItem catch $pid e=$e");
        }
        if (getCache().checkPidRes(pid)) {
          return true;
        }
      }
    }

    return getCache().checkPidRes(pid);
  }

  BaseLoad? getLoad(Map<String, dynamic> itemData) {
    return loadMap[itemData[VnakzConfig.bggzmyak]]?[itemData[VnakzConfig.bpulceyf]];
  }

  List<Map<String, dynamic>>? getItems(String pid) {
    try {
      var list = List<Map<String, dynamic>>.from(FlutterMtadMe.data[pid]);
      list.sort((a, b) => b[VnakzConfig.ctrisehr].compareTo(a[VnakzConfig.ctrisehr]));
      return list;
    } catch (e) {
      mtadLog("$pid no items");
    }
    return null;
  }
}
