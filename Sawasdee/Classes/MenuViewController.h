//
//  MenuViewController.h
//  Sawasdee
//
//  Created by BooBoo on 8/22/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "BaseViewController.h"

@interface MenuViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *tableView;
}

@property (nonatomic, retain, readwrite) IBOutlet UITableView *tableView;

@end
