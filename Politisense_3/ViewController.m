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

// <<< It looks like you don't actually implement any UITextFieldDelegate methods. Do you need to
// bother implementing the protocol? >>>
@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) MainView *mainView;

- (void)analyzeSentiment:(id)sender;

@end

@implementation ViewController
@synthesize mainView;

- (void)loadView {
// <<< Don't call [super loadView] (see https://developer.apple.com/library/ios/documentation/uikit/reference/UIViewController_Class/Reference/Reference.html#//apple_ref/occ/instm/UIViewController/loadView).
// "Your custom implementation should not call super"
//
// Also, |loadView| is where you should set your view, not in |viewDidLoad|. >>>
    [super loadView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
// <<< Set your self.view in |loadView|, not in |viewDidLoad| >>>
    self.mainView =[[MainView alloc] initWithFrame:CGRectZero];
    self.view = self.mainView;

//    Setup Delegates + Events
// <<< It's fine if the textView doesn't have a delegate. It doesn't look like you actually implement
// any delegate methods... Also, you can use dot syntax in setters as well:
//
// self.mainView.sentimentTextView.delegate = self; >>>
    [self.mainView.sentimentTextView setDelegate:(id)self];
    [self.mainView.sentimentAnalyzeButton addTarget:self action:@selector(analyzeSentiment:) forControlEvents:UIControlEventTouchUpInside];
}

/// <<< Just pull this method if you're not gonna do anything interesting besides call super >>>
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Callback when user presses the analyze sentiment button
- (void)analyzeSentiment:(id)sender {
  
// <<< Probably less fragile to have MainView override resignFirstResponder to have it call resignFirstResponder
// on the textview. That way you don't need to expose the text view as a property of the mainView. >>>
    [self.mainView.sentimentTextView resignFirstResponder];
    
    if (![self.mainView.sentimentTextView.text isEqualToString: @""])
    {
// <<< Do you need to instantiate a new sentiment client every time? Couldn't you just do it once
// and store it as an ivar? >>>
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
