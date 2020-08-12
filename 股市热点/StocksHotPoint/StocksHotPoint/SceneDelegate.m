//
//  SceneDelegate.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/5.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "navigationBar.h"
#import "hoursTableView.h"
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogManager.h>



@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    UIWindowScene *windowScene =(UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    
    //主页面——热点掘金
    ViewController *view = [[ViewController alloc] init];
    
    
    //导航栏设置
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:view];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    //初始化友盟
    //设置日志通知
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:@"5f3354ceb4b08b653e939c6c" channel:@"App Store"];

}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
