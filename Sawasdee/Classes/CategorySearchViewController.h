//
//  CategorySearchViewController.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Word.h"

@interface CategorySearchViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>
{
    UITableView *tableView;
    
    NSString *categoryName;
    //AVSpeechSynthesizer *synthesizer;
    NSMutableArray *wordList;
    NSMutableArray *recommendList;
    NSMutableArray *filterList;
    
    //UILabel *categoryLabel;
    UISearchBar *searchBar;
    //UIButton *backIconView;
}

//@property (nonatomic, retain, readwrite) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readwrite) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain, readwrite) NSMutableArray *wordList;
@property (nonatomic, retain, readwrite) NSMutableArray *filterList;
@property (nonatomic, retain, readwrite) NSMutableArray *recommendList;

//@property (nonatomic, retain, readwrite) IBOutlet UIButton *backIconView;


-(void) setupWordList:(NSMutableArray*) dicts withCategoryName:(NSString*) categoryName;

@end
