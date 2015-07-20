//
//  CategorySearchViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "CategorySearchViewController.h"
#import "SearchViewCell.h"
#import "RelateContentViewController.h"

@implementation CategorySearchViewController

//@synthesize categoryLabel;
@synthesize tableView;
@synthesize wordList;
@synthesize searchBar;
@synthesize filterList;
@synthesize recommendList;
//@synthesize backIconView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //synthesizer = [[AVSpeechSynthesizer alloc]init];
    filterList = [[NSMutableArray alloc] init];
    //recommendList = [[NSMutableArray alloc] init];
    
    self.searchBar.placeholder = @"Type your keyword here...";
    self.tableView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    
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
    
    self.categoryLabel.textColor = [UIColor blackColor];
    self.categoryLabel.font = ThemeFontHeader;
    self.categoryLabel.text = categoryName;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    [[Util sharedUtil] setCurrentView:CATEGORY_SEARCH_VIEW];
    
    self.navigationItem.title = categoryName;
    self.categoryLabel.text = categoryName;
    
    self.backIconView.hidden = NO;
}

#pragma mark - UITableView delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchViewCell *searchCell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchViewCellID"];
    
    if(indexPath.section == 0){
        Word *w = [recommendList objectAtIndex:indexPath.row];
        NSMutableDictionary *meanings = w.meanings;
        NSMutableDictionary *karaokes = w.karaokes;
        
        searchCell.wordLabel.text = w.word;
        searchCell.wordLabel.font = ThemeFontNormal;
        searchCell.meaningLabel.text = [meanings objectForKey:@"th_TH"];
        searchCell.meaningLabel.font = ThemeFontItalic;
        searchCell.meaningLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.karaokeLabel.text = [karaokes objectForKey:@"th_TH"];;
        searchCell.karaokeLabel.font = ThemeFontItalic;
        searchCell.karaokeLabel.textColor = [UIColor lightGrayColor];
        searchCell.karaokeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.iconView.image = [UIImage imageNamed:@"inapp-icon80x80.png"];
        searchCell.iconBGView.image = [UIImage imageNamed:@"inapp-icon-green-bg.png"];
        
        searchCell.orderLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
        searchCell.orderLabel.font = [UIFont fontWithName:FontNormal size:14];
        searchCell.orderLabel.textColor = [UIColor whiteColor];
        searchCell.orderBG.image = [UIImage imageNamed:@"inapp-icon-green-order-bg.png"];
        searchCell.backgroundColor = [UIColor clearColor];
        if(IS_IPAD_UI()){
            searchCell.wordLabel.font = ThemeFontNormal_iPad;
            searchCell.meaningLabel.font = ThemeFontItalic_iPad;
        }
        
        searchCell.speakBtn.tag = 1000+indexPath.row;
        searchCell.infoBtn.tag = 1000+indexPath.row;
        searchCell.info2Btn.tag = 1000+indexPath.row;
        
    }else if(indexPath.section == 1){
        
        Word *w = [filterList objectAtIndex:indexPath.row];
        NSMutableDictionary *meanings = w.meanings;
        NSMutableDictionary *karaokes = w.karaokes;
        
        searchCell.wordLabel.text = w.word;
        searchCell.wordLabel.font = ThemeFontNormal;
        
        searchCell.meaningLabel.text = [meanings objectForKey:@"th_TH"];;
        searchCell.meaningLabel.font = ThemeFontItalic;
        searchCell.meaningLabel.textColor = [UIColor lightGrayColor];
        searchCell.meaningLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.karaokeLabel.text = [karaokes objectForKey:@"th_TH"];;
        searchCell.karaokeLabel.font = ThemeFontItalic;
        searchCell.karaokeLabel.textColor = [UIColor lightGrayColor];
        searchCell.karaokeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
        
        searchCell.iconView.image = [UIImage imageNamed:@"inapp-icon80x80.png"];
        searchCell.iconBGView.image = [UIImage imageNamed:@"inapp-icon-orange-bg.png"];
        
        searchCell.orderLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row+1];
        searchCell.orderLabel.font = [UIFont fontWithName:FontNormal size:12];
        searchCell.orderLabel.textColor = [UIColor whiteColor];
        searchCell.orderBG.image = [UIImage imageNamed:@"inapp-icon-orange-order-bg.png"];
        searchCell.backgroundColor = [UIColor clearColor];
        
        if(IS_IPAD_UI()){
            searchCell.wordLabel.font = ThemeFontNormal_iPad;
            searchCell.meaningLabel.font = ThemeFontItalic_iPad;
        }
        searchCell.speakBtn.tag = 2000+indexPath.row;
        searchCell.infoBtn.tag = 2000+indexPath.row;
        searchCell.info2Btn.tag = 2000+indexPath.row;
    
    }

    [searchCell.speakBtn setImage:[UIImage imageNamed:@"app-speak-icon.png"] forState:UIControlStateNormal];
    [searchCell.speakBtn setImage:[UIImage imageNamed:@"app-speak-icon-hover.png"] forState:UIControlStateHighlighted];
    
    [searchCell.infoBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [searchCell.infoBtn setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateHighlighted];
    
    searchCell.speakBtn.exclusiveTouch = YES;
    searchCell.infoBtn.exclusiveTouch = YES;
    
    [searchCell.speakBtn addTarget:self action:@selector(speakBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchCell.infoBtn addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchCell.info2Btn addTarget:self action:@selector(infoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return searchCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = @"";
    Word *w;
    if(indexPath.section == 0){
        w = [recommendList objectAtIndex:indexPath.row];

    }else if(indexPath.section == 1){
        w = [filterList objectAtIndex:indexPath.row];
    }
    
    NSMutableDictionary *meanings = w.meanings;
    text = [meanings objectForKey:@"th_TH"];
    [self speak:text];
//    NSString *locale = @"th-TH";
//    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString: text];
//    [utterance setRate:0.2f];
//    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage: locale ];
//    [synthesizer speakUtterance:utterance];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [recommendList count];
    }else if(section == 1){
        return [filterList count];
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.8];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width-10, 25)];
    label.font = ThemeFontNormal;
    
    [headerView addSubview:label];
    
    if(section == 0){
        label.text = @"Recommend lists";
    }else if(section ==1){
        label.text = @"Search results";
    }
    return headerView;
}*/

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
        sectionBG = @"table_section_header_green.png";
    }else if(section == 1){
        sectionBG = @"table_section_header_orange.png";
    }
    UIImage *image = [UIImage imageNamed:sectionBG];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, h, cellHeight)];
    imageView.image = image;
    
    [headerView addSubview:topView];
    [headerView addSubview:imageView];
    [headerView addSubview:label];
    [headerView addSubview:suggestionLabel];
    
    if(section == 0){
        label.text = @"Recommend lists";
    }else if(section ==1){
        label.text = @"Search results";
    }
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==0){
        return 30;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( IS_IPAD_UI() )
    {
        return 70;
    }else{
        return 70;//57;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==0){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        label.text = @"   To view more words, please use search feature.";
        label.font = ThemeFontItalic;
        label.backgroundColor = [UIColor clearColor];
    
        [view addSubview:label];
        
        return view;
    }
    return nil;
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
- (void)searchBar:(UISearchBar *)_searchBar textDidChange:(NSString *)searchText
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
    [self clearFilterList];
    
    for(int i=0; i<[wordList count]; i++){
        Word *w = [wordList objectAtIndex:i];
        NSString *key = w.word;
        
        if( [self stringA:searchKey containsInStringB:key] ) {
            [filterList addObject:w];
        }
    }
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

#pragma mark - Instance method
-(void) setupWordList:(NSMutableArray*) dicts withCategoryName:(NSString*) catName
{
    wordList = dicts;
    
    int amount = TOP_RECOMMEND_AMOUNT;
    if(amount > [dicts count]){
        amount = (int)[dicts count];
    }
    
    if(recommendList == nil){
        recommendList = [[NSMutableArray alloc] init];
    }
    
    // recommend words
    for(int i=0;i<amount; i++){
        [recommendList addObject: [dicts objectAtIndex:i]];
    }
    
    [self.tableView reloadData];
    
    NSString *category = [catName stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    categoryName = [category uppercaseString];
}

- (void)hideKeyboard
{
    [searchBar resignFirstResponder];
}

- (void) speakBtnAction:(id) sender
{
    Word *w;
    UIButton *btn = (UIButton*)sender;
    int objIdx = (int)btn.tag;
    if(objIdx < 2000){
        objIdx = objIdx%1000;
        w =[recommendList objectAtIndex:objIdx];
    }else{
        objIdx = objIdx%2000;
        w = [filterList objectAtIndex:objIdx];
    }
    NSMutableDictionary *meanings = w.meanings;
    NSString *text = [meanings objectForKey:@"th_TH"];
    NSString *locale = @"th-TH";
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString: text];
    [utterance setRate:0.2f];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage: locale ];
    [synthesizer speakUtterance:utterance];
}

- (void) infoBtnAction:(id) sender
{
    Word *w;
    UIButton *btn = (UIButton*)sender;
    int objIdx = (int)btn.tag;
    if(objIdx < 2000){
        objIdx = objIdx%1000;
        w =[recommendList objectAtIndex:objIdx];
    }else{
        objIdx = objIdx%2000;
        w = [filterList objectAtIndex:objIdx];
    }
    [self gotoRelatedContentView:w];
    
}

@end
