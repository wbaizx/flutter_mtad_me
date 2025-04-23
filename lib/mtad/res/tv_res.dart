import 'package:me_top_sdk/at_rewarded.dart';

import 'base_res.dart';

class TvRes extends BaseRes {
  TvRes(super.itemData);

  @override
  Future<bool> checkReady(String uid) async {
    return await ATRewardedManager.rewardedVideoReady(placementID: uid);
  }

  @override
  show(String uid) {
    ATRewardedManager.showRewardedVideo(placementID: uid);
  }
}
