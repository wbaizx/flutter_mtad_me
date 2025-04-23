import 'package:applovin_max/applovin_max.dart';
import 'package:me_top_sdk/at_interstitial_response.dart';
import 'package:me_top_sdk/at_listener.dart';
import 'package:me_top_sdk/at_rewarded_response.dart';

class MtadAdLis {
  static final Map<String, MtadAdLis> registerMap = {};

  MtadAdLis._();

  static MtadAdLis getLis(String uid) {
    var cal = registerMap[uid] ?? MtadAdLis._();
    registerMap[uid] = cal;
    return cal;
  }

  Function(dynamic ad)? onAdLoadedCallback;
  Function(String adUnitId, dynamic error)? onAdLoadFailedCallback;
  Function(dynamic ad)? onAdDisplayedCallback;
  Function(dynamic ad, dynamic error)? onAdDisplayFailedCallback;
  Function(dynamic ad)? onAdClickedCallback;
  Function(dynamic ad)? onAdHiddenCallback;
  Function(dynamic ad)? onAdRevenuePaidCallback;
  Function(dynamic ad)? onAdReceivedRewardCallback;

  static registerAdlis() {
    AppLovinMAX.setRewardedAdListener(
      RewardedAdListener(
        onAdLoadedCallback: (ad) {
          getLis(ad.adUnitId).onAdLoadedCallback?.call(ad);
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          getLis(adUnitId).onAdLoadFailedCallback?.call(adUnitId, error);
        },
        onAdDisplayedCallback: (ad) {
          getLis(ad.adUnitId).onAdDisplayedCallback?.call(ad);
        },
        onAdDisplayFailedCallback: (ad, error) {
          getLis(ad.adUnitId).onAdDisplayFailedCallback?.call(ad, error);
        },
        onAdClickedCallback: (ad) {
          getLis(ad.adUnitId).onAdClickedCallback?.call(ad);
        },
        onAdHiddenCallback: (ad) {
          getLis(ad.adUnitId).onAdHiddenCallback?.call(ad);
        },
        onAdRevenuePaidCallback: (ad) {
          getLis(ad.adUnitId).onAdRevenuePaidCallback?.call(ad);
        },
        onAdReceivedRewardCallback: (ad, reward) {
          getLis(ad.adUnitId).onAdReceivedRewardCallback?.call(ad);
        },
      ),
    );

    AppLovinMAX.setInterstitialListener(
      InterstitialListener(
        onAdLoadedCallback: (ad) {
          getLis(ad.adUnitId).onAdLoadedCallback?.call(ad);
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          getLis(adUnitId).onAdLoadFailedCallback?.call(adUnitId, error);
        },
        onAdDisplayedCallback: (ad) {
          getLis(ad.adUnitId).onAdDisplayedCallback?.call(ad);
        },
        onAdDisplayFailedCallback: (ad, error) {
          getLis(ad.adUnitId).onAdDisplayFailedCallback?.call(ad, error);
        },
        onAdClickedCallback: (ad) {
          getLis(ad.adUnitId).onAdClickedCallback?.call(ad);
        },
        onAdHiddenCallback: (ad) {
          getLis(ad.adUnitId).onAdHiddenCallback?.call(ad);
        },
        onAdRevenuePaidCallback: (ad) {
          getLis(ad.adUnitId).onAdRevenuePaidCallback?.call(ad);
        },
      ),
    );

    ATListenerManager.rewardedVideoEventHandler.listen((value) {
      switch (value.rewardStatus) {
        //广告加载失败
        case RewardedStatus.rewardedVideoDidFailToLoad:
          getLis(value.placementID).onAdLoadFailedCallback?.call(value.placementID, value.requestMessage);
          break;
        //广告加载成功
        case RewardedStatus.rewardedVideoDidFinishLoading:
          getLis(value.placementID).onAdLoadedCallback?.call(value.extraMap);
          break;
        //广告开始播放
        case RewardedStatus.rewardedVideoDidStartPlaying:
          getLis(value.placementID).onAdDisplayedCallback?.call(value.extraMap);
          getLis(value.placementID).onAdRevenuePaidCallback?.call(value.extraMap);
          break;
        case RewardedStatus.rewardedVideoDidEndPlaying:
          break;
        //广告播放失败
        case RewardedStatus.rewardedVideoDidFailToPlay:
          getLis(value.placementID).onAdDisplayFailedCallback?.call(value.extraMap, value.requestMessage);
          break;
        //激励成功，建议在此回调中下发奖励
        case RewardedStatus.rewardedVideoDidRewardSuccess:
          getLis(value.placementID).onAdReceivedRewardCallback?.call(value.extraMap);
          break;
        //广告被点击
        case RewardedStatus.rewardedVideoDidClick:
          getLis(value.placementID).onAdClickedCallback?.call(value.extraMap);
          break;
        case RewardedStatus.rewardedVideoDidDeepLink:
          break;
        //广告被关闭
        case RewardedStatus.rewardedVideoDidClose:
          getLis(value.placementID).onAdHiddenCallback?.call(value.extraMap);
          break;
        //广告开始播放（只针对穿山甲的再看一个广告）
        case RewardedStatus.rewardedVideoDidAgainStartPlaying:
          break;
        //广告结束播放（只针对穿山甲的再看一个广告）
        case RewardedStatus.rewardedVideoDidAgainEndPlaying:
          break;
        //广告播放失败（只针对穿山甲的再看一个广告）
        case RewardedStatus.rewardedVideoDidAgainFailToPlay:
          break;
        //激励成功（只针对穿山甲的再看一个广告）
        case RewardedStatus.rewardedVideoDidAgainRewardSuccess:
          break;
        //广告被点击（只针对穿山甲的再看一个广告）
        case RewardedStatus.rewardedVideoDidAgainClick:
        case RewardedStatus.rewardedVideoUnknown:
          break;
      }
    });

    ATListenerManager.interstitialEventHandler.listen((value) {
      switch (value.interstatus) {
        //广告加载失败
        case InterstitialStatus.interstitialAdFailToLoadAD:
          getLis(value.placementID).onAdLoadFailedCallback?.call(value.placementID, value.requestMessage);
          break;
        //广告加载成功
        case InterstitialStatus.interstitialAdDidFinishLoading:
          getLis(value.placementID).onAdLoadedCallback?.call(value.extraMap);
          break;
        case InterstitialStatus.interstitialAdDidStartPlaying:
          break;
        case InterstitialStatus.interstitialAdDidEndPlaying:
          break;
        case InterstitialStatus.interstitialDidFailToPlayVideo:
          break;
        //广告展示成功
        case InterstitialStatus.interstitialDidShowSucceed:
          getLis(value.placementID).onAdDisplayedCallback?.call(value.extraMap);
          getLis(value.placementID).onAdRevenuePaidCallback?.call(value.extraMap);
          break;
        //广告展示失败
        case InterstitialStatus.interstitialFailedToShow:
          getLis(value.placementID).onAdDisplayFailedCallback?.call(value.extraMap, value.requestMessage);
          break;
        //广告被点击
        case InterstitialStatus.interstitialAdDidClick:
          getLis(value.placementID).onAdClickedCallback?.call(value.extraMap);
          break;
        case InterstitialStatus.interstitialAdDidDeepLink:
          break;
        //广告被关闭
        case InterstitialStatus.interstitialAdDidClose:
          getLis(value.placementID).onAdHiddenCallback?.call(value.extraMap);
          break;
        case InterstitialStatus.interstitialUnknown:
          break;
      }
    });
  }
}
