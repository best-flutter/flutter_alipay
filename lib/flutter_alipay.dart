import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAlipay {
  static const MethodChannel _channel =
      const MethodChannel('flutter_alipay');

  static Future<dynamic> pay(String payInfo) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'payInfo': payInfo,
    };
    return await _channel.invokeMethod('pay',params);
  }
}
