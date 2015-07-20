//
//  RequestWordViewCell.h
//  Sawasdee
//
//  Created by BooBoo on 7/31/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestWordViewCell : UITableViewCell
{
    UILabel *wordLabel;
}

@property (nonatomic, retain, readwrite) IBOutlet UILabel *wordLabel;

@end
