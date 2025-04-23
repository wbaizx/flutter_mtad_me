import 'package:flutter_mtad_me/mtad/res/base_res.dart';

import 'flutter_mtad_me.dart';
import 'mtad_log.dart';

class Cache {
  final String pidOne;
  final String pidTwo;
  final Map<String, List<BaseRes>> pidMap = {};

  Cache(this.pidOne, this.pidTwo) {
    pidMap[pidOne] = [];
    pidMap[pidTwo] = [];
  }

  bool hasRes() {
    return checkPidRes(pidOne) || checkPidRes(pidTwo);
  }

  bool fullRes() {
    return checkPidRes(pidOne) && checkPidRes(pidTwo);
  }

  bool checkPidRes(String pid) {
    var list = pidMap[pid]!;
    _checkOutRes(list);
    return list.isNotEmpty;
  }

  putPidRes(BaseRes res, String pid) {
    var cacheList = pidMap[pid]!;
    cacheList.add(res);
    mtadLog("putRes $pidOne size=${pidMap[pidOne]?.length} $pidTwo size=${pidMap[pidTwo]?.length}");
  }

  BaseRes? getRes() => _getPidRes(pidOne) ?? _getPidRes(pidTwo);

  _getPidRes(String pid) {
    var list = pidMap[pid]!;
    _checkOutRes(list);
    if (list.isNotEmpty) {
      return list.removeAt(0);
    }
    return null;
  }

  _checkOutRes(List<BaseRes> list) {
    list.removeWhere((element) {
      int useTime = (DateTime.now().millisecondsSinceEpoch - element.createTime) ~/ 1000;
      int time = element.itemData[FlutterMtadMe.jsonMapping[MTAD_JSON_TIME]];
      return useTime > time;
    });
  }
}
