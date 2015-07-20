//
//  Theme.h
//  BBPlayer
//
//  Created by BooBoo on 6/4/2557 BE.
//  Copyright (c) 2557 B2Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Theme : NSObject
{
    NSString *background;
    NSString *bottom;
    NSString *top;
}

@property (nonatomic, strong, readwrite)     NSString *background;
@property (nonatomic, strong, readwrite)     NSString *bottom;
@property (nonatomic, strong, readwrite)     NSString *top;
@end
