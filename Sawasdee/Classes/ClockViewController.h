//
//  ClockViewController.h
//  Sawasdee
//
//  Created by BooBoo on 8/6/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"

@interface ClockViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIView *clockLocalView;
    UIView *clockBKKView;
    
    UICollectionView *calendarView;
    NSMutableArray *holidayList;
    NSMutableArray *holidayMonthFilterList;
    
    TestView *bkkClock;
    TestView *localClock;
    
    NSDateFormatter *dateFormatter;
    NSDate *today;
    NSDate *firstDayOfMonth;
    int offsetFirstDayOfMonth;
    
    NSTimer *timer;
    
    int dayInMonth;
    int monthNo;
    int dayNo;
    int yearNo;
    int weeksInMonth;
    
    UIButton *previousBtn;
    UIButton *nextBtn;
    UILabel *monthLabel;

}
@property (nonatomic, retain, readwrite) IBOutlet UIView *clockBKKView;
@property (nonatomic, retain, readwrite) IBOutlet UIView *clockLocalView;

@property (nonatomic, retain, readwrite) IBOutlet UICollectionView *calendarView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *previousBtn;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *nextBtn;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *monthLabel;

@property (nonatomic, strong, readwrite) IBOutlet UIView            *eventView;
@property (nonatomic, strong, readwrite) IBOutlet UILabel           *eventLabel;
@property (nonatomic, strong, readwrite) IBOutlet UITextView        *eventTextView;
@property (nonatomic, strong, readwrite) IBOutlet UIButton          *btnCover;

@end
