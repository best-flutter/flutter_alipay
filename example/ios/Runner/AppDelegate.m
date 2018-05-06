#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterAlipayPlugin.h"

@implementation AppDelegate


-(NSString*)fetchUrlScheme{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSArray* types = [infoDic objectForKey:@"CFBundleURLTypes"];
    for(NSDictionary* dic in types){
        if([@"alipay" isEqualToString:  [dic objectForKey:@"CFBundleURLName"]]){
            return [dic objectForKey:@"CFBundleURLSchemes"][0];
        }
    }
    return nil;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
    NSLog(@"==========%@",[self fetchUrlScheme]);
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
     // ios 8.x or older
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [FlutterAlipayPlugin handleOpenURL:url];
}
// ios 9.0+
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     return [FlutterAlipayPlugin handleOpenURL:url];
}

@end
