//
//  SearchViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewCell.h"
#import "CategoryViewCell.h"
#import "CJSONDeserializer.h"
#import "CategorySearchViewController.h"

@implementation SearchViewController

@synthesize tableView;
@synthesize wordList;
@synthesize searchBar;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //synthesizer = [[AVSpeechSynthesizer alloc]init];
    wordList = [[NSMutableArray alloc] init];
    filterList = [[NSMutableArray alloc] init];
    categoryList = [[NSMutableArray alloc] init];
    
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
    
    self.searchBar.placeholder = @"";
    self.searchBar.inputAccessoryView = keyboardToolbar;
    
    [self startProgressBar];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"words"
                                                     ofType:@"json"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSString *jsonString =  content;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    if(dictionary!=nil){
        NSArray* words = [dictionary objectForKey:@"ITEMS"];
        for(int i=0; i<[words count]; i++){
            NSDictionary *wordDict = [words objectAtIndex:i];
            Word *word = [[Word alloc] init];
            
            word.word = [wordDict objectForKey:@"WORD"];
            word.tag = [wordDict objectForKey:@"TAG"];
            word.meanings = [wordDict objectForKey:@"MEANING"];
            word.karaokes = [wordDict objectForKey:@"KARAOKE"];
            
            [wordList addObject:word];
        }
    }

    path = [[NSBundle mainBundle] pathForResource:@"categories"
                                                     ofType:@"json"];
    content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    jsonString =  content;
    jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    if(dictionary!=nil){
        NSArray* words = [dictionary objectForKey:@"CATEGORIES"];
        for(int i=0; i<[words count]; i++){
            NSDictionary *word = [words objectAtIndex:i];
            NSArray *values = [[NSArray alloc] initWithObjects:[word objectForKey:@"NAME"], [word objectForKey:@"DESCRIPTION"], nil];
            
            NSArray *keys = [[NSArray alloc] initWithObjects:@"NAME", @"DESCRIPTION", nil];
            NSDictionary *category = [[NSDictionary alloc] initWithObjects:values forKeys:keys];
            [categoryList addObject:category];
        }
    }
    
    dictionary = nil;
    
    [self endProgressBar];
    
    self.searchBar.placeholder = @"Type your keyword to search...";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.2];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[Util sharedUtil] setCurrentView:SEARCH_VIEW];
}

#pragma mark - UITableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchViewCell *searchCell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchViewCellID"];
    CategoryViewCell *categoryCell = [self.tableView dequeueReusableCellWithIdentifier:@"CategoryViewCellID"];
    
    if(indexPath.section == 0){
        NSDictionary *category = [categoryList objectAtIndex:indexPath.row];
        
        NSString *categoryName = [category objectForKey:@"NAME"];
        categoryName = [categoryName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
        categoryName = [categoryName lowercaseString];
        categoryCell.name.text = categoryName;
        categoryCell.name.font = ThemeFontNormal;
        categoryCell.description.text = [category objectForKey:@"DESCRIPTION"];
        categoryCell.description.font = ThemeFontItalic;
        categoryCell.iconView.image = [UIImage imageNamed:@"inapp-category80x80.png"];
        
        if(IS_IPAD_UI()){
            categoryCell.name.font = ThemeFontNormal_iPad;
            categoryCell.description.font = ThemeFontItalic_iPad;
        }
        categoryCell.backgroundColor = [UIColor clearColor];
        return categoryCell;
        
    }else if(indexPath.section == 1){
        Word *word = [filterList objectAtIndex:indexPath.row];
        NSMutableDictionary *meanings = word.meanings;
        NSMutableDictionary *karaokes = word.karaokes;
        
        searchCell.wordLabel.text = word.word;
        searchCell.wordLabel.font = ThemeFontNormal;
        searchCell.meaningLabel.text = [meanings objectForKey:@"th_TH"];
        searchCell.meaningLabel.font = ThemeFontItalic;
        searchCell.meaningLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.karaokeLabel.text = [karaokes objectForKey:@"th_TH"];
        searchCell.karaokeLabel.font = ThemeFontItalic;
        searchCell.karaokeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.iconView.image = [UIImage imageNamed:@"inapp-icon80x80.png"];
        searchCell.iconBGView.image = [UIImage imageNamed:@"inapp-icon-orange-bg.png"];
        
        searchCell.orderLabel.text = [NSString stringWithFormat:@"%d", (int)(indexPath.row+1)];
        searchCell.orderLabel.font = [UIFont fontWithName:FontNormal size:12];
        searchCell.orderLabel.textColor = [UIColor whiteColor];
        searchCell.orderBG.image = [UIImage imageNamed:@"inapp-icon-orange-order-bg.png"];
        
        searchCell.backgroundColor = [UIColor clearColor];
        
        if(IS_IPAD_UI()){
            searchCell.wordLabel.font = ThemeFontNormal_iPad;
            searchCell.meaningLabel.font = ThemeFontItalic_iPad;
        }
        
        [searchCell.speakBtn setImage:[UIImage imageNamed:@"app-speak-icon.png"] forState:UIControlStateNormal];
        [searchCell.speakBtn setImage:[UIImage imageNamed:@"app-speak-icon-hover.png"] forState:UIControlStateHighlighted];
        
        [searchCell.infoBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
        [searchCell.infoBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateHighlighted];
        
        searchCell.speakBtn.exclusiveTouch = YES;
        searchCell.infoBtn.exclusiveTouch = YES;
        
        searchCell.speakBtn.tag = indexPath.row;
        searchCell.infoBtn.tag = indexPath.row;
        searchCell.info2Btn.tag = indexPath.row;
        
        [searchCell.speakBtn addTarget:self action:@selector(speakBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [searchCell.infoBtn addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [searchCell.info2Btn addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return searchCell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        NSDictionary *dict = [categoryList objectAtIndex:indexPath.row];
        [self goToCategoryViewWithName:[dict objectForKey:@"NAME" ]];
        
    }else if(indexPath.section == 1){
        
        Word *word = [filterList objectAtIndex:indexPath.row];
        NSMutableDictionary *meanings = word.meanings;
        NSString *meaning = [meanings objectForKey:@"th_TH"];
        [self speak:meaning];
//        NSString *locale = @"th-TH";
//        
//        AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString: meaning];
//        [utterance setRate:0.2f];
//        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage: locale ];
//        [synthesizer speakUtterance:utterance];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [categoryList count];
    }else if(section == 1){
        return [filterList count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    int cellHeight = 50;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, cellHeight)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.tableView.frame.size.width-80, 25)];
    label.font = ThemeFontNormal;
    
    UILabel *suggestionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 140, 25, self.tableView.frame.size.width-30, 25)];
    suggestionLabel.font = ThemeFontItalic;
    suggestionLabel.text = @"Tap on each item to listen";
    suggestionLabel.textColor = [UIColor lightGrayColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 25)];
    topView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.8];
    
    int h = 207;
    if(!IS_IPAD_UI()){
        h = 180;
    }
    
    NSString *sectionBG = @"";
    if(section == 0){
        sectionBG = @"table_section_header_blue.png";
    }else if(section == 1){
        sectionBG = @"table_section_header_orange.png";
    }
    UIImage *image = [UIImage imageNamed:sectionBG];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, h, cellHeight)];
    imageView.image = image;
    
    [headerView addSubview:topView];
    [headerView addSubview:imageView];
    [headerView addSubview:label];
    
    if(section == 0){
        label.text = @"Category";
    }else if(section ==1){
        label.text = @"Search results (All Categories)";
        [headerView addSubview:suggestionLabel];
    }
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        return 70;
    }else{
        
        if(indexPath.section == 0){
            return 57;
        }else{
            return 70;
        }
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)_searchBar
{
    if (self.searchBar == _searchBar) {
        //[self.searchBar removeFromSuperview];
//        [self.view addSubview:self.search_bar];
//        [self.list_view reloadData];
    }
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)_searchBar
{
    if (self.searchBar == _searchBar) {
        [self.tableView reloadData];
    }
}

// Need to implement this method as Search button cannot be press if text is empty
- (void)searchBar:(UISearchBar *)_searchBar
    textDidChange:(NSString *)searchText
{

    if (self.searchBar == _searchBar) {
        if([_searchBar.text isEqualToString:@""]){
            [self clearFilterList];
        }
        [self.tableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)_searchBar
{
    if (self.searchBar == _searchBar) {
        [self.searchBar resignFirstResponder];
        [self filterWordsWithKey:searchBar.text];
        [self.tableView reloadData];
    }
}

- (void)searchBar:(UISearchBar *)_searchBar
selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    if (self.searchBar == _searchBar) {
//        [self changeSongType];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)_searchBar{
    if (self.searchBar == _searchBar) {
        
        [self clearFilterList];
        [self.tableView reloadData];
    }
}

#pragma mark - Instance method

- (void) clearFilterList
{
    [filterList removeAllObjects];
}

- (void) filterWordsWithKey:(NSString*) searchKey
{
    
    [self startProgressBar];
    
    [self clearFilterList];
    
    for(int i=0; i<[wordList count]; i++){
        
        Word *word = [wordList objectAtIndex:i];
        NSString *key = word.word;
        NSMutableDictionary *karaokes = word.karaokes;
        NSMutableDictionary *meanings = word.meanings;
        
        // search from keyword
        if( [self stringA:searchKey containsInStringB:key] ) {

            [filterList addObject:word];
        }
        
        // search from karaoke
        for(NSString *karaokeKey in karaokes.allKeys){
            if( karaokeKey != nil ){
                NSString *karaoke = [karaokes valueForKey:karaokeKey];
                if( [self stringA:searchKey containsInStringB:karaoke] ) {
                    [filterList addObject:word];
                }
            }
  
        }
        
        // search from Thai
        for(NSString *meaningKey in meanings.allKeys){
            if( meaningKey != nil ){
                NSString *meaning = [meanings valueForKey:meaningKey];
                if( [self stringA:searchKey containsInStringB:meaning] ) {
                    [filterList addObject:word];
                }
            }
            
        }
        
    }
    
    [self endProgressBar];
}

-(BOOL) stringA:(NSString*) a containsInStringB:(NSString*) b
{
    NSString *stringA = [a lowercaseString];
    NSString *stringB = [b lowercaseString];
    
    if ( [stringB rangeOfString:stringA].location == NSNotFound ) {
        return NO;
    } else {
        return YES;
    }
}

-(void) goToCategoryViewWithName:(NSString*) categoryName
{
    NSMutableArray *wordsInCategoryList = [[NSMutableArray alloc] init];

    [self startProgressBar];
    
    for(int i=0; i<[wordList count]; i++){
        
        Word *w = [wordList objectAtIndex:i];
        NSArray *tags = w.tag;
        if(tags){
            for(int j=0;j<[tags count]; j++){
                NSString *tag = [tags objectAtIndex:j];
                if( [self stringA:categoryName containsInStringB:tag]){
                    [wordsInCategoryList addObject:w];
                    j = (int)[tags count];
                }
            }
        }
    }
    
    [self endProgressBar];
    
    
    UIStoryboard *storyBoard = [self storyboard];
    CategorySearchViewController *categorySearchView = [storyBoard instantiateViewControllerWithIdentifier:@"CategorySearchViewControllerID"];
    [categorySearchView setupWordList:wordsInCategoryList withCategoryName:categoryName];
    [self.navigationController pushViewController:categorySearchView animated:YES];
}

- (void)hideKeyboard
{
    [searchBar resignFirstResponder];
}

- (void) speakBtnAction:(id) sender
{
    UIButton *btn = (UIButton*)sender;
    int objIdx = (int)btn.tag;
    Word *w=[filterList objectAtIndex:objIdx];
    [self speak:[w.meanings objectForKey:@"th_TH"]];
}

- (void) infoBtnAction:(id) sender
{
    UIButton *btn = (UIButton*)sender;
    int objIdx = (int)btn.tag;
    Word *w=[filterList objectAtIndex:objIdx]; 
    [self gotoRelatedContentView:w];
    
}



@end
