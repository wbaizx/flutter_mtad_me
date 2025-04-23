import 'package:applovin_max/applovin_max.dart';

import 'base_res.dart';

class MvRes extends BaseRes {
  MvRes(super.itemData);

  @override
  Future<bool> checkReady(String uid) async {
    return await AppLovinMAX.isRewardedAdReady(uid) ?? false;
  }

  @override
  show(String uid) {
    AppLovinMAX.showRewardedAd(uid);
  }
}
