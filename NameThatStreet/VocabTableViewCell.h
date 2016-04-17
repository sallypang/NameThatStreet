//
//  VocabTableViewCell.h
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VocabTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *vocabLabel;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidthConstraint;

@end
