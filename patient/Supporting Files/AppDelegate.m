//
//  AppDelegate.m
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "NetworkMonitorUtil.h"
#import "LocationUtil.h"
#import "JPUSHService.h"
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialLaiwangHandler.h>
#import <UMSocialFacebookHandler.h>
#import <UMSocialTwitterHandler.h>
#import "BaseTabBarController.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (strong,nonatomic)CLLocationManager *locationManger;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self getRelatedInformation];
    [self checkNetworkStatus];
    [self startLocation];
    [self startPush:launchOptions];
    [self startAnalytic];
    [self startSocial];
    [self initRootWindow];
    return YES;
}

#pragma mark getRelatedInformation
-(void)getRelatedInformation{
    DLog(@"CountryCode-->%@",[LocationUtil getCountryCode]);
    DLog(@"LanguageCode-->%@",[LocationUtil getLanguageCode]);
    DLog(@"LanguageCollatorIdentifierCode-->%@",[LocationUtil getLanguageCollatorIdentifierCode]);
    DLog(@"NSLocaleCurrencyCode-->%@",[LocationUtil getNSLocaleCurrencyCode]);
    DLog(@"NSLocaleCurrencySymbol-->%@",[LocationUtil getNSLocaleCurrencySymbol]);
    DLog(@"LanguageType-->%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]);
}

#pragma mark checkNetworkStatus
-(void)checkNetworkStatus{
    [[NetworkMonitorUtil sharedInstance] startNetWorkMonitor];
}

#pragma mark startLocation
-(void)startLocation{
    self.locationManger = [[CLLocationManager alloc] init];
    self.locationManger.delegate = self;
    
    if (SYSTEM_VERSION >= 8.0) {
        [self.locationManger requestWhenInUseAuthorization];
    }
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManger.distanceFilter = 10.0f;
    [self.locationManger startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    DLog(@"定位成功！");
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    DLog(@"%@",[NSString stringWithFormat:@"经度-->%3.5f\n纬度-->%3.5f",coor.latitude,coor.longitude]);
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks,NSError *error){
        for (CLPlacemark *placemark in placemarks) {
            NSDictionary *addressDict = [placemark addressDictionary];
            DLog(@"Country-->%@",[addressDict objectForKey:@"Country"]);
            DLog(@"State-->%@",[addressDict objectForKey:@"State"]);
            DLog(@"SubLocality-->%@",[addressDict objectForKey:@"SubLocality"]);
        }
    }];
    [self.locationManger stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        DLog(@"访问被拒绝");
    }
    if (error.code == kCLErrorLocationUnknown) {
        DLog(@"无法获取位置信息");
    }
}

#pragma mark startPush
-(void)startPush:(NSDictionary *)launchOptions{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:appKeyJPush
                          channel:channelJPush apsForProduction:isProduction];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DLog(@"Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    DLog(@"收到通知:%@", [self logDic:userInfo]);
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    DLog(@"收到通知:%@", [self logDic:userInfo]);
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

#pragma mark startAnalytic
-(void)startAnalytic{
    [MobClick startWithAppkey:appKeyUMAnaytic reportPolicy:BATCH channelId:channelUMAnaytic];
    [MobClick setEncryptEnabled:YES];
    [MobClick setLogEnabled:YES];
}

#pragma mark startSocial
-(void)startSocial{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:appKeyUMSocial];
    /*
     //设置微信AppId、appSecret，分享url
     [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
     //设置手机QQ 的AppId，Appkey，和分享URL
     [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
     //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。
     [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
     secret:@"04b48b094faeb16683c32669824ebdad"
     RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
     //设置来往AppId，appscret，显示来源名称和url地址
     [UMSocialLaiwangHandler setLaiwangAppId:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" appDescription:@"友盟社会化组件" urlStirng:@"http://www.umeng.com/social"];
     //设置Facebook，AppID和分享url
     //默认使用iOS自带的Facebook分享framework，在iOS 6以上有效。若要使用我们提供的facebook分享需要使用此开关：
     [UMSocialFacebookHandler setFacebookAppID:@"1440390216179601" shareFacebookWithURL:@"http://www.umeng.com/social"];
     //默认使用iOS自带的Twitter分享framework，在iOS 6以上有效。若要使用我们提供的twitter分享需要使用此开关：
     [UMSocialTwitterHandler openTwitter];
     if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
     [UMSocialTwitterHandler setTwitterAppKey:@"fB5tvRpna1CKK97xZUslbxiet" withSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K"];
     }
     */
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK
    }
    return result;
}

#pragma mark initRootWindow
-(void)initRootWindow
{
    BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootVC];
    [self.window addSubview:rootVC.view];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
