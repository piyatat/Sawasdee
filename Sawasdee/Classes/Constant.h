/* 
  Constant.h
  Sawasdee

  Created by BooBoo on 7/25/2557 BE.
  Copyright (c) 2557 B2HOME. All rights reserved.
*/


// AdMob ID
#define ADMOB_KEY                   @""
#define AdMobUpdateEvent            @"AdMobUpdateEvent"

// Flurry Key
#define FlurryAPI_KEY               @""

// Cloud URL
#define URL_CLOUD_SERVICE           @""
#define APP_ENGINE_KEY              @""

// Cloud URL
#define IMAGE_SERVICE               @""

// App ID
#define APP_ID                      @""

// Sawasdee Key
#define SAWASDEE_KEY                @""

// Notification key
#define ImageCachedNotificationKey  @"ImageCachedNotificationKey"

// Image search
#define ImageSearch                 @"SEARCH_KEY"

// Font
#define SYSTEM_FONT_NORMAL                          @"Helvetica"
#define FontNormal                                  @"ArialMT"
#define FontBold                                    @"Arial-BoldMT"
#define FontItalic                                  @"Arial-ItalicMT"
#define PlacementTextColor                          [UIColor lightGrayColor]

#define ThemeFontNormal                             [UIFont fontWithName:FontNormal size:12]
#define ThemeFontBold                               [UIFont fontWithName:FontBold size:12]
#define ThemeFontHeader                             [UIFont fontWithName:FontBold size:12]
#define ThemeFontItalic                             [UIFont fontWithName:FontItalic size:12]

#define ThemeFontNormal_iPad                        [UIFont fontWithName:FontNormal size:15]
#define ThemeFontBold_iPad                          [UIFont fontWithName:FontBold size:15]
#define ThemeFontHeader_iPad                        [UIFont fontWithName:FontBold size:17]
#define ThemeFontItalic_iPad                        [UIFont fontWithName:FontItalic size:15]

#define ThemeFontNormalDiff(diff)                    ([UIFont fontWithName:FontNormal size:12+diff])
#define ThemeFontItalicDiff(diff)                    ([UIFont fontWithName:FontItalic size:12+diff])

#define BBLog(...)                                  NSLog(__VA_ARGS__)
//#define BBLog(...)                                CLS_LOG(__VA_ARGS__)

#define IS_IPAD_UI()                                ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )?YES: NO


#define TOP_RECOMMEND_AMOUNT                        5

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_IPHONE       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE4INCH  (IS_IPHONE && ([[UIScreen mainScreen] bounds].size.height > 480))


#define THEME_KEY                                   @"ThemeType"

//Theme images
#define THEME_BACKGROUND_BLUE                       @"background-blue.png"
#define THEME_BACKGROUND_GREEN                      @"background-green.png"
#define THEME_BACKGROUND_ORANGE                     @"background-orange.png"
#define THEME_BACKGROUND_PINK                       @"background-pink.png"
#define THEME_BACKGROUND_NONE                       @"background-none.png"
#define THEME_BACKGROUND_NONE_IPAD                  @"background-none-ipad.png"

#define THEME_BACKGROUND_BLUE_IV4                   @"background_iv4-blue.png"
#define THEME_BACKGROUND_GREEN_IV4                  @"background_iv4-green.png"
#define THEME_BACKGROUND_ORANGE_IV4                 @"background_iv4-orange.png"
#define THEME_BACKGROUND_PINK_IV4                   @"background_iv4-pink.png"

//#define THEME_BOTTOM_BLUE                         @""
#define THEME_TOPBAR_BLUE                           @"app-topbar-blue.png"
#define THEME_TOPBAR_GREEN                          @"app-topbar-green.png"
#define THEME_TOPBAR_ORANGE                         @"app-topbar-orange.png"
#define THEME_TOPBAR_PINK                           @"app-topbar-pink.png"

#define THEME_TOPBAR_BLUE_IV4                       @"app-topbar-blue.png"
#define THEME_TOPBAR_GREEN_IV4                      @"app-topbar-green.png"
#define THEME_TOPBAR_ORANGE_IV4                     @"app-topbar-orange.png"
#define THEME_TOPBAR_PINK_IV4                       @"app-topbar-pink.png"

#define THEME_TOPBAR_BLUE_IPAD                      @"app-topbar-ipad-blue.png"
#define THEME_TOPBAR_GREEN_IPAD                     @"app-topbar-ipad-green.png"
#define THEME_TOPBAR_ORANGE_IPAD                    @"app-topbar-ipad-orange.png"
#define THEME_TOPBAR_PINK_IPAD                      @"app-topbar-ipad-pink.png"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

typedef enum{
    BLUE_THEME = 0,
    GREEN_THEME,
    PINK_THEME,
    ORANGE_THEME,
    NONE_THEME,
    ROW_NUMS_THEME_TYPE
}THEME_TYPE;

typedef enum{
    SEARCH_VIEW = 0,
    CATEGORY_SEARCH_VIEW,
    REQUEST_VIEW,
    SETTING_VIEW,
    RELATE_WORD_VIEW,
    CLOCK_VIEW,
    CURRENCY_VIEW,
    DIGIT_VIEW,
    ROW_NUMS_VIEW_NAME
}VIEW_NAME;


typedef enum{
    SPEAK_MENU = 0,
    CALENDAR_MENU,
    DIGIT_MENU,
    CURRENCY_MENU,
    REQUEST_MENU,
    SETTING_MENU,
    MENU_NUMBER_MENU
}MENU_NAME;
