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

@interface ViewController ()

@property (nonatomic, strong) MainView *mainView;

- (void)analyzeSentiment:(id)sender;

@end

@implementation ViewController
{
    Sentiment *sentimentClient;
}
@synthesize mainView;

- (ViewController *)init
{
    self = [super init];
    if (self){
        sentimentClient = [[Sentiment alloc] init];
    }
    return self;
}

- (void)loadView
{
    self.mainView =[[MainView alloc] initWithFrame:CGRectZero];
    self.view = self.mainView;
}

- (void)viewDidLoad
{

    [self.mainView.sentimentAnalyzeButton addTarget:self action:@selector(analyzeSentiment:) forControlEvents:UIControlEventTouchUpInside];
}

// Callback when user presses the analyze sentiment button
- (void)analyzeSentiment:(id)sender {
  
    [self.mainView resignFirstResponder];
    
    if (![self.mainView.sentimentTextView.text isEqualToString: @""])
    {
        NSMutableArray *sentiments = [sentimentClient getSentiments:self.mainView.sentimentTextView.text];
        [sentiments enumerateObjectsUsingBlock:^(NSNumber *sentimentValue, NSUInteger idx, BOOL *stop) {
            SentimentModel *sentimentModel = self.mainView.sentimentView.sentimentModels[idx];
            sentimentModel.sentimentValue = [sentimentValue floatValue];
            [self.mainView.sentimentView setNeedsLayout];
        }];
        
    }
}

@end
