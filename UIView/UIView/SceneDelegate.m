//
//  SceneDelegate.m
//  UIView
//
//  Created by myhexin on 2020/7/29.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "SceneDelegate.h"
#import "homeController.h"
#import "secondPageController.h"
#import "thirdPageController.h"



@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {

    UIWindowScene *windowScene =(UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    
    //tabbar初始化
    UITabBarController *tabbarController =[UITabBarController new];
    
    //第一个页面——从viewcontrol中倒入
    homeController *homePage = [homeController new];
    
    
    //第二个页面——默认的uiviewcontroller
    secondPageController *secondPage = [secondPageController new];
    
    
    //第三个页面
    thirdPageController *thirdPage = [thirdPageController new];
    
    
    //第四个页面
    UIViewController *forthPage = [UIViewController new];
    forthPage.view.backgroundColor = [UIColor yellowColor];
    forthPage.tabBarItem.title = @"时事热点";
    
    
    //tabbar中传入各页面
    [tabbarController setViewControllers:@[homePage,secondPage,thirdPage,forthPage]];
    //调用tabbar的delegate，可以控制tabbar点击的事件——需要在interface中声明
//    tabbarController.delegate=self;
    
    //nav设置
    UINavigationController *navigtaionController = [[UINavigationController alloc] initWithRootViewController:tabbarController];
    
    self.window.rootViewController = navigtaionController;
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
}


- (void)sceneWillResignActive:(UIScene *)scene {
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
}


@end
