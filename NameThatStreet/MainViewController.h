//
//  ViewController.h
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSTabBarIndex) {
    ProfileViewController = 0,
    VocabTableViewController = 1,
    MapViewController = 2,
};

@interface MainViewController : UITabBarController

- (BOOL)revertSelectedIndex;
- (void)setTabBarHidden:(BOOL)hidden;
- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end

