//
//  RequestWordViewController.h
//  Sawasdee
//
//  Created by BooBoo on 7/31/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestWordViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UITextFieldDelegate>
{
    UITableView *tableView;
    
    NSMutableArray *wordList;
    NSMutableArray *btnList;
    
//    UIImageView *topBarView;
//    UIButton *settingIconView;
//    UIImageView *appIconView;
//    UIImageView *bgView;
    
    UIScrollView *scrollView;
    UIView *requestView;
    UIButton *submitBtn;
    UITextField *wordField;
    UILabel *wordLabel;
    //UIButton *backIconView;
}

@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readwrite) NSMutableArray *wordList;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *topBarView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *settingIconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *appIconView;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *bgView;
@property (nonatomic, retain, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain, readwrite) IBOutlet UIView *requestView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *submitBtn;
@property (nonatomic, retain, readwrite) IBOutlet UITextField *wordField;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *wordLabel;
//@property (nonatomic, retain, readwrite) IBOutlet UIButton *backIconView;


@end
