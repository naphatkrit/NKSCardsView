//
//  NKSCardsViewController.m
//  NKSCardsView
//
//  Created by Naphat Sanguansin on 2/23/14.
//  Copyright (c) 2014 Naphat Sanguansin. All rights reserved.
//

#import "NKSCardsViewController.h"
#import "NKSCardsContentViewController.h"
#import "NKSCardsMenuCollectionViewController.h"

@interface NKSCardsViewController () <NKSCardsMenuDelegate>

@property (nonatomic, strong) NKSCardsMenuCollectionViewController *menuViewController;
//@property (nonatomic, strong) UITapGestureRecognizer *menuTapGestureRecognizer;
@property (nonatomic, strong) NKSCardsContentViewController *contentViewController;

-(void)setupMenuViewController;
-(void)setupContentViewController;

-(void)expandMenu;

@end

@implementation NKSCardsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setupMenuViewController];
    [self setupContentViewController];
    [self.contentViewController.view setHidden:YES];
}

- (void)setupMenuViewController
{
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MENU"];
    self.menuViewController.menuDelegate = self;
    if (self.contentViewController && self.contentViewController.view.superview == self.view) {
        [self.view insertSubview:self.menuViewController.view aboveSubview:self.contentViewController.view];
    }
    else {
        [self.view addSubview:self.menuViewController.view];
    }
    
    [self addChildViewController:self.menuViewController];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.menuViewController.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *botConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.menuViewController.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.menuViewController.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.menuViewController.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[topConstraint, botConstraint, rightConstraint, leftConstraint]];
    
//    self.menuTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expandMenu)];
//    [self.menuViewController.view addGestureRecognizer:self.menuTapGestureRecognizer];
//    self.menuTapGestureRecognizer.enabled = NO;
}

- (void)expandMenu
{
    NSLog(@"touched");
}

- (void)setupContentViewController
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CONTENT"];
    if (self.menuViewController && self.menuViewController.view.superview == self.view) {
        [self.view insertSubview:self.contentViewController.view belowSubview:self.menuViewController.view];
    }
    else {
        [self.view addSubview:self.contentViewController.view];
    }
    
    [self addChildViewController:self.contentViewController];
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentViewController.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *botConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentViewController.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentViewController.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentViewController.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[topConstraint, botConstraint, rightConstraint, leftConstraint]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Menu Delegate



-(void)cardsMenuViewController:(NKSCardsMenuCollectionViewController *)cardsMenuViewController didCollapseMenuAtIndexPath:(NSIndexPath *)indexPath
{
    [self.contentViewController.view setHidden:NO];
    [self.contentViewController expandContent];
//    self.menuTapGestureRecognizer.enabled = YES;
}

@end
