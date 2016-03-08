//
//  AppDelegate.m
//  patient
//
//  Created by ChaosLiu on 16/3/1.
//  Copyright © 2016年 Hangzhou Congbao Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "LocationUtil.h"
#import "BaseTabBarController.h"

@interface AppDelegate ()<CLLocationManagerDelegate>

@property (strong,nonatomic)CLLocationManager *locationManger;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self getRelatedInformation];
    [self startLocation];
    [self startAnalytic];
    [self initRootWindow];
    return YES;
}

-(void)getRelatedInformation{
    DLog(@"CountryCode-->%@",[LocationUtil getCountryCode]);
    DLog(@"LanguageCode-->%@",[LocationUtil getLanguageCode]);
    DLog(@"LanguageCollatorIdentifierCode-->%@",[LocationUtil getLanguageCollatorIdentifierCode]);
    DLog(@"NSLocaleCurrencyCode-->%@",[LocationUtil getNSLocaleCurrencyCode]);
    DLog(@"NSLocaleCurrencySymbol-->%@",[LocationUtil getNSLocaleCurrencySymbol]);
    DLog(@"LanguageType-->%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]);
}

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

#pragma mark CLLocationManagerDelegate
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

-(void)startAnalytic{
    [MobClick startWithAppkey:@"56de29cf67e58ee8310006b2" reportPolicy:BATCH channelId:nil];
    [MobClick setEncryptEnabled:YES];
    [MobClick setLogEnabled:YES];
}

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
