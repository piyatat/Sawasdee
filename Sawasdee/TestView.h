//
//  TestView.h
//  Sawasdee
//
//  Created by BooBoo on 8/6/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@interface TestView : UIView
{
    UILabel *timeLabel;
    NSTimeZone *timeZone;
    CGRect clockRect;
}

- (void) updateClockView;
- (id)initWithFrame:(CGRect)frame forLocale:(NSString*) locale;

@end
