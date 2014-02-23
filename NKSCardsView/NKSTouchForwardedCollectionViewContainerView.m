//
//  NKSTouchForwardedCollectionViewContainerView.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSTouchForwardedCollectionViewContainerView.h"

@implementation NKSTouchForwardedCollectionViewContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *subview in self.subviews) {
        if ([subview pointInside:point withEvent:event]) {
            return [super hitTest:point withEvent:event];
        }
    }
    return nil;
}

@end
