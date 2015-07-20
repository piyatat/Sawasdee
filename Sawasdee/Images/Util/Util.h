//
//  Util.h
//  Sawasdee
//
//  Created by BooBoo on 8/2/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
{
    BOOL isLoadingImage;
    BOOL isLoadingNotification;
    
    // store image url to load in order
    NSMutableArray *cachedImageURLQueueList;
    // cached image dictionary
    NSMutableDictionary *cachedImageDictionary;
    // not found image url
    NSMutableArray *notFoundImageURLList;
    
    VIEW_NAME currentView;
}
@property (nonatomic, readwrite) VIEW_NAME currentView;

- (Theme *)getThemeDescription;
- (THEME_TYPE)getSelectedThemeType;
- (void)setThemeType:(THEME_TYPE)themeType;

- (UIImage *)cachedImageAtURL:(NSURL *)imageURL
       withPlacementImageName:(NSString *)placementImageName
                    isLoading:(BOOL *)loading;
- (void)clearCachedImage;
- (BOOL) getImageSearchSetting;
- (void) setImageSearchSetting:(BOOL) isAllow;

+ (Util *)sharedUtil;

@end
