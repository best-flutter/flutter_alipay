package com.jzoom.flutteralipay;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import com.alipay.sdk.app.PayTask;

import java.util.Map;


/**
 * FlutterAlipayPlugin
 */
public class FlutterAlipayPlugin implements MethodCallHandler {

  private Registrar _registrar;


  public FlutterAlipayPlugin(Registrar registrar){
    _registrar = registrar;
  }

  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_alipay");
    channel.setMethodCallHandler(new FlutterAlipayPlugin(registrar));

  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("pay")) {
      String payInfo = call.argument("payInfo");
      pay(_registrar.activity() ,payInfo,result );
    } else {
      result.notImplemented();
    }
  }


  public static void pay(final Activity currentActivity, final String payInfo, final Result callback){
    Runnable payRunnable = new Runnable() {
      @Override
      public void run() {
        try {
          PayTask alipay = new PayTask(currentActivity);
          Map<String, String> result = alipay.payV2(payInfo, true);

          callback.success(result);
        } catch (Exception e) {
          callback.error(e.getMessage(),"支付发生错误",e);
        }
      }
    };

    Thread payThread = new Thread(payRunnable);
    payThread.start();
  }
}
