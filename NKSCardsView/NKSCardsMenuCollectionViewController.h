//
//  NKSCardsMenuCollectionViewController.h
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NKSCardsMenuCollectionViewController;
@protocol NKSCardsMenuDelegate <NSObject>

-(void)cardsMenuViewController:(NKSCardsMenuCollectionViewController *)cardsMenuViewController willCollapseMenuAtIndexPath:(NSIndexPath *)indexPath;
-(void)cardsMenuViewController:(NKSCardsMenuCollectionViewController *)cardsMenuViewController didCollapseMenuAtIndexPath:(NSIndexPath *)indexPath;
-(void)cardsMenuViewController:(NKSCardsMenuCollectionViewController *)cardsMenuViewController willExpandMenuAtIndexPath:(NSIndexPath *)indexPath;
-(void)cardsMenuViewController:(NKSCardsMenuCollectionViewController *)cardsMenuViewController didExpandMenu:(NSIndexPath *)indexPath;

@end

@interface NKSCardsMenuCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<NKSCardsMenuDelegate> menuDelegate;

@end
