//
//  NKSCardsContentViewController.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsContentViewController.h"
#import "NKSCardsStackLayout.h"
#import "NKSCardViewCell.h"
#define REUSE_IDENTIFIER @"id"

@interface NKSCardsContentViewController () 

@end

@implementation NKSCardsContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
    stackLayout.cardSize = CGSizeMake(NKS_CARDS_WIDTH, NKS_CARDS_HEIGHT);
    stackLayout.mainIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView setCollectionViewLayout:stackLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NKSCardViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:REUSE_IDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)expandContent
{
    NKSCardsStackLayout *stackLayout = (NKSCardsStackLayout *) self.collectionView.collectionViewLayout;
    [self.collectionView performBatchUpdates:^{
        stackLayout.cardSize = CGSizeMake(NKS_CARDS_WIDTH, NKS_CARDS_HEIGHT_FULL);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NKSCardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];
    cell.headingLabel.text = [NSString stringWithFormat:@"Heading %ld", (long)indexPath.item];
    
    return cell;
}

#pragma mark - Collection View Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
