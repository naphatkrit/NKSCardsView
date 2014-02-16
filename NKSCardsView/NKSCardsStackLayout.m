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

-(NKSCardsStackLayout *)initWithMainIndex:(NSIndexPath *)mainIndex
{
    self = [super init];
    if (self) {
        self.mainIndexPath = mainIndex;
    }
    return self;
}

-(void)prepareLayout
{
    self.frameDict = [NSMutableDictionary new];
    int count = 0;
    for (int section = 0; section < self.collectionView.numberOfSections; section++)
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGRect frame = [self frameForIndexPath:indexPath];
            UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            layoutAttributes.frame = frame;
            layoutAttributes.zIndex = count * -1;
            self.frameDict[indexPath] = layoutAttributes;
            count--;
        }
}

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 200.0;
    CGFloat width = 300.0;
    CGFloat verticalDist = 40.0;
    CGFloat topMargin = 300.0;
    NSInteger offset = 0;
    
    NSComparisonResult comparisonResult = [indexPath compare:self.mainIndexPath];
    
    switch (comparisonResult) {
        case NSOrderedAscending:
            break;
        case NSOrderedSame:
            return CGRectMake((self.collectionView.bounds.size.width - width)/2.0, 0, width, height);
            break;
        case NSOrderedDescending:
            offset = -1;
            break;
    }
    
    
    return CGRectMake((self.collectionView.bounds.size.width - width)/2.0, topMargin + (indexPath.item + offset) * verticalDist, width, height);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.frameDict[indexPath];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *visibleIndexPaths = [NSMutableArray new];
    for (NSIndexPath *key in self.frameDict) {
        UICollectionViewLayoutAttributes *layoutAttributes = self.frameDict[key];
        if (CGRectIntersectsRect(rect, layoutAttributes.frame)) {
            [visibleIndexPaths addObject:layoutAttributes];
        }
    }
    return visibleIndexPaths;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(320, 1000);
}

@end
