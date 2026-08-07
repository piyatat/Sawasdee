//
//  SawasdeeTests.m
//  SawasdeeTests
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface SawasdeeTests : XCTestCase

@end

@implementation SawasdeeTests

- (NSData *)dataForContentJSONNamed:(NSString *)name
{
    // Prefer the app bundle when tests are hosted; fall back to the source tree
    // so the suite still runs from Xcode without copying resources into the test target.
    NSBundle *appBundle = [NSBundle bundleForClass:NSClassFromString(@"AppDelegate")];
    if (appBundle == nil) {
        appBundle = [NSBundle mainBundle];
    }
    NSString *path = [appBundle pathForResource:name ofType:@"json"];
    if (path == nil) {
        NSString *here = [@(__FILE__) stringByDeletingLastPathComponent];
        path = [[here stringByAppendingPathComponent:@"../Sawasdee"] stringByAppendingPathComponent:[name stringByAppendingString:@".json"]];
        path = [path stringByStandardizingPath];
    }
    return [NSData dataWithContentsOfFile:path];
}

- (NSDictionary *)dictionaryFromContentJSONNamed:(NSString *)name
{
    NSData *data = [self dataForContentJSONNamed:name];
    XCTAssertNotNil(data, @"Missing content JSON: %@.json", name);
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    XCTAssertNil(error, @"%@.json parse error: %@", name, error);
    XCTAssertTrue([object isKindOfClass:[NSDictionary class]], @"%@.json root should be an object", name);
    return (NSDictionary *)object;
}

- (void)testContentJSONIsStrictlyValid
{
    NSDictionary *words = [self dictionaryFromContentJSONNamed:@"words"];
    XCTAssertTrue([words[@"ITEMS"] isKindOfClass:[NSArray class]]);
    XCTAssertGreaterThan([(NSArray *)words[@"ITEMS"] count], 0u);

    NSDictionary *categories = [self dictionaryFromContentJSONNamed:@"categories"];
    XCTAssertTrue([categories[@"CATEGORIES"] isKindOfClass:[NSArray class]]);
    XCTAssertGreaterThan([(NSArray *)categories[@"CATEGORIES"] count], 0u);

    NSDictionary *currencies = [self dictionaryFromContentJSONNamed:@"currencies"];
    XCTAssertTrue([currencies[@"CURRENCIES"] isKindOfClass:[NSArray class]]);
    XCTAssertGreaterThan([(NSArray *)currencies[@"CURRENCIES"] count], 0u);

    NSDictionary *holidays = [self dictionaryFromContentJSONNamed:@"holiday"];
    XCTAssertTrue([holidays[@"HOLIDAYS"] isKindOfClass:[NSArray class]]);
    XCTAssertGreaterThan([(NSArray *)holidays[@"HOLIDAYS"] count], 0u);
}

@end
