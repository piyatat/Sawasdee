//
//  RelateContentImageCell.h
//  Sawasdee
//
//  Created by BooBoo on 8/4/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelateContentImageCell : UICollectionViewCell
{
    UIImageView *bgView;
    UIImageView *contentView;
}

@property (nonatomic, retain, readwrite) IBOutlet UIImageView *bgView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *contentView;

@end
