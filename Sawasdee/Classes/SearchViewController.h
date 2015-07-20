//
//  SearchViewController.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface SearchViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>
{
    UITableView *tableView;
    //AVSpeechSynthesizer *synthesizer;
    
    NSMutableArray *wordList;
    NSMutableArray *filterList;
    NSMutableArray *categoryList;
    
    UISearchBar *searchBar;
    
}

@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readwrite) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain, readwrite) NSMutableArray *wordList;

@end
