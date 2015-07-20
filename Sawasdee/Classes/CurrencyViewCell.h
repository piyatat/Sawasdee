//
//  CurrencyViewCell.h
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyViewCell : UITableViewCell

@property (nonatomic, strong, readwrite) IBOutlet UILabel           *currencyLabel;
@property (nonatomic, strong, readwrite) IBOutlet UIImageView       *currencyImage;
@property (nonatomic, strong, readwrite) IBOutlet UILabel           *karaokeLabel;

@end
