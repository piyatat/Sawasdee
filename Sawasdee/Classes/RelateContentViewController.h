//
//  ViewController.h
//  Sawasdee
//
//  Created by BooBoo on 7/25/2557 BE.
//  Copyright (c) 2557 B2HOME. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface RelateContentViewController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIScrollView *scrollView;
    UICollectionView *collectionView;
    NSMutableArray *imageList;
    
    //UIButton *backIconView;
    
    UILabel *headerLabel;
    
    UILabel *wordLabel;
    UILabel *meaningLabel;
//    UILabel *categoryLabel;
    UILabel *karaokeLabel;
    UIButton *speakBtn;
    
    UIImageView *fullImageView;
    UIButton *fullImageBtn;
    
    Word *word;

}

@property (nonatomic, retain, readwrite) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain, readwrite) IBOutlet UICollectionView *collectionView;
//@property (nonatomic, retain, readwrite) IBOutlet UIButton *backIconView;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *headerLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *wordLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *meaningLabel;
//@property (nonatomic, retain, readwrite) IBOutlet UILabel *categoryLabel;
@property (nonatomic, retain, readwrite) IBOutlet UILabel *karaokeLabel;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *speakBtn;
@property (nonatomic, retain, readwrite) IBOutlet UIImageView *fullImageView;
@property (nonatomic, retain, readwrite) IBOutlet UIButton *fullImageBtn;

-(void) setWord:(Word*) _word;
@end
