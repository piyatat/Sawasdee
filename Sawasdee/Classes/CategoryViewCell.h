//
//  CategoryViewCell.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewCell : UITableViewCell
{
    UILabel *name;
    UILabel *karaokeLabel;
    UILabel *description;
    UIImageView *iconView;
    UIImageView *iconBGView;
    UILabel *orderLabel;
    UIImageView *orderBG;
}

@property (nonatomic, retain, readwrite) IBOutlet UILabel *name;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *karaokeLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *description;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *iconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *iconBGView;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *orderLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *orderBG;

@end
