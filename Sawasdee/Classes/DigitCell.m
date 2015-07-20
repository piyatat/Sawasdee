//
//  DigitCell.m
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "DigitCell.h"

@implementation DigitCell

@synthesize digitLabel;
@synthesize thaiDigitLabel;
@synthesize karaokeLabel;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UIView *selectedBGView = [[UIView alloc] init];
    selectedBGView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    self.selectedBackgroundView = selectedBGView;
}

@end
