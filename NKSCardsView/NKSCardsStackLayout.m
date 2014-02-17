//
//  NKSCardsStackLayout.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsStackLayout.h"

@interface NKSCardsStackLayout ()

@property (nonatomic, strong) UIDynamicAnimator *dynamicAnimator;
@property (nonatomic, strong) NSIndexPath *mainIndexPath;
@property (nonatomic, strong) NSMutableDictionary *frameDict;
@property (nonatomic, strong) NSMutableDictionary *stickyFrameDict;

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation NKSCardsStackLayout

- (id)init
{
    if (!(self = [super init])) return nil;
    
//    self.minimumInteritemSpacing = 10;
//    self.minimumLineSpacing = 10;
//    self.itemSize = CGSizeMake(44, 44);
//    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    
    return self;
}

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
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    self.frameDict = [NSMutableDictionary new];
    self.stickyFrameDict = [NSMutableDictionary new];
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
            
            UICollectionViewLayoutAttributes *stickyLayoutAttributes = [layoutAttributes copy];
            frame.origin.y = 0.0;
            stickyLayoutAttributes.frame = frame;
            self.stickyFrameDict[indexPath] = stickyLayoutAttributes;
            
            count--;
        }
    
    if (self.dynamicAnimator.behaviors.count == 0) {
        [self.frameDict.allValues enumerateObjectsUsingBlock:^(id<UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behaviour = [[UIAttachmentBehavior alloc] initWithItem:obj
                                                                        attachedToAnchor:[obj center]];

            behaviour.length = 0.0f;
            behaviour.damping = 0.8f;
            behaviour.frequency = 1.0f;
            
            [self.dynamicAnimator addBehavior:behaviour];
        }];
    }
}

-(CGRect)frameForIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 200.0;
    CGFloat width = 300.0;
    CGFloat verticalDist = 100.0;
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
    return [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
//    NSMutableArray *visibleLayoutAttributes = [NSMutableArray new];
//    for (NSIndexPath *key in self.frameDict) {
//        UICollectionViewLayoutAttributes *layoutAttributes = [self attributesForIndexPath:key inRect:rect];
//        if (layoutAttributes != nil) {
//            [visibleLayoutAttributes addObject:layoutAttributes];
//        }
//    }
    return [self.dynamicAnimator itemsInRect:rect];
}

//-(UICollectionViewLayoutAttributes *)attributesForIndexPath:(NSIndexPath *)indexPath inRect:(CGRect) rect;
//{
//    UICollectionViewLayoutAttributes *layoutAttributes = self.frameDict[indexPath];
//    if (CGRectIntersectsRect(rect, layoutAttributes.frame)) {
//        return layoutAttributes;
//    }
//    layoutAttributes = self.stickyFrameDict[indexPath];
//    if (CGRectIntersectsRect(rect, layoutAttributes.frame)) {
//        return layoutAttributes;
//    }
//    return nil;
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 100.0f;
        
        UICollectionViewLayoutAttributes *item = springBehaviour.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [self.dynamicAnimator updateItemUsingCurrentState:item];
    }];
    return NO;
}

-(CGSize)collectionViewContentSize
{
    return CGSizeMake(320, 1000);
}

@end
