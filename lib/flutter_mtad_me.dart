import 'package:applovin_max/applovin_max.dart';
import 'package:me_top_sdk/at_init.dart';

import 'mtad/cong/vnakz_config.dart';
import 'mtad/mtad_ad_lis.dart';
import 'mtad_call.dart';
import 'mtad_log.dart';

class FlutterMtadMe {
  FlutterMtadMe._();

  static bool isInit = false;
  static String? showIngId;

  static late MtadCall mtadCall;
  static late Map<String, dynamic> data;

  static updateData(Map<String, dynamic> data) {
    FlutterMtadMe.data = data;
  }

  static bool isLimit() => mtadCall.getClickCount() >= data[VnakzConfig.ovmgcpgt] || mtadCall.getShowCount() >= data[VnakzConfig.dhnigkud];

  static registerMtadCall(MtadCall mtadCall) {
    FlutterMtadMe.mtadCall = mtadCall;
  }

  static init({
    required Map<String, dynamic> data,
    required String maxKey,
    String? topId,
    String? topKey,
    required Function() initSuc,
  }) async {
    FlutterMtadMe.data = data;

    await Future.wait([_initMax(maxKey), _initTop(topId, topKey)]);
    MtadAdLis.registerAdlis();

    isInit = true;
    mtadLog("init end");

    initSuc();
  }

  static Future _initMax(String maxKey) async {
    //测试 AppLovinMAX.showMediationDebugger();
    //id MWJzhnEPtKqxLKRLAlVrTyQfO2VxWZWtVx_SzTWC_MgoZL7kTKNt9t3M_OgIZ24nBXRXxVd9ogQEp7616TWf3C
    await AppLovinMAX.initialize(maxKey);
  }

  static Future _initTop(String? topId, String? topKey) async {
    if (topId != null && topKey != null) {
      //测试 https://newdocs.toponad.com/docs/HUkrvE
      await ATInitManger.initAnyThinkSDK(appidStr: topId, appidkeyStr: topKey);
      // ATInitManger.setLogEnabled(logEnabled: true);
    }
  }
}
