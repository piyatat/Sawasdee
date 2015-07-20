//
//  MenuCell.h
//  Sawasdee
//
//  Created by BooBoo on 8/22/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell
{
    UILabel *menuLabel;
    UIImageView *menuIcon;
}

@property (nonatomic, retain, readwrite) IBOutlet UILabel *menuLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *menuIcon;

@end
