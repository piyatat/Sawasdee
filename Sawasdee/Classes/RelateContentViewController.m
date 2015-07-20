//
//  ViewController.m
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import "RelateContentViewController.h"
#import "RelateContentImageCell.h"

#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

#define IMAGE_WIDTH         100
#define IMAGE_HEIGHT        100
#define IMAGE_COLUMN        3
@interface RelateContentViewController ()

@end

@implementation RelateContentViewController

@synthesize scrollView;
@synthesize collectionView;
//@synthesize backIconView;
@synthesize headerLabel;
@synthesize wordLabel;
@synthesize meaningLabel;
//@synthesize categoryLabel;
@synthesize karaokeLabel;
@synthesize speakBtn;
@synthesize fullImageView;
@synthesize fullImageBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageList = [[NSMutableArray alloc] init];
    
    //[self.backIconView addTarget:self action:@selector(backToPreviousPage) forControlEvents:UIControlEventTouchUpInside];
    
    self.wordLabel.font = ThemeFontNormal;
    self.wordLabel.textColor = [UIColor lightGrayColor];
    self.wordLabel.textColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];

    self.meaningLabel.font = ThemeFontItalic;
    self.meaningLabel.textColor = [UIColor lightGrayColor];
    self.meaningLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    
    self.karaokeLabel.font = ThemeFontItalic;
    self.karaokeLabel.textColor = [UIColor lightGrayColor];
    self.karaokeLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];
    

    self.categoryLabel.font = ThemeFontItalic;
    self.categoryLabel.textColor = [UIColor lightGrayColor];
    self.categoryLabel.textColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0];

    self.fullImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.fullImageView.hidden = YES;
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.fullImageView.backgroundColor = [UIColor blackColor];
    self.fullImageView.autoresizesSubviews = YES;
//    self.fullImageView.exclusiveTouch = YES;
    
    self.fullImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fullImageBtn.frame = self.view.frame;
    [self.fullImageBtn addTarget:self action:@selector(hideImageView) forControlEvents:UIControlEventTouchUpInside];
    self.fullImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.fullImageBtn.exclusiveTouch = YES;
    self.fullImageBtn.hidden = YES;
    
    [self.view addSubview: self.fullImageView];
    [self.view addSubview: self.fullImageBtn];
    
    [self.speakBtn addTarget:self action:@selector(speakBtnAction) forControlEvents:UIControlEventTouchUpInside];

    [self getRequestWordList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageCachedUpdatedWithNotification:) name:ImageCachedNotificationKey object:nil];
    
    self.backIconView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ImageCachedNotificationKey object:nil];
    
}
//-(void) updateScrollViewUI
//{
//    //[imageList count]
//    int amount = (int)[imageList count];
//    for(int i=0; i<amount; i++){
//        
//        NSDictionary *dict = [imageList objectAtIndex:i];
//        int xPos = (i%IMAGE_COLUMN) * IMAGE_WIDTH;
//        int yPos = (int)((float)i/IMAGE_COLUMN) * IMAGE_HEIGHT;
//        
//        NSLog(@"x:%d, y:%d", xPos, yPos);
//        UIImage *bgImg = [UIImage imageNamed:@"setting.png"];
//        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, IMAGE_WIDTH, IMAGE_HEIGHT) ];
//        bgImgView.image = bgImg;
//
//        NSURL *imageURL = [NSURL URLWithString:[dict objectForKey:@"imageURL"]];
//        BOOL isLoading = NO;
//        UIImage *contentImg = [[Util sharedUtil] cachedImageAtURL:imageURL withPlacementImageName:@"" isLoading:&isLoading];
//        UIImageView *contentImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, IMAGE_WIDTH, IMAGE_HEIGHT)];
//        contentImgView.image = contentImg;
//        
//        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(xPos, yPos, IMAGE_WIDTH, IMAGE_HEIGHT)];
//        [contentView addSubview:bgImgView];
//        [contentView addSubview:contentImgView];
//        [self.scrollView addSubview:contentImgView];
//        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, IMAGE_HEIGHT*((float)amount/(float)IMAGE_COLUMN));
//    }
//}

#pragma mark - Instance method
-(void) getRequestWordList
{
    
    if( [[Util sharedUtil] getImageSearchSetting] ){
        
        [activityIndicatorView  startAnimating];
        
        if(word!=nil){
            NSString *serviceURL = [NSString stringWithFormat:@"%@imagesearch.php",IMAGE_SERVICE];
            self.wordLabel.text = word.word;
            self.meaningLabel.text = [word.meanings objectForKey:@"th_TH"];
            self.karaokeLabel.text = [word.karaokes objectForKey:@"th_TH"];
            if([word.tag count] > 0){
                self.categoryLabel.text = (NSString*)[word.tag objectAtIndex:0];
                self.headerLabel.text = [(NSString*)[word.tag objectAtIndex:0] uppercaseString];
            }
            
            NSString *keyword = [word.meanings objectForKey:@"th_TH"];

            NSDictionary *parameters = @{@"query": keyword, @"word": word.word,@"appKey": SAWASDEE_KEY } ;
            
            NSError *error;
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                                         URLString:serviceURL
                                                                                        parameters:parameters
                                                                                             error:&error];
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.responseSerializer = [AFHTTPResponseSerializer serializer];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
                [imageList removeAllObjects];
                
                if(operation!=nil){
                    NSString *JSON = operation.responseString;
                    if(JSON != nil){
                        NSData *jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
                        NSError *error = nil;
            
                        NSMutableArray *wList = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                options:NSJSONReadingMutableContainers
                                                                                  error:&error];
                        if(wList != nil){
                            for(NSDictionary *dict in wList ){
                                [imageList addObject:dict];
                            }
                        }
                    }
                }
                [self.collectionView reloadData];
                
                [activityIndicatorView  stopAnimating];
                    
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                [activityIndicatorView  stopAnimating];
            }];
            [[NSOperationQueue mainQueue] addOperation:operation];
        }
    }

}

#pragma mark - Image Cached Method

- (void)imageCachedUpdatedWithNotification:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.collectionView reloadData];
    });
   
}

#pragma mark - UICollecitonView Datasource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RelateContentImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"RelateContentImageCellID" forIndexPath:indexPath ];

    NSDictionary *dict = [imageList objectAtIndex:indexPath.row];
//    UIImage *bgImg = [UIImage imageNamed:@"setting.png"];
//    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, IMAGE_WIDTH, IMAGE_HEIGHT) ];
//    bgImgView.image = bgImg;
    
//    NSLog(@"imageURL: %@", [dict objectForKey:@"imageURL"]);
    if( [[dict objectForKey:@"imageURL"] isKindOfClass:[NSString class]]) {
        NSURL *imageURL = [NSURL URLWithString:[dict objectForKey:@"imageURL"]];
        if(imageURL !=nil ){
            
            //NSLog(@"Image url: %@", [dict objectForKey:@"imageURL"]);
            BOOL isLoading = NO;
            UIImage *image = [[Util sharedUtil] cachedImageAtURL:imageURL withPlacementImageName:nil isLoading:&isLoading];
            if (image !=nil) {
                cell.contentView.image = image;
            } else {
                cell.contentView.image = nil;
            }
            cell.contentView.contentMode = UIViewContentModeScaleAspectFit;
            cell.contentView.clipsToBounds = YES;
            cell.contentView.exclusiveTouch = YES;
            
        }
    }
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [imageList count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = [imageList objectAtIndex:indexPath.row];
    //    UIImage *bgImg = [UIImage imageNamed:@"setting.png"];
    //    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, IMAGE_WIDTH, IMAGE_HEIGHT) ];
    //    bgImgView.image = bgImg;
    
    //    NSLog(@"imageURL: %@", [dict objectForKey:@"imageURL"]);
    if( [[dict objectForKey:@"imageURL"] isKindOfClass:[NSString class]]) {
        NSURL *imageURL = [NSURL URLWithString:[dict objectForKey:@"imageURL"]];
        if(imageURL !=nil ){
            
            //NSLog(@"Image url: %@", [dict objectForKey:@"imageURL"]);
            BOOL isLoading = NO;
            UIImage *image = [[Util sharedUtil] cachedImageAtURL:imageURL withPlacementImageName:nil isLoading:&isLoading];
            if (image !=nil) {
                self.fullImageView.image = image;
                self.fullImageView.frame = self.view.frame;
                self.fullImageView.hidden = NO;
                self.fullImageBtn.hidden = NO;
                self.fullImageBtn.frame= self.view.frame;
            } else {
                
            }
            
            
        }
    }

}

-(void)hideImageView
{
    self.fullImageView.hidden = YES;
    self.fullImageBtn.hidden = YES;
}

-(void) setWord:(Word*) _word{
    word = _word;
    [self getRequestWordList];
}

-(void) speakBtnAction
{
    [self speak:[word.meanings objectForKey:@"th_TH"]];
}

#pragma mark - UICollectionView Delegate

@end
