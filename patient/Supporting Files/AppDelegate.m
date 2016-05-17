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
#import <UMessage.h>
#import "BaseTabBarController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiManager.h"

#import "GuideViewController.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (assign,nonatomic)BOOL isVersionUpdated;
@property (assign,nonatomic)BOOL isLoginSucceeded;
@property (strong,nonatomic)UINavigationController *navController;
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
    [self startPay];
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

#pragma mark checkVersionStatus
-(BOOL)checkVersionStatus{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([currentVersion isEqualToString:lastVersion]) {
        DLog(@"没有更新版本！");
        return NO;
    }else{
        DLog(@"有更新版本！");
        //存储当前版本
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

-(void)checkLoginStatus{
    
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
    DLog(@"%@",[NSString stringWithFormat:@"经度-->%3.5f\n纬度-->%3.5f",coor.longitude,coor.latitude]);
    
    [[NSUserDefaults standardUserDefaults] setFloat:coor.latitude forKey:kJZK_longitude];
    [[NSUserDefaults standardUserDefaults] setFloat:coor.longitude forKey:kJZK_latitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks,NSError *error){
        for (CLPlacemark *placemark in placemarks) {
            NSDictionary *addressDict = [placemark addressDictionary];
//            DLog(@"addressDict-->%@",addressDict);
            DLog(@"Country-->%@",[addressDict objectForKey:@"Country"]);
            DLog(@"State-->%@",[addressDict objectForKey:@"State"]);
            DLog(@"City-->%@",[addressDict objectForKey:@"City"]);
            DLog(@"SubLocality-->%@",[addressDict objectForKey:@"SubLocality"]);
            
            [[NSUserDefaults standardUserDefaults] setValue:[addressDict objectForKey:@"City"] forKey:kJZK_city];
            [[NSUserDefaults standardUserDefaults] synchronize];
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
    [UMessage startWithAppkey:appKeyUMPush launchOptions:launchOptions];
    
    [UMessage addAlias:[[NSUserDefaults standardUserDefaults] objectForKey:kJZK_token] type:@"jiuzhekan" response:^(id responseObject, NSError *error) {
        DLog(@"UMessage addAlias responseObject-->%@",responseObject);
    }];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")){
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
#endif
    
    [UMessage setLogEnabled:YES];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    
    DLog(@"deviceToken-->%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                 stringByReplacingOccurrencesOfString: @">" withString: @""]
                stringByReplacingOccurrencesOfString: @" " withString: @""]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
}

/*
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
 */

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
    [UMSocialData openLog:YES];
    
    [UMSocialWechatHandler setWXAppId:@"wx6a048cad50cccc7b" appSecret:@"5cc5a1439d30a6bbead8dffeaa52aadc" url:@"http://www.jiuzhekan.com/"];
    
    [UMSocialQQHandler setQQWithAppId:@"1105377074" appKey:@"2ptblRpn872OI4Lj" url:@"http://www.jiuzhekan.com/"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2804359312"
                                              secret:@"31ecd177145d7f65ba803b77fdfea63b"
                                         RedirectURL:@"http://www.jiuzhekan.com/"];
}

-(void)startPay{
    [WXApi registerApp:@"wx6a048cad50cccc7b" withDescription:@"demo 2.0"];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSLog(@"result = %@",resultDic);
            }];
        }
        if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回authCode
            
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                NSLog(@"result = %@",resultDic);
            }];
        }
        return YES;
    }
    return result;
}

#pragma mark initRootWindow
-(void)initRootWindow
{
    if ([self checkVersionStatus] == YES) {
        GuideViewController *guideVC = [[GuideViewController alloc] init];
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setRootViewController:guideVC];
        [self.window addSubview:guideVC.view];
        [self.window makeKeyAndVisible];
    }else{
        BaseTabBarController *rootVC = [[BaseTabBarController alloc] init];
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window setRootViewController:rootVC];
        [self.window addSubview:rootVC.view];
        [self.window makeKeyAndVisible];
    }
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
