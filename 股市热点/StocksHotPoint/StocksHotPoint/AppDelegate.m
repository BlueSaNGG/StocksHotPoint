//
//  AppDelegate.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/5.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}



#pragma mark - 设置notification
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler __API_AVAILABLE(macos(10.14), ios(10.0), watchos(3.0), tvos(10.0)) {
    UNNotificationPresentationOptions presentationOptions = UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionSound;
    completionHandler(presentationOptions);

}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __API_AVAILABLE(macos(10.14), ios(10.0), watchos(3.0)) __API_UNAVAILABLE(tvos) {
    //判断点击时程序是否在前台运行
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        //前台则到问股
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNotificationFront" object:nil];
    }else {
        //后台则到首页
        [[NSNotificationCenter defaultCenter] postNotificationName:@"clickedNotificationBack" object:nil];
    }
}
 


@end
