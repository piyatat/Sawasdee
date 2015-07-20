//
//  Word.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Word : NSObject
{
    NSString *word;
    NSArray *tag;
    NSMutableDictionary *meanings;
    NSMutableDictionary *karaokes;
}

@property (nonatomic, retain, readwrite) NSString *word;
@property (nonatomic, retain, readwrite) NSArray *tag;
@property (nonatomic, retain, readwrite) NSMutableDictionary *meanings;
@property (nonatomic, retain, readwrite) NSMutableDictionary *karaokes;

@end
