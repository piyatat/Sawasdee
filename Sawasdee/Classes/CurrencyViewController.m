//
//  CurrencyViewController.m
//  Sawasdee
//
//  Created by BooBoo on 8/21/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "CurrencyViewController.h"
#import "CurrencyViewCell.h"
#import "CJSONDeserializer.h"
#import "Currency.h"

@implementation CurrencyViewController

@synthesize tableView;
@synthesize detailBathView;
//@synthesize categoryLabel;

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    currencyList = [[NSMutableArray alloc] init];
    
    self.detailBathView.text = @"  Currency of Thailand is Baht(฿, THB, บาท). One baht can be divided into 100 satang. These are value of all available notes/coins which are used in currently.";
    self.detailBathView.font = ThemeFontNormal;
    self.detailBathView.selectable = false;
    self.detailBathView.editable = false;
    self.detailBathView.backgroundColor = [UIColor clearColor];
    [self readCurrenciesData];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //self.navigationController.navigationBar.hidden = YES;
    
    [[Util sharedUtil] setCurrentView:CURRENCY_VIEW];
    
    self.navigationItem.title = @"CURRENCY";
    self.categoryLabel.text = @"CURRENCY";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CurrencyViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CurrencyViewCellID"];
    
    Currency *currency = [currencyList objectAtIndex:indexPath.row];
    NSString *label = [NSString stringWithFormat:@"%@ (%@)", currency.description, currency.name];
    cell.currencyLabel.text = label;
    cell.currencyLabel.font = ThemeFontNormalDiff(-1);
    cell.currencyImage.image = [UIImage imageNamed:currency.image];
    cell.karaokeLabel.text = currency.karaoke;
    cell.karaokeLabel.font = ThemeFontItalicDiff(-1);
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [currencyList count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Currency Unit";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Currency *currency = [currencyList objectAtIndex:indexPath.row];
    [self speakBtnAction:currency.read];
}


- (void) readCurrenciesData
{
    [currencyList removeAllObjects];
    
    [self startProgressBar];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"currencies"
                                                     ofType:@"json"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSString *jsonString    = content;
    NSData *jsonData        = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error          = nil;
    
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:jsonData error:&error];
    
    if(dictionary!=nil){
        NSArray* currencies = [dictionary objectForKey:@"CURRENCIES"];
        
        for(int i=0; i<[currencies count]; i++){
            
            NSDictionary *hDict = [currencies objectAtIndex:i];
            
            Currency *currency      = [[Currency alloc] init];
            currency.name           = [hDict objectForKey:@"NAME"];
            currency.value          = [hDict objectForKey:@"VALUE"];
            currency.description    = [hDict objectForKey:@"DESCRIPTION"];
            currency.image          = [hDict objectForKey:@"IMAGE"];
            currency.read           = [hDict objectForKey:@"READ"];
            currency.karaoke        = [hDict objectForKey:@"KARAOKE"];

            [currencyList addObject:currency];
        }
    }
    
    [self endProgressBar];
    
}

- (void) speakBtnAction:(NSString*) word
{
    [self speak:word];
}

@end
