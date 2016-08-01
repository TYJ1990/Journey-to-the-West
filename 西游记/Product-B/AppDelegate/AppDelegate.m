//
//  AppDelegate.m
//  Product-B
//
//  Created by lanou on 16/7/11.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppDelegate.h"
#import "MyTabBarViewController.h"
#import "LoadingViewController.h"
@interface AppDelegate ()
@property (nonatomic,strong) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible ];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"first"]) {
        MyTabBarViewController *my = [[MyTabBarViewController alloc]init];
        self.window.rootViewController = my;
    }else{
        LoadingViewController *loadVC = [[LoadingViewController alloc] init];
        self.window.rootViewController = loadVC;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
    }
    
    
    self.mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.mapManager start:@"mOYxA7oOGVBEFpdbP4Dmx4bv1ZyxfDD4"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [ShareSDK registerApp:@"152c89b7ecb4f"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
                default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243" appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"  redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885" appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282" appKey:@"aed9b0303e3ed1e27bae87c33761161d" authType:SSDKAuthTypeBoth];
                 break;
                default:
                 break;
         }
     }];
    EMOptions *options = [EMOptions optionsWithAppkey:@"sj1910#yiluxiangxi"];
  //  options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
    [NSThread sleepForTimeInterval:3.0];
        return YES;
}

-(CGRect)createFrimeWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height{
    return CGRectMake(x*(kScreenWidth/375.0), y*(kScreenHeight/667.0), width*(kScreenWidth/375.0), height*(kScreenHeight/667));
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
