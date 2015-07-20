//
//  SettingViewController.m
//  BBPlayer
//
//  Created by Tei on 6/3/14.
//  Copyright (c) 2014 B2Home. All rights reserved.
//

#import "SettingViewController.h"

#import "SwitchSettingCell.h"

@interface SettingViewController ()

//- (IBAction)onBtnClicked:(id)sender;

@end

@implementation SettingViewController

@synthesize img_bg, list_setting; // btn_done,
//@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.list_setting.backgroundColor = [UIColor clearColor];
//    [self.btn_done addTarget:self action:@selector(themeDone) forControlEvents:UIControlEventTouchUpInside];
//    [self.btn_done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    rateAppBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,40)];
    [rateAppBtn setTitle:@"Rate this app!" forState:UIControlStateNormal];
    [rateAppBtn setTitleColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9] forState:UIControlStateNormal];
    [rateAppBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [rateAppBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rateAppBtn addTarget:self action:@selector(rateThisApp) forControlEvents:UIControlEventTouchUpInside];
    rateAppBtn.backgroundColor = [UIColor clearColor];
    
    list_setting.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.2];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    theme = [[Util sharedUtil] getThemeDescription];
    self.img_bg.image = [UIImage imageNamed:theme.background];
    [[Util sharedUtil] setCurrentView:SETTING_VIEW];
}

//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return UIInterfaceOrientationPortrait;
//}

- (void)dealloc
{
//    self.btn_done = nil;
    self.img_bg = nil;
    
    self.list_setting.dataSource = nil;
    self.list_setting.delegate = nil;
    self.list_setting = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 5;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Theme";
            break;
        case 1:
            return @"Enable/Disable";
            break;
        case 2:
            return @"Rate App";
            break;
    }

    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0){
        
        UITableViewCell *cellThemeSetting = [tableView dequeueReusableCellWithIdentifier:@"ThemeCellID" forIndexPath:indexPath];
        switch (indexPath.row) {
            case BLUE_THEME:
            {
                cellThemeSetting.textLabel.text = @"Blue";
                break;
            }
            case GREEN_THEME:
            {
                cellThemeSetting.textLabel.text = @"Green";
                break;
            }
            case ORANGE_THEME:
            {
                cellThemeSetting.textLabel.text = @"Orange";
                break;
            }
            case PINK_THEME:
            {
                cellThemeSetting.textLabel.text = @"Pink";
                break;
            }
            case NONE_THEME:
            {
                cellThemeSetting.textLabel.text = @"None";
                break;
            }
            default:
                break;
        }
        
        if ([[Util sharedUtil] getSelectedThemeType] == indexPath.row) {
            cellThemeSetting.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cellThemeSetting.accessoryType = UITableViewCellAccessoryNone;
        }
        cellThemeSetting.textLabel.font = [UIFont fontWithName:FontNormal size:14];
        cellThemeSetting.backgroundColor = [UIColor clearColor];
        
        return cellThemeSetting;
    }else if(indexPath.section == 1){
        
        SwitchSettingCell *cellSetting = [tableView dequeueReusableCellWithIdentifier:@"SwitchSettingCellID" forIndexPath:indexPath];
        switch(indexPath.row){
            case 0:
                cellSetting.allowLabel.text = @"Enable image search";
                cellSetting.allow.on = [[Util sharedUtil] getImageSearchSetting];
                [cellSetting.allow addTarget:self
                                      action:@selector(switchSettingAction:)
                            forControlEvents:UIControlEventTouchUpInside];
                 cellSetting.textLabel.font = [UIFont fontWithName:FontNormal size:12];
                
                break;
        }
        cellSetting.backgroundColor = [UIColor clearColor];
        return cellSetting;
    }
    else if(indexPath.section == 2){
        
        UITableViewCell *cellThemeSetting = [tableView dequeueReusableCellWithIdentifier:@"ThemeCellID" forIndexPath:indexPath];
        switch(indexPath.row){
            case 0:
                cellThemeSetting.textLabel.text = @"Help us rate this app.";
                cellThemeSetting.textLabel.textColor = [UIColor blueColor];
                cellThemeSetting.accessoryView = rateAppBtn;
                cellThemeSetting.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
        }
        cellThemeSetting.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.3];
        return cellThemeSetting;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

-  (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case BLUE_THEME:
            {
                [[Util sharedUtil] setThemeType:BLUE_THEME];
                break;
            }
            case GREEN_THEME:
            {
                [[Util sharedUtil] setThemeType:GREEN_THEME];
                break;
            }
            case ORANGE_THEME:
            {
                [[Util sharedUtil] setThemeType:ORANGE_THEME];
                break;
            }
            case PINK_THEME:
            {
                [[Util sharedUtil] setThemeType:PINK_THEME];
                break;
            }
            case NONE_THEME:
            {
                [[Util sharedUtil] setThemeType:NONE_THEME];
                break;
            }
            default:
                break;
        }
        
        theme = [[Util sharedUtil] getThemeDescription];
        self.img_bg.image = [UIImage imageNamed:theme.background];
        self.topBarView.image = [UIImage imageNamed:theme.top];


        [self.list_setting reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return YES;
            break;
            
        case 1:
            return NO;
            break;
    }
    
    return NO;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        label.text = @"   If you enjoy this app, help us rate it.";
        label.font = ThemeFontItalic;
        label.backgroundColor = [UIColor clearColor];
        
        //rateAppBtn.frame = view.frame;
        [view addSubview:label];
        
        return view;
    }
    return nil;
}


-(void) themeDone{
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (void) rateThisApp
{
    if(APP_ID!=nil){
        NSString *appUURL = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", APP_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUURL]];
    }
}

-(void) switchSettingAction:(id) btn
{
    BOOL isAllow = [[Util sharedUtil] getImageSearchSetting];
    [[Util sharedUtil] setImageSearchSetting:!isAllow];
}

@end
