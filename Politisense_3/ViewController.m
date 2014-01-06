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
@property (nonatomic, strong) SentimentModel *conservativeModel, *liberalModel, *libertarianModel, *greenModel;

- (void)analyzeSentiment:(id)sender;

@end

@implementation ViewController
{
    Sentiment *sentimentClient;
    NSArray *sentimentModels;
}
@synthesize mainView, conservativeModel, libertarianModel, greenModel;

- (ViewController *)init
{
    self = [super init];
    if (self){
        sentimentClient = [[Sentiment alloc] init];
        self.conservativeModel = [[SentimentModel alloc] initWithAttrs:@"Conservative"
                                                        sentimentValue:0.0f];
        self.liberalModel = [[SentimentModel alloc] initWithAttrs:@"Liberal"
                                                   sentimentValue:0.0f];
        self.libertarianModel = [[SentimentModel alloc] initWithAttrs:@"Libertarian"
                                                       sentimentValue:0.0f];
        self.greenModel = [[SentimentModel alloc] initWithAttrs:@"Green"
                                                 sentimentValue:0.0f];
        sentimentModels = @[self.conservativeModel, self.liberalModel, self.libertarianModel, self.greenModel];
    }
    return self;
}

- (void)loadView
{
    self.mainView =[[MainView alloc] initWithFrame:CGRectZero sentimentModels:sentimentModels];
//    [self.mainView setSentimentModels:sentimentModels];
    self.view = self.mainView;
}

- (void)viewDidLoad
{

    [self.mainView.sentimentAnalyzeButton addTarget:self action:@selector(analyzeSentiment:) forControlEvents:UIControlEventTouchUpInside];
}

// Callback when user presses the analyze sentiment button
- (void)analyzeSentiment:(id)sender {
  
    [self.mainView resignFirstResponder];
    
    NSString *sentimentText = [self.mainView getSentimentText];
    if (![sentimentText isEqualToString: @""])
    {
        NSMutableArray *sentiments = [sentimentClient getSentiments:sentimentText];
        [sentiments enumerateObjectsUsingBlock:^(NSNumber *sentimentValue, NSUInteger idx, BOOL *stop) {
            SentimentModel *sentimentModel = sentimentModels[idx];
            sentimentModel.sentimentValue = [sentimentValue floatValue];
            [self.mainView setNeedsLayout];
        }];
        
    }
}

@end
