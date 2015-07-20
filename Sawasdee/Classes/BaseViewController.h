//
//  BaseViewController.h
//  Sawasdee
//
//  Created by BooBoo on 7/26/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Theme.h"
#import "Word.h"

@interface BaseViewController : UIViewController
{
    //MBProgressHUD *hud;
    UIView *menuView;
    
    UIImageView *bgView;
    UIImageView *topBarView;
    UIButton *settingIconView;
    UIImageView *appIconView;
    
    UIView *dateView;
    
    Theme *theme;
    UIButton *backIconView;
    
    AVSpeechSynthesizer *synthesizer;
    UIActivityIndicatorView *activityIndicatorView;
    
    UILabel *categoryLabel;
    
}

@property (nonatomic, retain, readwrite) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *topBarView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *settingIconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *appIconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *bgView;
@property (nonatomic, retain, readwrite) IBOutlet UIView *dataView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *backIconView;

-(void) startProgressBar;
-(void) endProgressBar;
- (void)settingTheme;
-(void) backToPreviousPage;
- (void) speak:(NSString*) word;
- (void) gotoRelatedContentView:(Word*) word;
-(void) settingBtnAction;
-(void) requestBtnAction;
-(void) clockBtnAction;
-(void) currencyBtnAction;
-(void) digitBtnAction;
-(void) speakBtnAction;

@end
