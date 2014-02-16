//
//  NKSCardsStackLayout.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsStackLayout.h"

@interface NKSCardsStackLayout ()

@property (nonatomic, strong) NSIndexPath *mainIndexPath;
@property (nonatomic, strong) NSMutableDictionary *frameDict;

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation NKSCardsStackLayout

-(void)prepareLayout
{
    self.frameDict = [NSMutableDictionary new];
    for (int section = 0; section < self.collectionView.numberOfSections; section++)
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGRect frame = [self frameForIndexPath:indexPath];
            UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            layoutAttributes.frame = frame;
            self.frameDict[indexPath] = layoutAttributes;
        }
}

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 200.0;
    CGFloat width = 300.0;
    return CGRectMake((self.collectionView.bounds.size.width - width)/2.0, indexPath.item * height * 2.0, width, height);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frameDict[indexPath];
}

@end
