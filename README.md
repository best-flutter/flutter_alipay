# flutter_alipay


A flutter plugin to use alipay.


## Features


## Install

Add this to your package's pubspec.yaml file:
```
dependencies:
  flutter_alipay: "^0.1.0"
```

## Getting Started

* Android

 * Add following permissions to your AndroidManifest.xml
 ```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

 ```

* ios

 * Add a URL scheme in info.plist

```
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleURLName</key>
            <string>alipay</string>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>YOUR APP SCHEME NAME</string>
            </array>
        </dict>
    </array>
```

 Make sure you have a CFBundleURLName=alipay in CFBundleURLTypes.


 * In AppDelegate.m, do header import

 ```
 #import "FlutterAlipayPlugin.h"
 ```

 and add following code

```
     // ios 8.x or older
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

    return [FlutterAlipayPlugin handleOpenURL:url];
}
// ios 9.0+
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     return [FlutterAlipayPlugin handleOpenURL:url];
}

 ```

 ## How to use
```
import 'package:flutter_alipay/flutter_alipay.dart';
```

```
var result = await FlutterAlipay.pay("you pay info from server");
```
