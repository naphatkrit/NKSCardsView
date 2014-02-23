//
//  NKSCardsMenuCollectionViewController.h
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NKSCardsMenuDelegate <NSObject>

-(void)willCollapseMenu;
-(void)didCollapseMenu;

@end

@interface NKSCardsMenuCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<NKSCardsMenuDelegate> menuDelegate;

@end
