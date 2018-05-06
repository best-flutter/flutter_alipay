#import "FlutterAlipayPlugin.h"

#import <AlipaySDK/AlipaySDK.h>


__weak FlutterAlipayPlugin* __FlutterAlipayPlugin;

@interface FlutterAlipayPlugin()

@property (readwrite,copy,nonatomic) FlutterResult callback;

@end

@implementation FlutterAlipayPlugin

-(id)init{
    if(self = [super init]){
        
        __FlutterAlipayPlugin  = self;
        
    }
    return self;
}

-(void)dealloc{
    
}



+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_alipay"
            binaryMessenger:[registrar messenger]];
  FlutterAlipayPlugin* instance = [[FlutterAlipayPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}


//
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    
    NSDictionary *arguments = [call arguments];
    
    if ([@"pay" isEqualToString:call.method]) {
        NSString* urlScheme = [self fetchUrlScheme];
        if(!urlScheme){
            NSLog(@"alipay cannot be found in info.plist,please visit https://github.com/jzoom/flutter_alipay.");
          return;
        }
      self.callback = result;
      [self pay:arguments[@"payInfo"] urlScheme:urlScheme];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

-(NSString*)fetchUrlScheme{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray* types = [infoDic objectForKey:@"CFBundleURLTypes"];
    for(NSDictionary* dic in types){
        if([@"alipay" isEqualToString: [dic objectForKey:@"CFBundleURLName"]]){
            return [dic objectForKey:@"CFBundleURLSchemes"][0];
        }
    }
    return nil;
}

+(BOOL)handleOpenURL:(NSURL*)url{
    if(!__FlutterAlipayPlugin)return NO;
    return [__FlutterAlipayPlugin handleOpenURL:url];
    
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


@end
