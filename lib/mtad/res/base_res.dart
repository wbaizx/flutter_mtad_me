abstract class BaseRes {
  int createTime = DateTime.now().millisecondsSinceEpoch;
  Map<String, dynamic> itemData;

  BaseRes(this.itemData);

  Future<bool> checkReady(String uid);

  show(String uid);
}
