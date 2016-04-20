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
#import "Vocab.h"
#import "VocabDoc.h"
#import "VocabDatabase.h"
#import "MapViewController.h"

@interface VocabTableViewController() <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIRefreshControl *refresh;
@end

@implementation VocabTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *loadVocabs = [VocabDatabase loadVocabDocs];
    self.vocabs = loadVocabs;
    
    self.refresh = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refresh];
    [self.refresh addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Functions
- (IBAction)speakAction:(id)sender {
    UIButton *speakButton = (UIButton *)sender;
    NSInteger index = speakButton.tag;
    
    VocabDoc *currentVocab = [self.vocabs objectAtIndex:index];
    
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:currentVocab.data.name];
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer speakUtterance:utterance];
}

- (IBAction)addVocab:(id)sender {
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
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textAlignment = NSTextAlignmentCenter;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        textField.autocorrectionType = UITextAutocorrectionTypeYes;
        textField.returnKeyType = UIReturnKeyDone;
        textField.placeholder = NSLocalizedString(@"Translation", @"Translation");
    }];

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                         }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Add", @"Add")
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           VocabDoc *vocab = [[VocabDoc alloc] initWithName:alertController.textFields[0].text :alertController.textFields[1].text];
                                                           [self.vocabs addObject:vocab];
                                                           [vocab saveData];
                                                           NSLog(@"%@", alertController.textFields[1].text);
                                                           [self.tableView reloadData];
                                                       }];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

- (IBAction)translateAction:(id)sender {
    UIButton *translateButton = (UIButton *)sender;
    NSInteger index = translateButton.tag;
    
    VocabDoc *currentVocab = [self.vocabs objectAtIndex:index];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:currentVocab.data.translatedName message:nil preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
        
    });
}

- (void)refreshTable {
    [self.refresh endRefreshing];
    [self.tableView reloadData];
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
    VocabDoc *currentVocab = [self.vocabs objectAtIndex:indexPath.row];
    cell.vocabLabel.text = currentVocab.data.name;
    cell.speakButton.tag = indexPath.row;
    cell.translateButton.tag = indexPath.row;
    
    if( !cell ) {
        // create the cell and stuff
    }
    if( [indexPath row] % 2)
        [cell setBackgroundColor:[UIColor whiteColor]];
    else
        [cell setBackgroundColor:[UIColor colorFromHexString:@"#ddffe0"]];

    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        VocabDoc *doc = [self.vocabs objectAtIndex:indexPath.row];
        [doc deleteDoc];
        [self.vocabs removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [tableView reloadData];
    }
}

@end
