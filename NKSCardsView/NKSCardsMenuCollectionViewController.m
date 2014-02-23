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

@implementation UIView (NKSTouchForwarding)

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.subviews.count == 1 &&[self.subviews.lastObject isKindOfClass:[UICollectionView class]]) {
        for (UIView *subview in [self.subviews.lastObject subviews]) {
            CGPoint relativePoint = CGPointMake(point.x - subview.frame.origin.x, point.y - subview.frame.origin.y);
            if (subview.userInteractionEnabled && [subview pointInside:relativePoint withEvent:event]) {
                return YES;
            }
        }
        return NO;
    }
    return self.userInteractionEnabled && CGRectContainsPoint(self.bounds, point);
}

@end

@implementation NKSCardsMenuCollectionViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (void)loadView
{
    [super loadView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
    stackLayout.cardSize = CGSizeMake(NKS_CARDS_WIDTH, NKS_CARDS_HEIGHT);
    stackLayout.mainStackSpacing = 100.0;
    stackLayout.stackCardsInterSpacing = NKS_CARDS_SPACING_STACK;
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
    NKSCardsStackLayout *stackLayout = [NKSCardsStackLayout new];
    NKSCardsStackLayout *oldLayout = (NKSCardsStackLayout *) collectionView.collectionViewLayout;
    
    stackLayout.mainStackSpacing = oldLayout.mainStackSpacing;
    stackLayout.cardSize = oldLayout.cardSize;
    
    if (!self.collapsed) {
        self.collapsed = YES;
        stackLayout.mainIndexPath = indexPath;
        stackLayout.stackCardsInterSpacing = NKS_CARDS_SPACING_COLLAPSED;
        
        __weak UICollectionView *wCollectionView = collectionView;
        if ([self.menuDelegate respondsToSelector:@selector(cardsMenuViewController:willCollapseMenuAtIndexPath:)]) {
            [self.menuDelegate cardsMenuViewController:self willCollapseMenuAtIndexPath:indexPath];
        }
        [collectionView setCollectionViewLayout:stackLayout animated:YES completion:^(BOOL finished) {
            [[wCollectionView cellForItemAtIndexPath:indexPath] setHidden:YES];
            [[wCollectionView cellForItemAtIndexPath:indexPath] setUserInteractionEnabled:NO];
            if ([self.menuDelegate respondsToSelector:@selector(cardsMenuViewController:didCollapseMenuAtIndexPath:)]) {
                [self.menuDelegate cardsMenuViewController:self didCollapseMenuAtIndexPath:indexPath];
            }
        }];
        [collectionView setScrollEnabled:NO];
    }
    else
    {
        self.collapsed = NO;
        stackLayout.stackCardsInterSpacing = NKS_CARDS_SPACING_STACK;
        
        [collectionView setCollectionViewLayout:stackLayout animated:YES completion:^(BOOL finished) {
            
        }];
        [collectionView setScrollEnabled:YES];
        [collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

@end
