//
//  AppDelegate.m
//  iOSExample
//
//  Created by sq on 15/3/13.
//  Copyright (c) 2015年 lofter. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DemoPkLoadMoreViewController.h"
#import "DemoPanBackViewController.h"

//#import "FLEXManager.h"
#if DEBUG
#import <PonyDebugger/PonyDebugger.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - UIApplicationDelegate Methods
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Crash reporting, logging, debugging
    [self configurePonyDebugger];
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //demo scrollview
    /*
    ViewController *viewController = [[ViewController alloc] init];
    self.window.rootViewController = viewController;
    */
    
    /*
    //demo pull & loadmore
    
    
    DemoPkLoadMoreViewController *pload = [[DemoPkLoadMoreViewController alloc] init];
    
    UINavigationController *v = [[UINavigationController alloc] initWithRootViewController:pload];
    self.window.rootViewController = v;
    */
    
    
    //demo pan back
    DemoPanBackViewController *panDemo = [[DemoPanBackViewController alloc] init];
    UINavigationController *v = [[UINavigationController alloc] initWithRootViewController:panDemo];
    self.window.rootViewController = v;
     
    
    [self.window makeKeyAndVisible];
    
    //[[FLEXManager sharedManager] showExplorer];
    
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
}


#pragma mark - debugger
- (void)configurePonyDebugger
{
#ifdef DEBUG
    PDDebugger *debugger = [PDDebugger defaultInstance];
    
    // Enable Network debugging, and automatically track network traffic that comes through any classes that NSURLConnectionDelegate methods.
    [debugger enableNetworkTrafficDebugging];
    [debugger forwardAllNetworkTraffic];
    
    // Enable Core Data debugging, and broadcast the main managed object context.
    //[debugger enableCoreDataDebugging];
    //[debugger addManagedObjectContext:self.managedObjectContext withName:@"Twitter Test MOC"];
    
    // Enable View Hierarchy debugging. This will swizzle UIView methods to monitor changes in the hierarchy
    // Choose a few UIView key paths to display as attributes of the dom nodes
    [debugger enableViewHierarchyDebugging];
    [debugger setDisplayedViewAttributeKeyPaths:@[@"frame",@"bounds", @"hidden", @"alpha", @"opaque",@"text"]];
    
    // Connect to a specific host
    [debugger connectToURL:[NSURL URLWithString:@"ws://192.168.1.105:9000/device"]];
    // Or auto connect via bonjour discovery
    //[debugger autoConnect];
    // Or to a specific ponyd bonjour service
    //[debugger autoConnectToBonjourServiceNamed:@"MY PONY"];
    
    // Enable remote logging to the DevTools Console via PDLog()/PDLogObjects().
    //[debugger enableRemoteLogging];
#endif
}

@end
