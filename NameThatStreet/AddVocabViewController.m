//
//  AddVocab.m
//  NameThatStreet
//
//  Created by Sally Pang on 2016-04-19.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

#import "AddVocabViewController.h"
#import "VocabTableViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AddVocabViewController() <UITextFieldDelegate> {
    UIBarButtonItem *_nextToolBarButton;
    UIBarButtonItem *_previousToolBarButton;
}

@property (nonatomic, weak) UITextField *activeTextField;
@property (nonatomic, strong) UIToolbar *inputToolBar;
@property (nonatomic, weak) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *speakButton;

@end

@implementation AddVocabViewController

@synthesize vocabTextField;
@synthesize vocabName;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.vocabTextField.text = self.vocabName;
    self.translatedTextField.text = self.translatedVocabName;
    
    self.vocabTextField.inputAccessoryView = self.inputToolBar;
    self.translatedTextField.inputAccessoryView = self.inputToolBar;
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

- (UIToolbar *)inputToolBar {
    if (!_inputToolBar) {
        _inputToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 44.0)];
        _nextToolBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ForwardIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(nextInputViewAction:)];
        _nextToolBarButton.width = 25.0;
        _previousToolBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(previousInputViewAction:)];
        _previousToolBarButton.width = 25.0;
        UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissPickerViewAction:)];
        [_inputToolBar setItems:@[_previousToolBarButton, _nextToolBarButton, flexibleSpace, doneButton]];
    }
    return _inputToolBar;
}

- (NSInteger)indexOfParentCell:(UITextField *)textField {
    if (textField == self.vocabTextField) {
        return 0;
    }
    else if (textField == self.translatedTextField) {
        return 1;
    }
    return 0;
}

- (UITextField *)textFieldAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
            return self.vocabTextField;
            break;
            
        case 1:
            return self.translatedTextField;
            break;
            
        default:
            break;
    }
    
    return nil;
}

#pragma mark - Private Functions
- (IBAction)speakAction:(id)sender {
    AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:self.vocabName];
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    [synthesizer speakUtterance:utterance];



}

- (IBAction)editAction:(id)sender {
    self.editButton.selected = !self.editButton.selected;
    if (self.editButton.selected) {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.vocabTextField.clearButtonMode = UITextFieldViewModeAlways;
                             self.translatedTextField.clearButtonMode = UITextFieldViewModeAlways;
                         } completion:^(BOOL finished) {
                             self.vocabTextField.userInteractionEnabled = YES;
                             self.translatedTextField.userInteractionEnabled = YES;
                         }];
    }
    else {
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             self.vocabTextField.clearButtonMode = UITextFieldViewModeNever;
                             self.translatedTextField.clearButtonMode = UITextFieldViewModeNever;
                             
                             self.vocabTextField = self.vocabName;
                            
                         } completion:^(BOOL finished) {
                             self.vocabTextField.userInteractionEnabled = NO;
                             self.translatedTextField.userInteractionEnabled = NO;
                         }];
    }

}

- (void)dismissPickerViewAction:(id)sender {
    [self.vocabTextField resignFirstResponder];
    [self.translatedTextField resignFirstResponder];
}

- (void)previousInputViewAction:(id)sender {
    NSInteger index = [self indexOfParentCell:self.activeTextField];
    if (index > 0) {
        UITextField *textField = [self textFieldAtIndex:index-1];
        [textField becomeFirstResponder];
    }
}


- (void)nextInputViewAction:(id)sender {
    NSInteger index = [self indexOfParentCell:self.activeTextField];
    if (index < 1) {
        UITextField *textField = [self textFieldAtIndex:index+1];
        [textField becomeFirstResponder];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger index = [self indexOfParentCell:textField];
        _nextToolBarButton.enabled = index < 1;
        _previousToolBarButton.enabled = index > 0;
    });
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeTextField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.vocabTextField) {
        [self.translatedTextField becomeFirstResponder];
    }
    else if (textField == self.translatedTextField) {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.saveButton == sender) {
        self.vocabName = self.vocabTextField.text;
        self.translatedVocabName = self.translatedTextField.text;
    }
}

@end
