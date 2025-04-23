import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mtad_me/mtad/load/base_load_ext.dart';
import 'package:flutter_mtad_me/mtad/res/base_res.dart';

import '../flutter_mtad_me.dart';
import '../mtad_log.dart';
import 'cong/vnakz_config.dart';
import 'mtad_ad_lis.dart';
import 'mtad_key.dart';

class ShowResCall {
  bool hasRew = false;
}

extension MtadShowExt on MtadKey {
  Future<ShowResCall?> show({BuildContext? context}) async {
    if (!FlutterMtadMe.isInit || FlutterMtadMe.showIngId != null || (FlutterMtadMe.isLimit() && !getCache().hasRes())) {
      mtadLog("show error $pidS msg=should not");
      return null;
    }

    FlutterMtadMe.mtadCall.chance(pidS);

    var res = getCache().getRes();
    var showCall = await showAction(res);

    showEnd(res);
    FlutterMtadMe.showIngId = null;
    load();

    if (showCall == null) {
      //TODO 这里可根据返回值，控制是否重试，注意需修改res和showCall
      await FlutterMtadMe.mtadCall.onShowFailed(pidS, context);
    }

    return showCall;
  }

  Future<ShowResCall?> showAction(BaseRes? res) async {
    mtadLog("showAction $pidS");

    if (res == null) {
      mtadLog("showAction no data $pidS");
      return null;
    }

    var uid = res.itemData[VnakzConfig.rbdxakdf];
    FlutterMtadMe.showIngId = uid;

    if (await res.checkReady(uid)) {
      Completer<ShowResCall?> completer = Completer();
      var showRes = ShowResCall();

      MtadAdLis.getLis(uid)
        ..onAdDisplayedCallback = (ad) {
          mtadLog("onShow $pidS");
          FlutterMtadMe.mtadCall.onShow();
        }
        ..onAdHiddenCallback = (ad) {
          mtadLog("onHide $pidS");
          completer.complete(showRes);
        }
        ..onAdDisplayFailedCallback = (ad, error) {
          completer.complete(null);
        }
        ..onAdClickedCallback = (ad) {
          FlutterMtadMe.mtadCall.onClick();
        }
        ..onAdRevenuePaidCallback = (ad) {
          //广告事件上报
          FlutterMtadMe.mtadCall.onRevenuePaid(ad, pidS, res.itemData);
        }
        ..onAdReceivedRewardCallback = (ad) {
          showRes.hasRew = true;
        };

      res.show(uid);
      return completer.future;
    }

    return null;
  }

  showEnd(BaseRes? res) {
    mtadLog("showEnd $pidS");

    if (res != null) {
      MtadAdLis.getLis(res.itemData[VnakzConfig.rbdxakdf])
        ..onAdDisplayedCallback = null
        ..onAdClickedCallback = null
        ..onAdHiddenCallback = null
        ..onAdDisplayFailedCallback = null;
    }
  }
}
