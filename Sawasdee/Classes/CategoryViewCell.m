//
//  CategorySearchViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "CategoryViewCell.h"

@implementation CategoryViewCell

@synthesize name;
@synthesize karaokeLabel;
@synthesize description;
@synthesize iconView;
@synthesize iconBGView;
@synthesize orderBG;
@synthesize orderLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    self.selectedBackgroundView = selectedBGView;
}

@end