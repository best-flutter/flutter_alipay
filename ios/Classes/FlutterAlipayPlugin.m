#import "FlutterAlipayPlugin.h"

#import <AlipaySDK/AlipaySDK.h>



@interface FlutterAlipayPlugin()

@property (readwrite,copy,nonatomic) FlutterResult callback;

@property (nonatomic) NSString* urlScheme;

@end

@implementation FlutterAlipayPlugin



+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_alipay"
                                     binaryMessenger:[registrar messenger]];
    FlutterAlipayPlugin* instance = [[FlutterAlipayPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
    [registrar addApplicationDelegate:instance];
}





//
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    NSDictionary *arguments = [call arguments];
    
    if ([@"pay" isEqualToString:call.method]) {
        self.callback = result;
        [self pay:arguments[@"payInfo"] urlScheme:self.urlScheme ? self.urlScheme : @"org.zoomdev.flutter.alipay"];
    }else  if ([@"isInstalled" isEqualToString:call.method]){
        BOOL isInstalled = [UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:@"alipay:"]];
        result(@{
            @"result":@(isInstalled)
        });
    }else if([@"setIosUrlSchema" isEqualToString:call.method]){
        self.urlScheme =  arguments[@"schema"];
        result(@{});
    } else {
        result(FlutterMethodNotImplemented);
    }
}



-(BOOL)handleOpenURL:(NSURL*)url{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        __weak FlutterAlipayPlugin* __self = self;
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [__self onGetResult:resultDic];
        }];
        
        return YES;
    }
    return NO;
}

-(void)pay:(NSString*)payInfo urlScheme:(NSString*)urlScheme{
    //获取到CFBundleURLSchemes
    [[AlipaySDK defaultService] payOrder:payInfo fromScheme:urlScheme callback:^(NSDictionary *resultDic) {
        //NSLog(@"%@",resultDic);
        [self onGetResult:resultDic];
    }];
}




-(void)onGetResult:(NSDictionary*)resultDic{
    if(self.callback!=nil){
        self.callback(resultDic);
        self.callback = nil;
    }
    
}


#pragma ApplicatioonLifeCycle

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id>*)options{
    return [self handleOpenURL:url];
}

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)url{
    return [self handleOpenURL:url];
}

/**
 * Called if this has been registered for `UIApplicationDelegate` callbacks.
 *
 * @return `YES` if this handles the request.
 */
- (BOOL)application:(UIApplication*)application
            openURL:(NSURL*)url
  sourceApplication:(NSString*)sourceApplication
         annotation:(id)annotation{
    return [self handleOpenURL:url];
}


@end
