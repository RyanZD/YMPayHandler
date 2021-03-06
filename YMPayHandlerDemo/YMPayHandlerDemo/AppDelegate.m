//
//  AppDelegate.m
//  YMPayHandlerDemo
//
//  Created by 张锐 on 2016/10/21.
//  Copyright © 2016年 张锐. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <UMSocial.h>
#import <WXApi.h>
#import "YMPayManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[ViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    /** 微信注册 */
    [WXApi registerApp:@"wxb4ba3c02aa476ea1"];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self applicationOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self applicationOpenURL:url];
}

/** openURL 调起方法 */
- (BOOL)applicationOpenURL:(NSURL *)url{//因为友盟分享注册wxdelegate不起作用
    
    if([[url absoluteString] rangeOfString:@"wxb4ba3c02aa476ea1://pay"].location == 0)
        return [WXApi handleOpenURL:url delegate:[YMPayManager sharedManager]];
    else
        return [UMSocialSnsService handleOpenURL:url wxApiDelegate:[YMPayManager sharedManager]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
