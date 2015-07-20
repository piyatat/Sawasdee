//
//  SearchViewCell.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCell : UITableViewCell
{
    UILabel *wordLabel;
    UILabel *karaokeLabel;
    UILabel *meaningLabel;
    UIImageView *iconView;
    UIImageView *iconBGView;
    
    UILabel *orderLabel;
    UIImageView *orderBG;
    
    UIButton *infoBtn;
    UIButton *info2Btn;
    UIButton *speakBtn;
}

@property (nonatomic, retain, readwrite) IBOutlet UILabel *wordLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *karaokeLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *meaningLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *iconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *iconBGView;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *orderLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *orderBG;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *infoBtn;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *info2Btn;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *speakBtn;
@end
