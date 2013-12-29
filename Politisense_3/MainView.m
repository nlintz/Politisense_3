//
//  MainView.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/27/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "MainView.h"
#import "SentimentView.h"

@implementation MainView

@synthesize titleLabel, sentimentAnalyzeButton, sentimentTextView, sentimentView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        Create Subviews
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sentimentAnalyzeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.sentimentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        self.sentimentView = [[SentimentView alloc] initWithFrame:CGRectZero];
        
//        Styling Palatte
        UIColor *orangeColor = [UIColor colorWithRed:205.0/255 green:138.0/255 blue:21.0/255 alpha:1];
        
//        Styling for titleLabel
        [self.titleLabel setText:@"Politisense"];
        [self.titleLabel setTextColor:orangeColor];
        [self.titleLabel setFont:[self.titleLabel.font fontWithSize:48]];
        
//        Styling for sentimentTextView
        [self.sentimentTextView setBackgroundColor:[UIColor whiteColor]];
        [self.sentimentTextView.layer setCornerRadius:5];
        [self.sentimentTextView setFont:[UIFont systemFontOfSize:15]];
        [self.sentimentTextView setAutocorrectionType:UITextAutocorrectionTypeNo];
        
//        Styling for sentimentAnalyzeButton
        [self.sentimentAnalyzeButton setTitle:@"Analyze Sentiment" forState:UIControlStateNormal];
        [self.sentimentAnalyzeButton setTitleColor:orangeColor forState:UIControlStateNormal];
        [self.sentimentAnalyzeButton.layer setCornerRadius:10];
        [self.sentimentAnalyzeButton.layer setBorderWidth:1.0f];
        [self.sentimentAnalyzeButton.layer setBorderColor:orangeColor.CGColor];

//        Add subviews
        [self addSubview:self.titleLabel];
        [self addSubview:self.sentimentAnalyzeButton];
        [self addSubview:self.sentimentTextView];
        [self addSubview:self.sentimentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    Layout for titleLabel
    float titleLabelY = 20.0f;
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(40, titleLabelY, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);

//    Layout for sentimentTextField
    float sentimentTextFieldY = titleLabelY + self.titleLabel.frame.size.height;
    self.sentimentTextView.frame = CGRectMake(40, sentimentTextFieldY, 240, 95);
    
//    Layout for sentimentAnalyzeButton
    float sentimentAnalyzeButtonY = sentimentTextFieldY + sentimentTextView.frame.size.height + 10; //10 px of spacing added
    self.sentimentAnalyzeButton.frame = CGRectMake(40, sentimentAnalyzeButtonY, 240, 30);

//    Layout for sentimentView
    float sentimentViewY = sentimentAnalyzeButtonY + sentimentAnalyzeButton.frame.size.height + 10;
    float sentimentViewHeight = self.frame.size.height - sentimentViewY;
    self.sentimentView.frame = CGRectMake(0, sentimentViewY, self.bounds.size.width, sentimentViewHeight);    
}

@end
