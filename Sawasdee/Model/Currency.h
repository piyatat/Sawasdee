//
//  Currency.h
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject
{
    NSString *name;
    NSString *value;
    NSString *image;
    NSString *description;
    NSString *read;
    NSString *karaoke;
}

@property (nonatomic, retain, readwrite)     NSString *name;
@property (nonatomic, retain, readwrite)     NSString *value;
@property (nonatomic, retain, readwrite)     NSString *image;
@property (nonatomic, retain, readwrite)     NSString *description;
@property (nonatomic, retain, readwrite)     NSString *read;
@property (nonatomic, retain, readwrite)     NSString *karaoke;

@end

