//
//  AppDelegate.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuViewController.h"

@implementation AppDelegate

@synthesize bannerView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    @try {

        NSString *bundleName = @"Main_iPhone";
        if(IS_IPAD){
            bundleName = @"Main_iPad";
        }
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:bundleName bundle:nil];
        MenuViewController *searchView = [storyBoard instantiateViewControllerWithIdentifier:@"MenuViewControllerID"];
        
//        [Crashlytics startWithAPIKey:@"455a6348a9d54363f40ea492cfd3ff102b15e129"];
//        
//        //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
//        [Flurry setCrashReportingEnabled:NO];
//        [Flurry startSession:FlurryAPI_KEY];
        
//        // AdMob area
//        // Create a view of the standard size at the top of the screen.
//        // Available AdSize constants are explained in GADAdSize.h.
//        bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
//        
//        // Specify the ad unit ID.
//        bannerView.adUnitID = ADMOB_KEY;
//        bannerView.delegate = self;
//        
//        // Let the runtime know which UIViewController to restore after taking
//        // the user wherever the ad goes and add it to the view hierarchy.
//        bannerView.rootViewController = searchView;
//        bannerView.frame = CGRectMake(0, searchView.view.frame.size.height, bannerView.frame.size.width, bannerView.frame.size.height);
//        bannerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
//        //[self.view addSubview:bannerView];
//        self.isBannerAvailable = NO;
//        [bannerView loadRequest:[GADRequest request]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Cannot connect to ads service");
    }

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - GADBannerViewDelegate
- (void)adViewDidReceiveAd:(GADBannerView *)_bannerView
{
    self.isBannerAvailable = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:AdMobUpdateEvent object:nil];
}

- (void)adView:(GADBannerView *)_bannerView
didFailToReceiveAdWithError:(GADRequestError *)error
{
    self.isBannerAvailable = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:AdMobUpdateEvent object:nil];
}


@end
