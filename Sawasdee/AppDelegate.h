//
//  AppDelegate.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Crashlytics/Crashlytics.h>
#import "Flurry.h"
#import "GADBannerView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GADBannerViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readwrite) GADBannerView          *bannerView;
@property (nonatomic, assign, readwrite) BOOL                   isBannerAvailable;

@end
