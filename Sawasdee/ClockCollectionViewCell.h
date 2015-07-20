//
//  ClockCollectionViewCell.h
//  Sawasdee
//
//  Created by BooBoo on 8/7/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockCollectionViewCell : UICollectionViewCell
{

}

@property (nonatomic, strong, readwrite) IBOutlet UIButton          *dayBtn;
@property (nonatomic, strong, readwrite) IBOutlet UILabel           *dayLabel;
@property (nonatomic, strong, readwrite) IBOutlet UIView            *bgView;
@property (nonatomic, strong, readwrite) IBOutlet UIButton          *holidayBtn;
@property (nonatomic, strong, readwrite) IBOutlet UIButton          *eventBtn;

@end
