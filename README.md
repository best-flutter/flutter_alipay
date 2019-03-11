# flutter_alipay
A flutter plugin to use alipay.


有任何问题，欢迎加入qq群854192563交流


## Features


## Install

Add this to your package's pubspec.yaml file:
```
dependencies:
  flutter_alipay: "^0.1.0"
```

## Getting Started

### Android

 Add following permissions to your AndroidManifest.xml
 
 ```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
 ```
 ### iOS

Step 1: Add a URL scheme in info.plist

```plist
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Viewer</string>
            <key>CFBundleURLName</key>
            <string>alipay</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>alipay</string>
            </array>
            </dict>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLName</key>
            <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>your app's scheme</string>
            </array>
        </dict>
    </array>
```

Step 2: In AppDelegate.m, do header import

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

### In Dart

```
import 'package:flutter_alipay/flutter_alipay.dart';
```

```
var result = await FlutterAlipay.pay("you pay info from server");
```

### Using flutter_alipay in Swift

Edit `Runner-Bridging-Header.h`,add

```
#import <flutter_alipay/FlutterAlipayPlugin.h>

```

Edit `AppDelegate.swift`,add

```

 override func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return FlutterAlipayPlugin.handleOpen(url);
    }
```


