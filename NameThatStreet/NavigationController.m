//
//  ProfileNavigationController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "NavigationController.h"
#import "MapViewController.h"
#import "Colors.h"

@implementation NavigationController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]}];
    UIImage *backImage = [UIImage imageNamed:@"BackIcon"];
    [self.navigationBar setBackIndicatorImage:backImage];
    [self.navigationBar setBackIndicatorTransitionMaskImage:backImage];
    [self.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationBar setTranslucent:NO];
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarTintColor:[UIColor colorFromHexString:@"#ffa3a3"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"Navigation Controller: Will show view controller: %@", viewController.class);
    for (UIViewController *controller in self.viewControllers) {
        controller.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    if ([viewController isKindOfClass:[MapViewController class]]) {
        [self setNavigationBarHidden:YES animated:NO];
    }
    else {
        [self setNavigationBarHidden:NO animated:NO];
    }
}

@end
