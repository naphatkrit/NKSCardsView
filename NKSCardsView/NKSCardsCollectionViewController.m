//
//  NKSViewController.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsCollectionViewController.h"
#import "NKSCardsStackLayout.h"
#define REUSE_IDENTIFIER @"id"

@interface NKSCardsCollectionViewController ()

@end

@implementation NKSCardsCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
    [self.collectionView setCollectionViewLayout:stackLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:REUSE_IDENTIFIER];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSE_IDENTIFIER forIndexPath:indexPath];

    cell.backgroundColor = [UIColor greenColor];
    return cell;
}


@end
