//
//  NKSCardsStackLayout.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsStackLayout.h"

@interface NKSCardsStackLayout ()

@property (nonatomic, strong) NSMutableDictionary *attrDict;

/*!
 Initialize the attributes dictionary
 */
-(void)initializeAttrDict;

/*!
 Calculate the frame of the cell at indexPath
 @params indexPath The indexPath of the cell.
 @return Returns a CGRect representing the frame.
 */
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
    if (!self.attrDict) {
        [self initializeAttrDict];
    }
}

-(NSMutableDictionary *)attrDict
{
    if (!_attrDict) {
        [self initializeAttrDict];
    }
    return _attrDict;
}

-(void)setStackCardsInterSpacing:(CGFloat)stackCardsInterSpacing
{
    _stackCardsInterSpacing = stackCardsInterSpacing;
    self.attrDict = nil;
}

-(void)setMainIndexPath:(NSIndexPath *)mainIndexPath
{
    _mainIndexPath = mainIndexPath;
    self.attrDict = nil;
}

-(void)setMainStackSpacing:(CGFloat)mainStackSpacing
{
    _mainStackSpacing = mainStackSpacing;
    self.attrDict = nil;
}

-(void)setCardSize:(CGSize)cardSize
{
    _cardSize = cardSize;
    self.attrDict = nil;
}

-(void)initializeAttrDict
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    int count = 0;
    for (int section = 0; section < self.collectionView.numberOfSections; section++)
        for (int item = 0; item < [self.collectionView numberOfItemsInSection:section]; item++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGRect frame = [self frameForIndexPath:indexPath];
            UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            layoutAttributes.frame = frame;
            layoutAttributes.zIndex = count * -1;
            dict[indexPath] = layoutAttributes;
            
            count--;
        }
    _attrDict = dict;
}

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = self.cardSize.height;
    CGFloat width = self.cardSize.width;
    CGFloat stackTopMargin = 0.0;
    CGFloat topMargin = 20.0;
    NSInteger offset = 0;
    
    if (self.mainIndexPath) {
        // if main index is set, account for it in the positioning
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
        
        stackTopMargin = height + self.mainStackSpacing;
    }
    
    return CGRectMake((self.collectionView.bounds.size.width - width)/2.0, topMargin + stackTopMargin + (indexPath.item + offset) * self.stackCardsInterSpacing, width, height);
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.attrDict[indexPath];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSMutableArray *visibleLayoutAttributes = [NSMutableArray new];
    for (NSIndexPath *key in self.attrDict) {
        UICollectionViewLayoutAttributes *layoutAttributes = self.attrDict[key];
        if (CGRectIntersectsRect(rect, layoutAttributes.frame)) {
            [visibleLayoutAttributes addObject:layoutAttributes];
        }
    }
    return visibleLayoutAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(320, 1000);
}

@end
