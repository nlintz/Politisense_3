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

@interface ViewController () <UITextFieldDelegate>

@property MainView *mainView;

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
    [self.mainView.sentimentTextField setDelegate:self];
    [self.mainView.sentimentAnalyzeButton addTarget:self action:@selector(analyzeSentiment:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Callback when user presses the analyze sentiment button
- (void)analyzeSentiment:(id)sender {
    
    [self.mainView.sentimentTextField resignFirstResponder];
    
    if (![self.mainView.sentimentTextField.text isEqualToString: @""])
    {
    }
}

// Makes call using sentiment client to get the sentiment data
- (NSMutableArray *)getSentiments:(NSString *)sentimentString
{
    Sentiment *sentimentClient = [[Sentiment alloc] init];
    NSDictionary *sentimentDict = [sentimentClient getSentiment:sentimentString];
    
    CGFloat conservativeSentiment = [[sentimentDict objectForKey:@"Conservative"] floatValue];
    CGFloat liberalSentiment = [[sentimentDict objectForKey:@"Liberal"] floatValue];
    CGFloat libertarianSentiment = [[sentimentDict objectForKey:@"Libertarian"] floatValue];
    CGFloat greenSentiment = [[sentimentDict objectForKey:@"Green"] floatValue];
    
    NSArray *sentiments = [[NSArray alloc] initWithObjects:[NSNumber numberWithFloat:conservativeSentiment],
                           [NSNumber numberWithFloat:liberalSentiment],
                           [NSNumber numberWithFloat:libertarianSentiment],
                           [NSNumber numberWithFloat:greenSentiment],
                           nil];
    NSMutableArray *normalizedSentiments = [self normalizeSentiments:sentiments];
    return normalizedSentiments;
}

// Sentiment data comes in unnormalized, this function fixes that
- (NSMutableArray *)normalizeSentiments:(NSArray *)rawSentiments
{
    NSMutableArray *normalizedSentiments = [[NSMutableArray alloc] init];
    float max = [[rawSentiments valueForKeyPath:@"@max.floatValue"] floatValue];
    float min = [[rawSentiments valueForKeyPath:@"@min.floatValue"] floatValue];
    float normalizingConstant = .1 * (max - min);
    
    for (NSNumber *sentiment in rawSentiments)
    {
        float sentimentValue = [sentiment floatValue];
        float normalizedSentimentValue = (sentimentValue - min + normalizingConstant)/(max - min + normalizingConstant);
        [normalizedSentiments addObject:[NSNumber numberWithFloat:normalizedSentimentValue]];
    }
    return normalizedSentiments;
}


@end
