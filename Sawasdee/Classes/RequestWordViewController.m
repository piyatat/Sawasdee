//
//  RequestWordViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/31/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "RequestWordViewController.h"
#import "RequestWordViewCell.h"
#import "CJSONDeserializer.h"
#import "Word.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@implementation RequestWordViewController

@synthesize tableView;
@synthesize wordList;
//@synthesize topBarView;
//@synthesize settingIconView;
//@synthesize appIconView;
//@synthesize bgView;
@synthesize requestView;
@synthesize submitBtn;
@synthesize wordField;
@synthesize wordLabel;
@synthesize scrollView;
//@synthesize backIconView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    wordList = [[NSMutableArray alloc] init];
    btnList = [[NSMutableArray alloc] init];;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
    // Create components
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil];
    UIBarButtonItem *keyboardDoneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                           style:UIBarButtonItemStyleDone
                                                                          target:self
                                                                          action:@selector(hideKeyboard)];
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    keyboardToolbar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 44);
    keyboardToolbar.items = [NSArray arrayWithObjects:flex, keyboardDoneButton, nil];
    
    self.wordField.placeholder = @"";
    self.wordField.leftViewMode = UITextFieldViewModeAlways;
    self.wordField.inputAccessoryView = keyboardToolbar;
    self.wordField.textColor = [UIColor blackColor];
    
    self.wordLabel.text = @"Ask us for other words?";
    self.wordLabel.font = ThemeFontNormal;
    
    [self.submitBtn setTitleColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0] forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.submitBtn.titleLabel setFont:ThemeFontNormal];
    self.submitBtn.backgroundColor = [UIColor clearColor];
    
    self.wordField.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    
    self.requestView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.3];
    
//    [self.backIconView setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [self.backIconView setImage:[UIImage imageNamed:@"back_hover.png"] forState:UIControlStateHighlighted];
//    [self.backIconView addTarget:self action:@selector(backToFirstPage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [[Util sharedUtil] setCurrentView:REQUEST_VIEW];
    
//    self.bgView.image = [UIImage imageNamed:[self getThemeDescription].background];
//    self.topBarView.image = [UIImage imageNamed:[self getThemeDescription].top];
//    
//    [self.settingIconView setImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    [self.settingIconView setImage:[UIImage imageNamed:@"setting_hover.png"] forState:UIControlStateHighlighted];
//    [self.settingIconView addTarget:self action:@selector(settingTheme) forControlEvents:UIControlEventTouchUpInside];

    [self startProgressBar];
    [self getRequestWordList];
    [self endProgressBar];
}

#pragma mark - UITableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RequestWordViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"RequestWordViewCellID"];
    
    NSDictionary *dict = [wordList objectAtIndex:indexPath.row];
        
    cell.wordLabel.text = [dict objectForKey:@"word"];
    cell.wordLabel.font = ThemeFontNormal;
    cell.backgroundColor = [UIColor clearColor];
        
    if(IS_IPAD_UI()){
        cell.wordLabel.font = ThemeFontNormal_iPad;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.section == 0){
//        NSDictionary *dict = [categoryList objectAtIndex:indexPath.row];
//        [self goToCategoryViewWithName:[dict objectForKey:@"NAME" ]];
//        
//    }else if(indexPath.section == 1){
//        
//        Word *word = [filterList objectAtIndex:indexPath.row];
//        NSMutableDictionary *meanings = word.meanings;
//        NSString *meaning = [meanings objectForKey:@"th_TH"];
//        
//        NSString *locale = @"th-TH";
//        
//        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString: meaning];
//        [utterance setRate:0.2f];
//        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage: locale ];
//        [synthesizer speakUtterance:utterance];
//    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [wordList count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 70;
    }else{
        return 57;
    }
}

#pragma mark - Instance method
-(void) submitAction
{
    if(wordField.text != nil){
        
        [self startProgressBar];
        
        [self submitRequestWord:wordField.text];
        
        [self endProgressBar];
        
        [self hideKeyboard];
        
        self.wordField.text = @"";
    }
}

-(void) submitRequestWord:(NSString*) word
{
    if(word!=nil && ![word isEqualToString:@""]){
        NSString *serviceURL = [NSString stringWithFormat:@"%@requestword",URL_CLOUD_SERVICE];
        NSDictionary *parameters = @{@"sourceWord": word, @"sourceLanguageCode": @"EN", @"destinationLanguageCode": @"TH", @"key": APP_ENGINE_KEY  } ;
        
        NSError *error;
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:serviceURL parameters:parameters error:&error];
        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        op.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self getRequestWordList];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Complete"
                                                                message:@"Succesfully submit. Come back later to get update from your request."
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        [[NSOperationQueue mainQueue] addOperation:op];
    }else{
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Please fill empty field."
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

-(void) getRequestWordList
{
    NSString *serviceURL = [NSString stringWithFormat:@"%@listhotword",URL_CLOUD_SERVICE];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:serviceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *JSON = operation.responseString;
        [self updateWordListUI:JSON];
 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void) updateWordListUI:(NSString*) wString
{

    [wordList removeAllObjects];
 
    NSData *jsonData = [wString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *wList = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];

    if(wList!=nil){
        for(int i=0; i<[wList count]; i++){
            NSDictionary *wDict = [wList objectAtIndex:i];
            if( [wDict objectForKey:@"sourceWord"]!=nil){
            NSArray *keys  = [[NSArray alloc] initWithObjects:@"word", nil];
            NSArray *values  = [[NSArray alloc] initWithObjects:[wDict objectForKey:@"sourceWord"] , nil];
            NSDictionary *dict = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
            [wordList addObject:dict];
            }
        }
    }
    
    
    int xSpace = 10;
    int ySpace = 10;
    int xOffset = xSpace;
    int yOffset = ySpace;
    
    int w = 300;
    int h = 37;
    int wPadding = 20;
    
    int tempIdx = 0;
    
    for(UIButton *btn in btnList){
        [btn removeFromSuperview];
    }
    [btnList removeAllObjects];
    
    for (int i = 0; i < [wordList count]; i++) {
//        NSDictionary *dict = [tagDictList objectAtIndex:i];
//        NSString *type = [dict objectForKey:DiscoverDictTagTypeKey];
//        NSString *value = [dict objectForKey:DiscoverDictTagValueKey];
        NSDictionary *dict = [wordList objectAtIndex:i];
        NSString *title = [dict objectForKey:@"word"];
        
//        if ([type isEqualToString:DiscoverDictTagTypeActivity]) {
//            title = [[FeedManager LocalizedDictionaryForActivityName:value] objectForKey:[ThemesManager shared].currentLanguage.languageId];
//        } else if ([type isEqualToString:DiscoverDictTagTypeGenre]) {
//            title = [[FeedManager LocalizedDictionaryForGenreName:value] objectForKey:[ThemesManager shared].currentLanguage.languageId];
//        } else if ([type isEqualToString:DiscoverDictTagTypeMood]) {
//            title = [[FeedManager LocalizedDictionaryForMoodName:value] objectForKey:[ThemesManager shared].currentLanguage.languageId];
//        }
//        
//        if (title == nil || [title length] == 0) {
//            title = value;
//        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(xOffset, yOffset, w, h);
        btn.backgroundColor = [UIColor clearColor];
        //btn.layer.borderColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8].CGColor;
        btn.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.8].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds = YES;
        
        //[btn addTarget:self action:@selector(onTagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = ThemeFontNormal;
        [btn setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn sizeToFit];
        
        CGRect frame = btn.frame;
        frame.size.height = h;
        frame.size.width += wPadding;
        if (frame.size.width > w) {
            // if text is too long, just truncate it
            frame.size.width = w;
        }
        if (frame.origin.x + frame.size.width + xSpace >= self.scrollView.frame.size.width) {
            xOffset = xSpace;
            yOffset = yOffset + h + ySpace;
            frame.origin.x = xOffset;
            frame.origin.y = yOffset;
            
            // rearrange btn in the current row to center
            int tempTotalW = xSpace;
            for (int j = tempIdx; j < i; j++) {
                UIButton *tempBtn = [btnList objectAtIndex:j];
                tempTotalW += tempBtn.frame.size.width + xSpace;
            }
            int tempXOffset = (self.scrollView.frame.size.width - tempTotalW) * 0.5 + xSpace;
            for (int j = tempIdx; j < i; j++) {
                UIButton *tempBtn = [btnList objectAtIndex:j];
                CGRect tempFrame = tempBtn.frame;
                tempFrame.origin.x = tempXOffset;
                tempBtn.frame = tempFrame;
                
                tempXOffset += tempFrame.size.width + xSpace;
            }
            tempIdx = i;
        }
        btn.frame = frame;
        xOffset += frame.size.width + xSpace;
        
        [self.scrollView addSubview:btn];
        [btnList addObject:btn];
    }
    // rearrange btn in the last row to center
    int tempTotalW = xSpace;
    for (int j = tempIdx; j < [btnList count]; j++) {
        UIButton *tempBtn = [btnList objectAtIndex:j];
        tempTotalW += tempBtn.frame.size.width + xSpace;
    }
    int tempXOffset = (self.scrollView.frame.size.width - tempTotalW) * 0.5 + xSpace;
    for (int j = tempIdx; j < [btnList count]; j++) {
        UIButton *tempBtn = [btnList objectAtIndex:j];
        CGRect tempFrame = tempBtn.frame;
        tempFrame.origin.x = tempXOffset;
        tempBtn.frame = tempFrame;
        
        tempXOffset += tempFrame.size.width + xSpace;
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, yOffset + h + ySpace);
    
    [self.tableView reloadData];


}

- (void)hideKeyboard
{
    [wordField resignFirstResponder];
}


@end
