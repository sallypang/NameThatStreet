//
//  ViewController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, assign) NSUInteger previousSelectedIndex;
@property (nonatomic, strong) UIView *toVCSnapshot;
@property (nonatomic, readonly) BOOL isTabBarHidden;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSelectedIndex:VocabTableViewController];
    [super viewDidLoad];
    
    self.previousSelectedIndex = VocabTableViewController;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabBarController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Getters / Setters

- (BOOL)isTabBarHidden {
    return self.tabBar.hidden || self.view.frame.size.height <= self.tabBar.frame.origin.y;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    return [self.viewControllers indexOfObject:viewController];
}


- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    [super setSelectedViewController:selectedViewController];
    
    NSInteger selectedIndex = [self indexOfViewController:selectedViewController];
    [self setTabBarHidden:(selectedIndex == MapViewController)];
}


- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    [self setTabBarHidden:(selectedIndex == MapViewController)];
}

#pragma mark - Private Functions

- (BOOL)revertSelectedIndex {
    if (self.previousSelectedIndex >= self.viewControllers.count) {
        return NO;
    }
    
    self.selectedIndex = self.previousSelectedIndex;
    [self setTabBarHidden:NO animated:YES];
    return YES;
}


- (void)setTabBarHidden:(BOOL)hidden {
    [self setTabBarHidden:hidden animated:YES];
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden == self.isTabBarHidden) {
        return;
    }
    
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        return;
    }
    
    self.tabBar.hidden = hidden;
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    self.previousSelectedIndex = tabBarController.selectedIndex;
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        NSLog(@"TabBarController: Did select view controller: %@", navigationController.topViewController.class);
    }
    else {
        NSLog(@"TabBarController: Did select view controller: %@", viewController.class);
    }
}



@end
