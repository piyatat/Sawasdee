//
//  DigitViewController.h
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DigitViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
}

@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;

@end
