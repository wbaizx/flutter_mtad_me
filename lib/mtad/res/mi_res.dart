import 'package:applovin_max/applovin_max.dart';

import 'base_res.dart';

class MiRes extends BaseRes {
  MiRes(super.itemData);

  @override
  Future<bool> checkReady(String uid) async {
    return await AppLovinMAX.isInterstitialReady(uid) ?? false;
  }

  @override
  show(String uid) {
    AppLovinMAX.showInterstitial(uid);
  }
}
