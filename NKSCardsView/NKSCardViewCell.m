//
//  NKSCardViewCell.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/16/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NKSCardViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0].CGColor;
        self.layer.cornerRadius = 5.0;
//        self.layer.shouldRasterize = YES;
    }
    return self;
}

//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    
//}



@end
