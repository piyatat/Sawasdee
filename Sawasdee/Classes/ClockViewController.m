//
//  ClockViewController.m
//  Sawasdee
//
//  Created by BooBoo on 8/6/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "ClockViewController.h"
#import "ClockCollectionViewCell.h"

#import "CJSONDeserializer.h"
#import "Holiday.h"

@implementation ClockViewController

@synthesize clockBKKView;
@synthesize clockLocalView;
@synthesize calendarView;
@synthesize nextBtn;
@synthesize previousBtn;
@synthesize monthLabel;

@synthesize eventView;
@synthesize eventLabel;
@synthesize eventTextView;
@synthesize btnCover;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    holidayList = [[NSMutableArray alloc] init];
    holidayMonthFilterList = [[NSMutableArray alloc] init];
    
    localClock= [[TestView alloc] initWithFrame:CGRectMake(0, 0, self.clockLocalView.frame.size.width, self.clockLocalView.frame.size.height)];
    localClock.backgroundColor = [UIColor clearColor];
    
    
    bkkClock = [[TestView alloc] initWithFrame:CGRectMake(0, 0, self.clockBKKView.frame.size.width, self.clockBKKView.frame.size.height) forLocale:@"Asia/Bangkok"];
    bkkClock.backgroundColor = [UIColor clearColor];
    
    self.clockLocalView.backgroundColor = [UIColor clearColor];
    [self.clockLocalView addSubview:localClock];
    
    self.clockBKKView.backgroundColor = [UIColor clearColor];
    [self.clockBKKView addSubview:bkkClock];
    
    self.calendarView.backgroundColor = [UIColor clearColor];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    
    today = [NSDate date];
    offsetFirstDayOfMonth = 0;
    
    [self.nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.previousBtn addTarget:self action:@selector(previousBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn.titleLabel.font = ThemeFontNormal;
    self.nextBtn.titleLabel.text = @"next";
    //self.nextBtn.titleLabel.font = ThemeFontNormalDiff(-2);
    [self.nextBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    //self.previousBtn.titleLabel.font = ThemeFontNormalDiff(-2);
    self.previousBtn.titleLabel.text = @"previous";
    [self.previousBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    
    if(IS_IPAD){
        self.nextBtn.titleLabel.font = ThemeFontNormalDiff(0);
        self.previousBtn.titleLabel.font = ThemeFontNormalDiff(0);
    }else{
        self.nextBtn.titleLabel.font = ThemeFontNormalDiff(-2);
        self.previousBtn.titleLabel.font = ThemeFontNormalDiff(-2);
    }
    
    self.previousBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.monthLabel.font = ThemeFontBold;
    
    self.eventView.frame = CGRectMake(self.eventView.frame.origin.x, self.view.frame.size.height, self.eventView.frame.size.width, 200);
    
    [self.btnCover addTarget:self action:@selector(hideEventDetail) forControlEvents:UIControlEventTouchUpInside];
    
    [self hideEventDetail];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [super viewWillAppear:animated];
    [[Util sharedUtil] setCurrentView:CLOCK_VIEW];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:45.0
                                     target:self
                                   selector:@selector(ontimeReach)
                                   userInfo: nil repeats:YES];
    
//    self.navigationItem.title = @"DIGIT";
    self.categoryLabel.text = @"Calendar/Events";
    
    [self readHolidayData];
    [self generateCalendar];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
    timer = nil;
}

#pragma mark - UICollectionView Delegate
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClockCollectionViewCell *cell = [self.calendarView dequeueReusableCellWithReuseIdentifier:@"ClockCollectionViewCellID"
                                                                                 forIndexPath:indexPath ];
    
    int col = (int)indexPath.row+1;
    int row = (int)indexPath.section;
    int calculateValue = ( ( (row*7)+col) + offsetFirstDayOfMonth );
    cell.bgView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];

    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *addition = [[NSDateComponents alloc] init];
    [addition setDay: calculateValue];
    NSDate *generateDate = [calendar dateByAddingComponents:addition
                                                     toDate:firstDayOfMonth
                                                    options:0];
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit
                                          fromDate:generateDate];
    
    cell.dayLabel.text = [NSString stringWithFormat:@"%d",(int)comps.day];
    
    if(monthNo == (int)(comps.month)){
        if(col ==1 || col==7){
            cell.dayLabel.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
        }else{
            cell.dayLabel.textColor = [UIColor blackColor];
        }
    
    }else{
        cell.dayLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        cell.dayLabel.font = ThemeFontItalic;
    }
    cell.dayLabel.font = ThemeFontNormal;
    [cell.dayBtn setTitle:@"" forState:UIControlStateNormal];
    
    cell.eventBtn.tag = indexPath.row;
    [cell.eventBtn addTarget:self action:@selector(eventBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [cell.holidayBtn addTarget:self action:@selector(holidayBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.eventBtn.titleLabel.font = ThemeFontNormal;
    cell.holidayBtn.titleLabel.font = ThemeFontNormal;
    
    [cell.eventBtn setImage: [UIImage imageNamed:@"eventDayIcon.png"] forState:UIControlStateNormal];
    [cell.holidayBtn setImage: [UIImage imageNamed:@"holidayIcon.png"] forState:UIControlStateNormal];
    [cell.holidayBtn setImage: [UIImage imageNamed:@"holidayIcon.png"] forState:UIControlStateSelected];
    
    cell.eventBtn.hidden = YES;
    cell.holidayBtn.hidden = YES;
    
    for(int i=0; i<[holidayMonthFilterList count]; i++){
        
        Holiday *holiday = [holidayMonthFilterList objectAtIndex:i];
        
        if(comps.month == monthNo && comps.day==holiday.day){
            cell.holidayBtn.hidden  =   NO;
            cell.holidayBtn.tag     =   i;
        }
    }

    if(NSOrderedSame == [generateDate compare: today]){
        cell.bgView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.8 alpha:0.6];
    }

    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 7;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if(IS_IPAD){
        return UIEdgeInsetsMake(3, 3, 3, 3);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    if( IS_IPAD ){
//        self.calendarView.contentSize = CGSizeMake(self.view.frame.size.width-200, weeksInMonth*80);
//    }
    return weeksInMonth;
}


-(void) ontimeReach
{
    [bkkClock updateClockView];
    [localClock updateClockView];
}

-(void) generateCalendar
{
    
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit
                                          fromDate:today];

    int day = (int)comps.day;
    int year = (int)comps.year;
    int diffToFirstDayOfMonth = -(day-1);
    
    NSDateComponents *addition = [[NSDateComponents alloc] init];
    [addition setDay:diffToFirstDayOfMonth];
    firstDayOfMonth = [calendar dateByAddingComponents:addition toDate:today options:0];
    
    [self shiftCalendarMonth:0];
}

-(void) nextBtnAction
{
    [self startProgressBar];
    
    [self shiftCalendarMonth:1];
    
    [self endProgressBar];
}

-(void) previousBtnAction
{
    [self startProgressBar];
    
    [self shiftCalendarMonth:-1];
    
    [self endProgressBar];
}

-(void) shiftCalendarMonth:(int) sign
{
    NSCalendar* cal = [NSCalendar currentCalendar];
    
    {
        NSCalendar* calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *addition = [[NSDateComponents alloc] init];
        [addition setDay:0];
        [addition setYear:0];
        [addition setMonth:sign];
        
        firstDayOfMonth = [calendar dateByAddingComponents:addition toDate:firstDayOfMonth options:0];
        
        // Get first day of previous month
        NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit
                                              fromDate:firstDayOfMonth];
        NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:[cal dateFromComponents:comps]];
        dayInMonth = (int)range.length;
        monthNo = (int)comps.month;
        dayNo = (int)comps.day;
        yearNo = (int)comps.year;
        
        //NSLog(@"Start of month : %@", firstDayOfMonth.description);
        for(int i=0; i<(int)range.length; i++){
            [addition setMonth:0];
            [addition setYear:0];
            [addition setDay:i];
            
            NSDate *generateDate = [calendar dateByAddingComponents:addition toDate:firstDayOfMonth options:0];
            
            NSDateComponents *comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit
                                                  fromDate:generateDate];
            /*NSLog(@"StartOfDay %d /%d/ %d, weekNo: %d, date;%d, weekDay:%d, firstWeekofDay:%d, weekofmonth:%d",
                  (int)comps.day, (int)comps.month, (int)comps.year,
                  (int)comps.weekOfMonth,
                  (int)comps.day,
                  (int)comps.weekday,
                  (int)calendar.firstWeekday,
                  (int)comps.weekOfMonth);*/
            
            
            // Special case: to plot data of previous month, need to know the index of the weekday in  first day of current month.
            if(i==0 && comps.weekday > 0){
                offsetFirstDayOfMonth = (int)-comps.weekday;
            }
            
            weeksInMonth = (int)comps.weekOfMonth;
        }
        
    }
    
    monthLabel.text = [NSString stringWithFormat:@"%@ %d", [[dateFormatter monthSymbols] objectAtIndex:monthNo-1], yearNo ];
    
    [self readHolidayDataOfThisMonth];
    
    [self.calendarView reloadData];

}

- (void) readHolidayData
{

    [self startProgressBar];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"holiday"
                                                     ofType:@"json"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSString *jsonString    = content;
    NSData *jsonData        = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error          = nil;
    
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    if(dictionary!=nil){
        NSArray* holidays = [dictionary objectForKey:@"HOLIDAYS"];
        
        for(int i=0; i<[holidays count]; i++){
            
            NSDictionary *hDict = [holidays objectAtIndex:i];
            
            Holiday *holiday = [[Holiday alloc] init];
            holiday.name = [hDict objectForKey:@"NAME"];
            holiday.date = [hDict objectForKey:@"DATE"];
            holiday.description = [hDict objectForKey:@"DESCRIPTION"];
            
            holiday.url = [hDict objectForKey:@"URL"];
            if([hDict objectForKey:@"DAY"]){
                holiday.day = [[hDict objectForKey:@"DAY"] intValue];
            }
            if( [hDict objectForKey:@"MONTH"] ){
            holiday.month = [[hDict objectForKey:@"MONTH"] intValue];
            }
            
            if( [hDict objectForKey:@"YEAR"] ){
            holiday.year = [[hDict objectForKey:@"YEAR"] intValue];
            }
            
            [holidayList addObject:holiday];
        }
    }
    
    [self endProgressBar];

}

- (void) readHolidayDataOfThisMonth
{
    [holidayMonthFilterList removeAllObjects];
    
    for(Holiday *holiday in holidayList)
    {
        if(holiday.month == monthNo && holiday.year == yearNo){
            [holidayMonthFilterList addObject:holiday];
        }
    }
    
}

- (void) eventBtnAction:(UIButton*) button
{

}


- (void) holidayBtnAction: (UIButton*) button
{
    int btnIndex = (int)button.tag ;

    Holiday *holiday = [holidayMonthFilterList objectAtIndex:btnIndex];
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    dateFormat1.dateFormat = @"yyyyMMdd";
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    dateFormat2.dateFormat = @"MMMM dd, yyyy";
    NSDate *date = [dateFormat1 dateFromString: holiday.date];
    
    
    NSString *dateFormatD = [NSString stringWithFormat:@"%@ (Holiday)", [dateFormat2  stringFromDate:date] ];
    self.eventView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    self.eventLabel.text = dateFormatD;
    self.eventLabel.textColor = [UIColor whiteColor];
    self.eventTextView.text = holiday.name ;
    self.eventTextView.textColor = [UIColor whiteColor];
    self.eventTextView.backgroundColor = [UIColor clearColor];
    self.eventLabel.font = ThemeFontNormalDiff(-1);
    self.eventTextView.font = ThemeFontNormalDiff(-1);
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.eventView.frame = CGRectMake(
                                          self.eventView.frame.origin.x,
                                          self.view.frame.size.height - 200,
                                          self.eventView.frame.size.width,
                                          200
                                          );
    
        self.btnCover.frame = CGRectMake(
                                         0,
                                         0,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height
                                         );
         }];
}

-(void) hideEventDetail
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self.btnCover.frame = CGRectMake(
                                         0,
                                         self.view.frame.size.height,
                                         self.view.frame.size.width,
                                         self.view.frame.size.height
                                         );
        
        self.eventView.frame = CGRectMake(
                                          self.eventView.frame.origin.x,
                                          self.view.frame.size.height,
                                          self.eventView.frame.size.width,
                                          200
                                          );

    }];
}

@end
