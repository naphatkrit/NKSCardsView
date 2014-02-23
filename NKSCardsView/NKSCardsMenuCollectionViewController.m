//
//  NKSCardsMenuCollectionViewController.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsMenuCollectionViewController.h"
#import "NKSCardsStackLayout.h"
#import "NKSCardViewCell.h"
#define REUSE_IDENTIFIER @"id"

@interface NKSCardsMenuCollectionViewController ()

@property (nonatomic) BOOL collapsed;

@end

@implementation NKSCardsMenuCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
    stackLayout.cardSize = CGSizeMake(300.0, 400.0);
    stackLayout.mainStackSpacing = 100.0;
    stackLayout.stackCardsInterSpacing = 60.0;
//    stackLayout.mainIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView setCollectionViewLayout:stackLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NKSCardViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:REUSE_IDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
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
    if (!self.collapsed) {
        NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
        NKSCardsStackLayout *oldLayout = (NKSCardsStackLayout *) collectionView.collectionViewLayout;
        stackLayout.mainIndexPath = indexPath;
        stackLayout.mainStackSpacing = oldLayout.mainStackSpacing;
        stackLayout.cardSize = oldLayout.cardSize;
        stackLayout.stackCardsInterSpacing = 5;
        
        __weak UICollectionView *weakCollectionView = collectionView;
        [self.menuDelegate willCollapseMenu];
        [collectionView setCollectionViewLayout:stackLayout animated:YES completion:^(BOOL finished) {
            [[weakCollectionView cellForItemAtIndexPath:indexPath] setHidden:YES];
            [self.menuDelegate didCollapseMenu];
        }];
        [self.view setUserInteractionEnabled:NO];
    }
}

@end
