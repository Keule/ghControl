//
//  AppDelegate.m
//  XXX_PROJECTNAME_XXX
//
//  Created by Thomas Wolters on 10/04/15.
//  Copyright (c) 2015 fluidmobile. All rights reserved.
//

#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import <HockeySDK/HockeySDK.h>
#import "CHLManagerLayer.h"
#import "CHLWorkflowManager.h"
#import "FLEXManager.h"
#import "Localytics.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Init Crashlytics
    [Crashlytics startWithAPIKey:API_KEY_CRASHLYTICS];
    
    //initLocalytics
    [Localytics autoIntegrate:API_KEY_LOCALYTICS launchOptions:launchOptions];
    
    //init Hockey
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:API_KEY_HOCKEYAPP];
    [[BITHockeyManager sharedHockeyManager] setDisableCrashManager: YES];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //Init ManagerLayer + CoreData
    [CHLManagerLayer sharedInstance];

    [[UINavigationBar appearance] setBarTintColor:COLOR_APP_TINT_COLOR];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary:[[UINavigationBar appearance] titleTextAttributes]];
    [titleBarAttributes setValue:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [titleBarAttributes setValue:FONT_NAV_BAR forKey:NSFontAttributeName];
    
    [[UINavigationBar appearance] setTitleTextAttributes:titleBarAttributes];
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[CHLWorkflowManager sharedInstance] initialViewController];
    
    [[UITextField appearance] setTintColor:[UIColor whiteColor]];
    
    [self.window makeKeyAndVisible];
    
    if (DEBUG_MODE){
        [FLEXManager sharedManager].networkDebuggingEnabled = YES;
    }
    
    return YES;
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
    // Saves changes in the application's managed object context before the application terminates.
}

@end
