import 'package:flutter/cupertino.dart';

class MtadCall {
  int Function() getClickCount;
  int Function() getShowCount;
  Function(String pidS) chance;
  Function() onShow;
  Function() onClick;
  Function(dynamic ad, String pidS, Map<String, dynamic> itemData) onRevenuePaid;
  Future<bool?> Function(String pidS, BuildContext? context) onShowFailed;

  MtadCall({
    required this.getClickCount,
    required this.getShowCount,
    required this.chance,
    required this.onShow,
    required this.onClick,
    required this.onRevenuePaid,
    required this.onShowFailed,
  });
}
