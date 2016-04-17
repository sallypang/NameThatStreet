//
//  ProfileNavigationController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "ProfileNavigationController.h"
#import "ProfileViewController.h"

@implementation ProfileNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProfileViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self setViewControllers:@[controller] animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
