//
//  DigitViewController.m
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "DigitViewController.h"
#import "DigitCell.h"

@implementation DigitViewController

@synthesize tableView;

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    
    [[Util sharedUtil] setCurrentView:DIGIT_VIEW];
    
    self.navigationItem.title = @"DIGIT";
    self.categoryLabel.text = @"DIGIT";
    self.tableView.backgroundColor = [UIColor clearColor];
}


- (DigitCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DigitCell *digitCell = [self.tableView dequeueReusableCellWithIdentifier:@"DigitCellID"];
    NSString *arabic = @"";
    NSString *thai = @"";
    //NSString *read = @"";
    NSString *karaoke = @"";
    
    switch (indexPath.row) {
        case 0:
            arabic = @"0";
            thai = @"0";
            //read = @"ศูนย์";
            karaoke = @"soon";
            break;
        case 1:
            arabic = @"1";
            thai = @"๑";
            //read = @"หนึ่ง";
            karaoke = @"nueng";
            break;
        case 2:
            arabic = @"2";
            thai = @"๒";
            //read = @"สอง";
            karaoke = @"song";
            break;
        case 3:
            arabic = @"3";
            thai = @"๓";
            //read = @"สาม";
            karaoke = @"sam";
            break;
        case 4:
            arabic = @"4";
            thai = @"๔";
            //read = @"สี่";
            karaoke = @"si";
            break;
        case 5:
            arabic = @"5";
            thai = @"๕";
            //read = @"ห้า";
            karaoke = @"ha";
            break;
        case 6:
            arabic = @"6";
            thai = @"๖";
            //read = @"หก";
            karaoke = @"hok";
            break;
        case 7:
            arabic = @"7";
            thai = @"๗";
            //read = @"เจ็ด";
            karaoke = @"jed";
            break;
        case 8:
            arabic = @"8";
            thai = @"๘";
            //read = @"แปด";
            karaoke = @"pad";
            break;
        case 9:
            arabic = @"9";
            thai = @"๙";
            //read = @"เก้า";
            karaoke = @"kao";
            break;
        default:
            break;
    }
    
    digitCell.digitLabel.text = [NSString stringWithFormat:@"%@", arabic];
    digitCell.digitLabel.font = ThemeFontNormalDiff(8);
    
    digitCell.thaiDigitLabel.text = [NSString stringWithFormat:@"%@", thai];
    digitCell.thaiDigitLabel.font = ThemeFontNormalDiff(15);
    
    digitCell.karaokeLabel.text = [NSString stringWithFormat:@"%@", karaoke];
    digitCell.karaokeLabel.font = ThemeFontItalic;
    digitCell.backgroundColor = [UIColor clearColor];
    return digitCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *arabic = @"";
//    NSString *thai = @"";
    NSString *read = @"";
//    NSString *karaoke = @"";
    
    switch (indexPath.row) {
        case 0:
//            arabic = @"0";
//            thai = @"0";
            read = @"ศูนย์";
//            karaoke = @"soon";
            break;
        case 1:
//            arabic = @"1";
//            thai = @"๑";
            read = @"หนึ่ง";
//            karaoke = @"nueng";
            break;
        case 2:
//            arabic = @"2";
//            thai = @"๒";
            read = @"สอง";
//            karaoke = @"song";
            break;
        case 3:
//            arabic = @"3";
//            thai = @"๓";
            read = @"สาม";
//            karaoke = @"sam";
            break;
        case 4:
//            arabic = @"4";
//            thai = @"๔";
            read = @"สี่";
//            karaoke = @"si";
            break;
        case 5:
//            arabic = @"5";
//            thai = @"๕";
            read = @"ห้า";
//            karaoke = @"ha";
            break;
        case 6:
//            arabic = @"6";
//            thai = @"๖";
            read = @"หก";
//            karaoke = @"hok";
            break;
        case 7:
//            arabic = @"7";
//            thai = @"๗";
            read = @"เจ็ด";
//            karaoke = @"jed";
            break;
        case 8:
//            arabic = @"8";
//            thai = @"๘";
            read = @"แปด";
//            karaoke = @"pad";
            break;
        case 9:
//            arabic = @"9";
//            thai = @"๙";
            read = @"เก้า";
//            karaoke = @"kao";
            break;
        default:
            break;
    }
    
    [self speak:read];

}

@end
