//
//  AddVocab.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "AddVocabViewController.h"
#import "VocabTableViewController.h"
#import "VocabDoc.h"

@interface AddVocabViewController()

@end

@implementation AddVocabViewController

@synthesize vocabTextField;
@synthesize vocabName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vocabTextField.text = self.vocabName;
    self.translatedTextField.text = self.translatedVocabName;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getters / Setters


@end
