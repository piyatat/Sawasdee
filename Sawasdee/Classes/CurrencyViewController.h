//
//  CurrencyViewController.h
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *tableView;
    NSMutableArray *currencyList;
    UITextView *detailBathView;
    //UILabel *categoryLabel;
}
//@property (nonatomic, retain, readwrite) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;
@property (nonatomic, retain, readwrite) IBOutlet UITextView *detailBathView;

@end
