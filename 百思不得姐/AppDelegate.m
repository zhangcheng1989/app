//
//  AppDelegate.m
//  百思不得姐
//
//  Created by zhangcheng on 16/8/21.
//  Copyright © 2016年 zhangcheng. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCTabBarController.h"
#import "ZCPushGuideView.h"
#import "ZCTopWindow.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


/**
 崩溃信息统计
 1.友盟
 2.flurry
 3.Crashlytics
 */
void handlerException2(NSException *execption){
    [execption callStackSymbols];  //调用栈信息(错误来源信息)
    [execption name]; //异常名字
    [execption reason]; //异常理由
}


void handlerException(NSException *execption){
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZCTabBarController *tabBarController = [[ZCTabBarController alloc]init];
    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    [ZCPushGuideView show];
    
    NSSetUncaughtExceptionHandler(handlerException);
    
    //注册本地通知
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:setting];
    }

    //应用被杀死的情况下
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        NSLog(@"跳转代码");
    }
    
    //注册远程通知
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:setting];
        [application registerForRemoteNotifications];
    }else{//iOS7远程通知
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeNewsstandContentAvailability];
    }
    
    return YES;
}


//获取设备deviceToken
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"进行页面跳转");
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
    //[ZCTopWindow show];  //设置点击状态滚动
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[SelectedControllerKey] = viewController;
//    userInfo[SelectedControllerIndexKey] = @(tabBarController.selectedIndex);
    [[NSNotificationCenter defaultCenter]postNotificationName:TabBarDidSelectedNotfication object:nil userInfo:nil];
}


@end
