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

- (void)assertEntries:(NSArray *)entries
           namedKeys:(NSArray<NSString *> *)keys
            fileHint:(NSString *)fileHint
{
    XCTAssertTrue([entries isKindOfClass:[NSArray class]], @"%@ root array missing", fileHint);
    XCTAssertGreaterThan(entries.count, 0u, @"%@ should not be empty", fileHint);
    [entries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XCTAssertTrue([obj isKindOfClass:[NSDictionary class]], @"%@[%lu] should be an object", fileHint, (unsigned long)idx);
        NSDictionary *entry = (NSDictionary *)obj;
        for (NSString *key in keys) {
            id value = entry[key];
            XCTAssertNotNil(value, @"%@[%lu] missing %@", fileHint, (unsigned long)idx, key);
            if ([value isKindOfClass:[NSString class]]) {
                XCTAssertGreaterThan([(NSString *)value length], 0u, @"%@[%lu].%@ empty", fileHint, (unsigned long)idx, key);
            } else if ([value isKindOfClass:[NSDictionary class]]) {
                XCTAssertGreaterThan([(NSDictionary *)value count], 0u, @"%@[%lu].%@ empty", fileHint, (unsigned long)idx, key);
            } else if ([value isKindOfClass:[NSArray class]]) {
                XCTAssertGreaterThan([(NSArray *)value count], 0u, @"%@[%lu].%@ empty", fileHint, (unsigned long)idx, key);
            }
        }
    }];
}

- (void)assertHolidayDateFields:(NSDictionary *)entry index:(NSUInteger)idx
{
    NSString *fileHint = @"holiday.json";
    NSString *date = entry[@"DATE"];
    NSString *day = entry[@"DAY"];
    NSString *month = entry[@"MONTH"];
    NSString *year = entry[@"YEAR"];

    NSRegularExpression *dateRegex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]{8}$" options:0 error:nil];
    NSUInteger matches = [dateRegex numberOfMatchesInString:date options:0 range:NSMakeRange(0, date.length)];
    XCTAssertEqual(matches, 1u, @"%@[%lu].DATE should be YYYYMMDD, got %@", fileHint, (unsigned long)idx, date);

    if (year.length > 0 && month.length > 0 && day.length > 0) {
        NSString *expected = [NSString stringWithFormat:@"%@%@%@", year, month, day];
        XCTAssertEqualObjects(date, expected, @"%@[%lu].DATE should match YEAR+MONTH+DAY", fileHint, (unsigned long)idx);
    }
}

- (void)testContentJSONIsStrictlyValid
{
    NSDictionary *words = [self dictionaryFromContentJSONNamed:@"words"];
    [self assertEntries:words[@"ITEMS"]
              namedKeys:@[@"WORD", @"TAG", @"MEANING", @"KARAOKE"]
               fileHint:@"words.json"];

    NSDictionary *categories = [self dictionaryFromContentJSONNamed:@"categories"];
    [self assertEntries:categories[@"CATEGORIES"]
              namedKeys:@[@"NAME", @"DESCRIPTION"]
               fileHint:@"categories.json"];

    NSDictionary *currencies = [self dictionaryFromContentJSONNamed:@"currencies"];
    [self assertEntries:currencies[@"CURRENCIES"]
              namedKeys:@[@"VALUE", @"NAME", @"IMAGE", @"DESCRIPTION", @"READ", @"KARAOKE"]
               fileHint:@"currencies.json"];

    NSDictionary *holidays = [self dictionaryFromContentJSONNamed:@"holiday"];
    NSArray *holidayEntries = holidays[@"HOLIDAYS"];
    [self assertEntries:holidayEntries
              namedKeys:@[@"DATE", @"NAME", @"DESCRIPTION"]
               fileHint:@"holiday.json"];
    [holidayEntries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self assertHolidayDateFields:(NSDictionary *)obj index:idx];
    }];
}

- (void)testWordsHaveUniqueEntries
{
    NSDictionary *words = [self dictionaryFromContentJSONNamed:@"words"];
    NSArray *entries = words[@"ITEMS"];
    NSMutableSet *seen = [NSMutableSet set];
    [entries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *word = ((NSDictionary *)obj)[@"WORD"];
        XCTAssertNotNil(word, @"words.json[%lu] missing WORD", (unsigned long)idx);
        XCTAssertFalse([seen containsObject:word], @"Duplicate WORD %@ at index %lu", word, (unsigned long)idx);
        [seen addObject:word];
    }];
}

- (void)testCategoriesHaveUniqueNames
{
    NSDictionary *categories = [self dictionaryFromContentJSONNamed:@"categories"];
    NSArray *entries = categories[@"CATEGORIES"];
    NSMutableSet *seen = [NSMutableSet set];
    [entries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *name = ((NSDictionary *)obj)[@"NAME"];
        XCTAssertNotNil(name, @"categories.json[%lu] missing NAME", (unsigned long)idx);
        XCTAssertFalse([seen containsObject:name], @"Duplicate NAME %@ at index %lu", name, (unsigned long)idx);
        [seen addObject:name];
    }];
}

@end
