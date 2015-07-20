//
//  VideoSettingCell.h
//  BBPlayer
//
//  Created by BooBoo on 6/19/2557 BE.
//  Copyright (c) 2557 B2Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SwitchSettingCell : UITableViewCell

@property (nonatomic, strong, readwrite) IBOutlet UISwitch       *allow;
@property (nonatomic, strong, readwrite) IBOutlet UILabel        *allowLabel;

@end
