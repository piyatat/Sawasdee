//
//  DigitCell.h
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DigitCell : UITableViewCell

@property (nonatomic, strong, readwrite) IBOutlet UILabel           *digitLabel;
@property (nonatomic, strong, readwrite) IBOutlet UILabel           *thaiDigitLabel;
@property (nonatomic, strong, readwrite) IBOutlet UILabel           *karaokeLabel;

@end
