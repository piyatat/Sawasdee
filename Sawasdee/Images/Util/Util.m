
//
//  Util.m
//  Sawasdee
//
//  Created by BooBoo on 8/2/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "Util.h"

static Util *sharedUtil = nil;

@implementation Util

@synthesize currentView;

+ (Util *)sharedUtil
{
    if (sharedUtil == nil) {
        sharedUtil = [[super allocWithZone:NULL] init];
		
		[sharedUtil initialize];
    }
    return sharedUtil;
}

- (void)initialize
{
    isLoadingImage = NO;
    cachedImageURLQueueList = [[NSMutableArray alloc] init];
    cachedImageDictionary = [[NSMutableDictionary alloc] init];
    notFoundImageURLList = [[NSMutableArray alloc] init];
}

- (void)setThemeType:(THEME_TYPE)themeType
{
    
    NSString *themeValue = @"";
    switch (themeType) {
        case BLUE_THEME:
            themeValue = @"Blue";
            break;
        case GREEN_THEME:
            themeValue = @"Green";
            break;
        case PINK_THEME:
            themeValue = @"Pink";
            break;
        case ORANGE_THEME:
            themeValue = @"Orange";
            break;
        case NONE_THEME:
            themeValue = @"None";
            break;
        default:
            themeValue = @"Pink";
            break;
    }
    
    // Save theme parameter to user preferences
    [[NSUserDefaults standardUserDefaults] setValue:themeValue forKey:THEME_KEY];
    
    // Update Theme images object
    [self loadThemeDescription:themeType];
}

- (THEME_TYPE)getSelectedThemeType
{
    
    NSString *themeValue;
    
    // Get theme parameter from user preferences
    if([[NSUserDefaults standardUserDefaults] valueForKey:THEME_KEY]){
        themeValue = (NSString*)[[NSUserDefaults standardUserDefaults] valueForKey:THEME_KEY];
    }else{
        themeValue = @"Pink";
    }
    
    // Map theme from user preference to THEME_TYPE object
    THEME_TYPE themeType;
    if( [themeValue isEqualToString:@"Blue"] ){
        themeType = BLUE_THEME;
    }else if( [themeValue isEqualToString:@"Green"] ){
        themeType = GREEN_THEME;
    }else if( [themeValue isEqualToString:@"Pink"] ){
        themeType = PINK_THEME;
    }else if( [themeValue isEqualToString:@"Orange"] ){
        themeType = ORANGE_THEME;
    }else if( [themeValue isEqualToString:@"None"] ){
        themeType = NONE_THEME;
    }else{
        themeType = PINK_THEME;
    }
    return themeType;
}

- (Theme *)getThemeDescription
{
    // Get theme value from preference
    THEME_TYPE userTheme = [self getSelectedThemeType];
    
    // load theme image to object instance
    Theme *theme = [self loadThemeDescription:userTheme];
    
    return theme;
    
}

- (Theme*)loadThemeDescription:(THEME_TYPE) themeType{
    
    Theme *theme = [[Theme alloc] init];
    switch (themeType) {
        case BLUE_THEME:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_BLUE;
                //theme.bottom = THEME_BOTTOM_BLUE;
                theme.top = THEME_TOPBAR_BLUE;
            }else if (IS_IPAD) {
                theme.background = THEME_BACKGROUND_BLUE;
                //theme.bottom = THEME_BOTTOM_BLUE;
                theme.top = THEME_TOPBAR_BLUE_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_BLUE_IV4;
                //theme.bottom = THEME_BOTTOM_BLUE_IV4;
                theme.top = THEME_TOPBAR_BLUE_IV4;
            }
            break;
            
        case GREEN_THEME:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_GREEN;
                //theme.bottom = THEME_BOTTOM_GREEN;
                theme.top = THEME_TOPBAR_GREEN;
            }else if (IS_IPAD) {
                theme.background = THEME_BACKGROUND_GREEN;
                //theme.bottom = THEME_BOTTOM_GREEN;
                theme.top = THEME_TOPBAR_GREEN_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_GREEN_IV4;
                //theme.bottom = THEME_BOTTOM_GREEN_IV4;
                theme.top = THEME_TOPBAR_GREEN_IV4;
            }
            break;
            
        case PINK_THEME:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_PINK;
                //theme.bottom =THEME_BOTTOM_PINK;
                theme.top = THEME_TOPBAR_PINK;
            }else if (IS_IPAD) {
                theme.background = THEME_BACKGROUND_PINK;
                //theme.bottom =THEME_BOTTOM_PINK;
                theme.top = THEME_TOPBAR_PINK_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_PINK_IV4;
                //theme.bottom =THEME_BOTTOM_PINK_IV4;
                theme.top = THEME_TOPBAR_PINK_IV4;
            }
            break;
            
        case ORANGE_THEME:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_ORANGE;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_ORANGE;
            }else if(IS_IPAD){
                theme.background = THEME_BACKGROUND_ORANGE;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_ORANGE_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_ORANGE_IV4;
                //theme.bottom = THEME_BOTTOM_ORANGE_IV4;
                theme.top = THEME_TOPBAR_ORANGE_IV4;
            }
            break;
            
        case NONE_THEME:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_NONE;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_GREEN;
            }else if(IS_IPAD){
                theme.background = THEME_BACKGROUND_NONE_IPAD;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_GREEN_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_NONE;
                //theme.bottom = THEME_BOTTOM_ORANGE_IV4;
                theme.top = THEME_TOPBAR_GREEN;
            }
            break;
        default:
            if (IS_IPHONE4INCH) {
                theme.background = THEME_BACKGROUND_NONE;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_GREEN;
            }else if(IS_IPAD){
                theme.background = THEME_BACKGROUND_NONE_IPAD;
                //theme.bottom = THEME_BOTTOM_ORANGE;
                theme.top = THEME_TOPBAR_GREEN_IPAD;
            }else{
                theme.background = THEME_BACKGROUND_NONE;
                //theme.bottom = THEME_BOTTOM_ORANGE_IV4;
                theme.top = THEME_TOPBAR_GREEN;
            }
            break;
    }
    
    return theme;
}


#pragma mark - Image Caching Method

- (UIImage *)cachedImageAtURL:(NSURL *)imageURL
       withPlacementImageName:(NSString *)placementImageName
                    isLoading:(BOOL *)loading
{
    // Get image from cache
    UIImage *image = [cachedImageDictionary objectForKey:imageURL];
    
    // image is not cached yet
    if (image == nil) {
        // check if it is in not found list
        if ([notFoundImageURLList containsObject:imageURL]) {
            *loading = NO;
            if (placementImageName) {
                return [UIImage imageNamed:placementImageName];
            } else {
                return nil;
            }
        }
        
        *loading = YES;
        // check if it is in the queue
        if ([cachedImageURLQueueList containsObject:imageURL] == NO) {
            [cachedImageURLQueueList addObject:imageURL];
        }
        
        if (isLoadingImage == NO) {
            // Start loading image
            isLoadingImage = YES;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                while ([cachedImageURLQueueList count] > 0) {
                    NSURL *_imageURL = [cachedImageURLQueueList objectAtIndex:0];
                    UIImage *_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:_imageURL]];
                    if (_image) {
                        NSLog(@"Cached image at URL: %@", _imageURL);
                        
                        [cachedImageDictionary setObject:_image
                                                  forKey:_imageURL];
                    } else {
                        NSLog(@"Image not found for URL: %@", _imageURL);
                        [notFoundImageURLList addObject:_imageURL];
                    }
                    
                    [cachedImageURLQueueList removeObjectAtIndex:0];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:ImageCachedNotificationKey object:_imageURL];
                }
                isLoadingImage = NO;
            });
        }
        
        if (placementImageName) {
            return [UIImage imageNamed:placementImageName];
        } else {
            return nil;
        }
    } else {
        *loading = NO;
        return image;
    }
}

- (void)clearCachedImage
{
    [cachedImageDictionary removeAllObjects];
}

- (BOOL) getImageSearchSetting
{
    NSString *preference = [[NSUserDefaults standardUserDefaults] objectForKey:ImageSearch];
    if(preference!=nil && [preference isEqualToString:@"NO"]){
        return NO;
    }
    
    return YES;
}

- (void) setImageSearchSetting:(BOOL) isAllow
{
    if( isAllow ){
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:ImageSearch];

    }else{
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:ImageSearch];
    }

}


@end
