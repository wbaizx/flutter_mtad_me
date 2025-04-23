import 'package:me_top_sdk/at_interstitial.dart';

import 'base_res.dart';

class TiRes extends BaseRes {
  TiRes(super.itemData);

  @override
  Future<bool> checkReady(String uid) async {
    return await ATInterstitialManager.hasInterstitialAdReady(placementID: uid);
  }

  @override
  show(String uid) {
    ATInterstitialManager.showInterstitialAd(placementID: uid);
  }
}
