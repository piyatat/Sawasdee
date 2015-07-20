//
//  MenuViewController.m
//  Sawasdee
//
//  Created by BooBoo on 8/22/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "MenuViewController.h"
#import "SearchViewController.h"
#import "MenuCell.h"

@implementation MenuViewController

@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
    
    [self goToSearchView];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark - TableView Delegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MenuCellID"];
    
    NSString *imageName = @"";
    NSString *imageLabel = @"";

    switch (indexPath.row) {

        case SPEAK_MENU:
            imageLabel = @"Let's speak Thai";
            imageName = @"app-speak-icon.png";
            break;
            
        case CALENDAR_MENU:
            imageLabel = @"Calendar/Events";
            imageName = @"app-calendar-icon.png";
            break;
            
        case DIGIT_MENU:
            imageLabel = @"Digit";
            imageName = @"app-digit-icon.png";
            break;
            
        case CURRENCY_MENU:
            imageLabel = @"Currency";
            imageName = @"app-currency-icon.png";
            break;
            
        case REQUEST_MENU:
            imageLabel = @"Request";
            imageName = @"app-icon-request.png";
            break;
            
        case SETTING_MENU:
            imageLabel = @"Setting";
            imageName = @"setting.png";
            break;
            
    }
    
    cell.menuIcon.image = [UIImage imageNamed:imageName];
    cell.menuLabel.text = imageLabel;
    cell.menuLabel.textColor = [UIColor whiteColor];
    cell.menuLabel.font = ThemeFontNormal;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MENU_NUMBER_MENU;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
            
        case SPEAK_MENU:
            [self goToSearchView];
            break;

        case CALENDAR_MENU:
            [self clockBtnAction];
            break;
            
        case DIGIT_MENU:
            [self digitBtnAction];
            break;
            
        case CURRENCY_MENU:
            [self currencyBtnAction];
            break;
            
        case REQUEST_MENU:
            [self requestBtnAction];
            break;
            
        case SETTING_MENU:
            [self settingBtnAction];
            break;
            
    }

}

- (void) goToSearchView
{
    UIStoryboard *storyBoard = [self storyboard];
    SearchViewController *searchView = [storyBoard instantiateViewControllerWithIdentifier:@"SearchViewControllerID"];
    [self.navigationController pushViewController:searchView animated:YES];
}
@end
