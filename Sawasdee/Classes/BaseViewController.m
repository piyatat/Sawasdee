//
//  BaseViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/26/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingViewController.h"
#import "RequestWordViewController.h"
#import "ClockViewController.h"
#import "CurrencyViewController.h"
#import "DigitViewController.h"
#import "RelateContentViewController.h"
#import "AppDelegate.h"

@implementation BaseViewController

@synthesize topBarView;
@synthesize settingIconView;
@synthesize appIconView;
@synthesize bgView;
@synthesize dataView;
@synthesize backIconView;
@synthesize categoryLabel;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    menuView = [[UIView alloc] init];
    synthesizer = [[AVSpeechSynthesizer alloc]init];
    
    self.backIconView.hidden = YES;
    
    //[self initMenuView];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
    theme = [[Util sharedUtil] getThemeDescription];
    self.bgView.image = [UIImage imageNamed:theme.background];
    self.topBarView.image = [UIImage imageNamed:theme.top];
    [self.settingIconView setImage:[UIImage imageNamed:@"icon-sawasdee.png"] forState:UIControlStateNormal];
    [self.settingIconView setImage:[UIImage imageNamed:@"icon-sawasdee-grey.png"] forState:UIControlStateHighlighted];
    [self.settingIconView addTarget:self action:@selector(settingTheme) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:[self getThemeDescription].top]
    //                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.backIconView setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.backIconView setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
    [self.backIconView addTarget:self action:@selector(backToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    // Register AdMobEvent
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adUpdate:) name:AdMobUpdateEvent object:nil];
//    
//    [self updateView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Unregister AdMobEvent
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AdMobUpdateEvent object:nil];
}

#pragma mark - GADBannerViewDelegate
//- (void)adUpdate:(NSNotification *)notification
//{
//    [self updateView];
//    
//}

//- (void)updateView
//{
//    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    CGSize adSize = appDelegate.bannerView.frame.size;
//    
//    if (appDelegate.isBannerAvailable) {
//        if (appDelegate.bannerView.superview == self.view) {
//            // Do nothing
//            return;
//        }
//        
//        // Add bannerView
//        [appDelegate.bannerView removeFromSuperview];
//        appDelegate.bannerView.frame = CGRectMake(0,
//                                                  self.view.bounds.size.height,
//                                                  appDelegate.bannerView.frame.size.width,
//                                                  appDelegate.bannerView.frame.size.height);
//        [self.view addSubview:appDelegate.bannerView];
//        
//        // Slide in animation
//        [UIView animateWithDuration:0.3
//                         animations:^{
//                             self.dataView.frame = CGRectMake(0,
//                                                              self.dataView.frame.origin.y,
//                                                              self.view.frame.size.width,
//                                                              self.view.bounds.size.height - self.dataView.frame.origin.y - adSize.height);
//                             
//                             appDelegate.bannerView.frame = CGRectMake(( self.view.frame.size.width - adSize.width) * 0.5,
//                                                                       self.view.frame.size.height - adSize.height,
//                                                                       adSize.width,
//                                                                       adSize.height);
//                         }
//                         completion:^(BOOL finished) {
//                             
//                         }];
//    } else {
//        if (appDelegate.bannerView.superview == self.view) {
//            // Remove bannerView
//            [UIView animateWithDuration:0.3
//                             animations:^{
//                                 self.dataView.frame = CGRectMake(0,
//                                                                  self.dataView.frame.origin.y,
//                                                                  self.view.frame.size.width,
//                                                                  self.view.bounds.size.height - self.dataView.frame.origin.y);
//                                 
//                                 appDelegate.bannerView.frame = CGRectMake(( self.view.frame.size.width) * 0.5,
//                                                                           self.view.frame.size.height,
//                                                                           adSize.width,
//                                                                           adSize.height);
//                             } completion:^(BOOL finished) {
//                                 [appDelegate.bannerView removeFromSuperview];
//                             }];
//        }
//    }
//
//}

-(void) startProgressBar
{
    dispatch_async(dispatch_get_main_queue(), ^{
//        hud = [[MBProgressHUD alloc] initWithView:self.view];
//        [self.view addSubview:hud];
//        hud.labelText = @"Loading";
//        [hud show:YES];
        [activityIndicatorView startAnimating];
    });
}

-(void) endProgressBar
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [hud hide:YES];
//        hud = nil;
//    });
    [activityIndicatorView stopAnimating];
}

-(void) settingTheme
{
    //[self showMenuView];
    if(self.navigationController)
        [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) initMenuView
{
    int diff = self.view.frame.size.width / 16;
    
    if(IS_IPAD){
        diff += 40;
    }
    
    //int iconAmount = 4;
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*0 + diff, self.view.frame.size.height/2-70, 70,70)];
    UIImage *settingImage = [UIImage imageNamed:@"app-icon-setting.png" ];
    [settingBtn setImage:settingImage forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.exclusiveTouch = YES;
    
    UIButton *requestBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*1 + diff, self.view.frame.size.height/2-70, 70,70)];
    UIImage *requestImage = [UIImage imageNamed:@"app-icon-request.png" ];
    [requestBtn setImage:requestImage forState:UIControlStateNormal];
    [requestBtn addTarget:self
                   action:@selector(requestBtnAction)
         forControlEvents:UIControlEventTouchUpInside];
    requestBtn.exclusiveTouch = YES;
    
    UIButton *clockBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*2 + diff, self.view.frame.size.height/2-70, 70,70)];
    UIImage *clockImage = [UIImage imageNamed:@"app-calendar-icon.png" ];
    [clockBtn setImage:clockImage forState:UIControlStateNormal];
    [clockBtn setImage:[UIImage imageNamed:@"app-calendar-icon-hover.png" ] forState:UIControlStateHighlighted];
    [clockBtn addTarget:self
                   action:@selector(clockBtnAction)
         forControlEvents:UIControlEventTouchUpInside];
    clockBtn.exclusiveTouch = YES;
    
    UIButton *currencyBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*0 + diff, self.view.frame.size.height/2+10, 70,70)];
    UIImage *currencyImage = [UIImage imageNamed:@"app-currency-icon.png" ];
    [currencyBtn setImage:currencyImage forState:UIControlStateNormal];
    [currencyBtn setImage:[UIImage imageNamed:@"app-currency-icon-hover.png" ] forState:UIControlStateHighlighted];
    [currencyBtn addTarget:self
                 action:@selector(currencyBtnAction)
       forControlEvents:UIControlEventTouchUpInside];
    currencyBtn.exclusiveTouch = YES;
    
    UIButton *digitBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*1 + diff, self.view.frame.size.height/2+10, 70,70)];
    UIImage *digitImage = [UIImage imageNamed:@"app-digit-icon.png" ];
    [digitBtn setImage:digitImage forState:UIControlStateNormal];
    [digitBtn setImage:[UIImage imageNamed:@"app-digit-icon-hover.png" ] forState:UIControlStateHighlighted];
    [digitBtn addTarget:self
                    action:@selector(digitBtnAction)
          forControlEvents:UIControlEventTouchUpInside];
    digitBtn.exclusiveTouch = YES;
    
    UIButton *speakBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*2 + diff, self.view.frame.size.height/2+10, 70,70)];
    UIImage *speakImage = [UIImage imageNamed:@"app-speak-icon.png" ];
    [speakBtn setImage:speakImage forState:UIControlStateNormal];
    [speakBtn setImage:[UIImage imageNamed:@"app-speak-icon-hover.png" ] forState:UIControlStateHighlighted];
    [speakBtn addTarget:self
                 action:@selector(speakBtnAction)
       forControlEvents:UIControlEventTouchUpInside];
    speakBtn.exclusiveTouch = YES;
    
    
    
    UIButton *wholePageBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [wholePageBtn addTarget:self
                     action:@selector(wholePageBtnAction)
           forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *settingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*0 + diff, self.view.frame.size.height/2-10, 70, 30)];
    settingLabel.text = @"Setting";
    settingLabel.textColor = [UIColor whiteColor];
    settingLabel.font = ThemeFontNormal;
    settingLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *requestLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*1 + diff, self.view.frame.size.height/2-10, 70, 30)];
    requestLabel.text = @"Request";
    requestLabel.textColor = [UIColor whiteColor];
    requestLabel.font = ThemeFontNormal;
    requestLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *clockLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/3)*2 + diff, self.view.frame.size.height/2-10, 70, 30)];
    clockLabel.text = @"Calendar";
    clockLabel.textColor = [UIColor whiteColor];
    clockLabel.font = ThemeFontNormal;
    clockLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *currencyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*0 + diff, self.view.frame.size.height/2+70, 70, 30)];
    currencyLabel.text = @"Currency";
    currencyLabel.textColor = [UIColor whiteColor];
    currencyLabel.font = ThemeFontNormal;
    currencyLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *digitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*1 + diff, self.view.frame.size.height/2+70, 70, 30)];
    digitLabel.text = @"Digit";
    digitLabel.textColor = [UIColor whiteColor];
    digitLabel.font = ThemeFontNormal;
    digitLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *speakLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3*2 + diff, self.view.frame.size.height/2+70, 70, 30)];
    speakLabel.text = @"Speak Thai";
    speakLabel.textColor = [UIColor whiteColor];
    speakLabel.font = ThemeFontNormal;
    speakLabel.textAlignment = NSTextAlignmentCenter;
    
    
//    UIView *bgIconView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-80, 200, 160)];
    UIView *bgIconView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-100, self.view.frame.size.width, 200)];
    bgIconView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    menuView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    [menuView addSubview:wholePageBtn];
    [menuView addSubview:bgIconView];
    [menuView addSubview:settingBtn];
    [menuView addSubview:requestBtn];
    [menuView addSubview:clockBtn];
    [menuView addSubview:currencyBtn];
    [menuView addSubview:digitBtn];
    [menuView addSubview:speakBtn];
    
    [menuView addSubview:settingLabel];
    [menuView addSubview:requestLabel];
    [menuView addSubview:clockLabel];
    [menuView addSubview:currencyLabel];
    [menuView addSubview:digitLabel];
    [menuView addSubview:speakLabel];
    
    menuView.backgroundColor = [UIColor clearColor];
    //menuView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.5];
    
    [self.view addSubview:menuView];

}

-(void) showMenuView
{
    menuView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        menuView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

-(void) hideMenuView
{
    [UIView animateWithDuration:0.5 animations:^{
        menuView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}

-(void) settingBtnAction
{
     //if([Util sharedUtil].currentView != SETTING_VIEW){
        //[self hideMenuView];
        //[self backToTopView];
        
        SettingViewController *settingView = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewControllerID"];
//        [self presentViewController:settingView animated:YES completion:^{
//            //
//        }];
         
         [self.navigationController pushViewController:settingView animated:YES];
     //}
    
}

-(void) requestBtnAction
{
    //if([Util sharedUtil].currentView != REQUEST_VIEW){
        //[self hideMenuView];
        //[self backToTopView];
        
        RequestWordViewController *requestView = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestWordViewControllerID"];
//        [self presentViewController:requestView animated:YES completion:^{
//            //
//        }];
        [self.navigationController pushViewController:requestView animated:YES];
    //}
}

-(void) clockBtnAction
{
    //if([Util sharedUtil].currentView != CLOCK_VIEW){
        //[self hideMenuView];
        //[self backToTopView];
        
        ClockViewController *clockView = [self.storyboard instantiateViewControllerWithIdentifier:@"ClockViewControllerID"];
//        [self presentViewController:clockView animated:YES completion:^{
//            //
//        }];
        
        [self.navigationController pushViewController:clockView animated:YES];
    //}
    
}

-(void) currencyBtnAction
{
    
    //if([Util sharedUtil].currentView != CURRENCY_VIEW){
        //[self hideMenuView];
        //[self backToTopView];
        
        CurrencyViewController *currencyView = [self.storyboard instantiateViewControllerWithIdentifier:@"CurrencyViewControllerID"];
        [self.navigationController pushViewController:currencyView animated:YES];
        

        
//        [self presentViewController:currencyView animated:YES completion:^{
//            //
//        }];
    //}

}

-(void) digitBtnAction
{
    //if([Util sharedUtil].currentView != DIGIT_VIEW){
        
        //[self hideMenuView];
        //[self backToTopView];
        
        DigitViewController *digitView = [self.storyboard instantiateViewControllerWithIdentifier:@"DigitViewControllerID"];
        [self.navigationController pushViewController:digitView animated:YES];
//        [self presentViewController:digitView animated:YES completion:^{
//            //
//        }];
    //}
    
}

-(void) speakBtnAction
{
//    if([Util sharedUtil].currentView != DIGIT_VIEW){
//        [self hideMenuView];
//        
//        DigitViewController *digitView = [self.storyboard instantiateViewControllerWithIdentifier:@"DigitViewControllerID"];
//        [self presentViewController:digitView animated:YES completion:^{
//            //
//        }];
//    }
}

-(void) wholePageBtnAction
{
    [self hideMenuView];
}

-(void) backToTopView
{
//    if(self.navigationController){
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }else{
//        [self dismissViewControllerAnimated:YES completion:^{
//            //
//        }];
//    }

}

-(void) backToPreviousPage
{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
}

- (void) speak:(NSString*) word
{
    
    NSString *locale = @"th-TH";
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString: word];
    [utterance setRate:0.2f];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage: locale];
    [synthesizer speakUtterance:utterance];
}

- (void) gotoRelatedContentView:(Word*) word
{
    UIStoryboard *storyBoard = [self storyboard];
    RelateContentViewController *relateContentView = [storyBoard instantiateViewControllerWithIdentifier:@"RelateContentViewControllerID"];
    [relateContentView setWord:word];
    [self.navigationController pushViewController:relateContentView animated:YES];
}

@end
