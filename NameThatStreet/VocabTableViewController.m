//
//  VocabTableViewController.m
//  NameThatStreet
//
//  Created by sally pang on 2016-04-16.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "VocabTableViewController.h"
#import "VocabTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "Colors.h"

@interface VocabTableViewController() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@end

@implementation VocabTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.vocabs = [NSMutableArray arrayWithObjects:@"Hello", @"Goodbye", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Functions
- (IBAction)speakAction:(id)sender {
    UIButton *speakButton = (UIButton *)sender;
    NSInteger index = speakButton.tag;
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:[self.vocabs objectAtIndex:index]];
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer speakUtterance:utterance];
}

- (IBAction)addVocab:(id)sender {
    NSLog(@"PRessed");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Your Own Vocab!"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textAlignment = NSTextAlignmentCenter;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.autocorrectionType = UITextAutocorrectionTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.placeholder = NSLocalizedString(@"Banana Juice, Ostrich..", @"Banana Juice, Ostrich..");
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                         }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Add", @"Add")
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           [self.vocabs addObject:alertController.textFields[0].text];
                                                           [self.tableView reloadData];
                                                       }];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vocabs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VocabTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VocabCell" forIndexPath:indexPath];
    cell.vocabLabel.text = [self.vocabs objectAtIndex:indexPath.row];
    cell.speakButton.tag = indexPath.row;
    
    if( !cell ) {
        // create the cell and stuff
    }
    if( [indexPath row] % 2)
        [cell setBackgroundColor:[UIColor whiteColor]];
    else
        [cell setBackgroundColor:[UIColor colorFromHexString:@"#ddffe0"]];
    
    return cell;
}

@end
