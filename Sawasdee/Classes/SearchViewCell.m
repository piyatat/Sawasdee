//
//  SearchViewCell.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "SearchViewCell.h"

@implementation SearchViewCell

@synthesize wordLabel;
@synthesize karaokeLabel;
@synthesize meaningLabel;
@synthesize iconView;
@synthesize iconBGView;
@synthesize orderLabel;
@synthesize orderBG;
@synthesize speakBtn;
@synthesize infoBtn;
@synthesize info2Btn;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    self.selectedBackgroundView = selectedBGView;
}

@end
