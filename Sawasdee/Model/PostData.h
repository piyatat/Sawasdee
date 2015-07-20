//
//  PostData.h
//  Sawasdee
//
//  Created by BooBoo on 7/31/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostData : NSObject
{
    NSString *key;
    NSString *value;
}

@property (nonatomic, retain, readwrite) NSString *key;
@property (nonatomic, retain, readwrite) NSString *value;
@end
