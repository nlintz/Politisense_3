//
//  ViewController.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/27/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "ViewController.h"
#import "MainView.h"
#import "Sentiment.h"
#import "SentimentModel.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) MainView *mainView;

- (void)analyzeSentiment:(id)sender;

@end

@implementation ViewController
@synthesize mainView;

- (void)loadView {
    [super loadView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainView =[[MainView alloc] initWithFrame:CGRectZero];
    self.view = self.mainView;

//    Setup Delegates + Events
    [self.mainView.sentimentTextView setDelegate:(id)self];
    [self.mainView.sentimentAnalyzeButton addTarget:self action:@selector(analyzeSentiment:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Callback when user presses the analyze sentiment button
- (void)analyzeSentiment:(id)sender {
    
    [self.mainView.sentimentTextView resignFirstResponder];
    
    if (![self.mainView.sentimentTextView.text isEqualToString: @""])
    {
        Sentiment *sentimentClient = [[Sentiment alloc] init];
        NSMutableArray *sentiments = [sentimentClient getSentiments:self.mainView.sentimentTextView.text];
        [sentiments enumerateObjectsUsingBlock:^(NSNumber *sentimentValue, NSUInteger idx, BOOL *stop) {
            SentimentModel *sentimentModel = self.mainView.sentimentView.sentimentModels[idx];
            sentimentModel.sentimentValue = [sentimentValue floatValue];
            [self.mainView.sentimentView setNeedsLayout];
        }];
        
    }
}

@end
