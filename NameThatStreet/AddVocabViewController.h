//
//  AddVocab.h
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VocabDoc.h"

@interface AddVocabViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *vocabTextField;
@property (nonatomic, weak) IBOutlet UITextField *translatedTextField;

@property (nonatomic, strong) NSString *vocabName;
@property (nonatomic, strong) NSString *translatedVocabName;

@end
