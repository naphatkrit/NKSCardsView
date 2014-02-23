//
//  NKSCardsStackLayout.h
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 A Stack Layout is used to layout CollectionViewCells as a vertical stack of cards. 
 An indexPath can be optionally set as main, meaning this card will be floating above
 other cards.
 */
@interface NKSCardsStackLayout : UICollectionViewLayout

/*!
 The indexPath of the cell designated as the main card.
 */
@property (nonatomic, strong) NSIndexPath *mainIndexPath;

/*!
 The spacing between the cards in the stack. This is the value
 from the top of one card to another
 */
@property (nonatomic) CGFloat stackCardsInterSpacing;

/*!
 The spacing between the main card and the stack.
 */
@property (nonatomic) CGFloat mainStackSpacing;

/*!
 The size of a card.
 */
@property (nonatomic) CGSize cardSize;

/*!
 Set the alpha of the cell of mainIndex to 0
 */
-(void)hideMainIndex;

@end
