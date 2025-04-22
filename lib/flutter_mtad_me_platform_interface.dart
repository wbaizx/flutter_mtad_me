import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';


 class FlutterMtadMePlatform extends PlatformInterface {
  FlutterMtadMePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMtadMePlatform _instance = FlutterMtadMePlatform();

  static FlutterMtadMePlatform get instance => _instance;

  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_mtad_me');

  static set instance(FlutterMtadMePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
