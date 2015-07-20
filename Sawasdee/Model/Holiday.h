//
//  Holiday.h
//  Sawasdee
//
//  Created by BooBoo on 8/7/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Holiday : NSObject
{
    NSString *date;
    NSString *name;
    NSString *description;
    NSString *url;
    int day;
    int month;
    int year;
}

@property (nonatomic, retain, readwrite)     NSString *date;
@property (nonatomic, retain, readwrite)     NSString *name;
@property (nonatomic, retain, readwrite)     NSString *description;

@property (nonatomic, retain, readwrite)     NSString *url;
@property (nonatomic, assign, readwrite)     int day;
@property (nonatomic, assign, readwrite)     int month;
@property (nonatomic, assign, readwrite)     int year;

@end
