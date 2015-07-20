//
//  SettingViewController.h
//  BBPlayer
//
//  Created by Tei on 6/3/14.
//  Copyright (c) 2014 B2Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Util.h"

//@protocol SettingViewControllerDelegate <NSObject>
//
//- (void)settingViewControllerWillDone;
//
//@end

@interface SettingViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UIButton *rateAppBtn;
}

//@property (nonatomic, strong, readwrite) IBOutlet UIButton          *btn_done;
@property (nonatomic, strong, readwrite) IBOutlet UIImageView       *img_bg;
@property (nonatomic, strong, readwrite) IBOutlet UITableView       *list_setting;

//@property (nonatomic, strong, readwrite) id<SettingViewControllerDelegate>  delegate;

@end
