//
//  AppDelegate.m
//  FullMetalFirebase
//
//  Created by Michael Vilabrera on 8/5/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)                application:(UIApplication *)application
      didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.vc = [[ViewController alloc] initWithNibName:nil
                                               bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // make vc our root view controller
    self.window.rootViewController = self.vc;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
