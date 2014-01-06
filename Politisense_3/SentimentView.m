//
//  SentimentView.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "SentimentView.h"
#import "SentimentModel.h"

CGFloat const sentimentLabelWidth = 80.0f;
CGFloat const sentimentLabelHeight = 14.316f;
CGFloat const sentimentLabelY = 223.0f; // 20 px padding from bottom
CGFloat const maxBarHeight = 219.0f; //3 px of padding between bar and bottom
CGFloat const sentimentTypeFontSize = 12.0f;

@implementation SentimentView
{
    NSArray *sentimentModels;
}

@synthesize conservativeLabel, liberalLabel, libertarianLabel,greenLabel, sentimentLabels=_sentimentLabels, sentimentBars=_sentimentBars;

- (id)initWithFrame:(CGRect)frame sentimentModels:(NSArray *)_sentimentModels
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.conservativeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.liberalLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.libertarianLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.greenLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sentimentLabels = @[self.conservativeLabel, self.liberalLabel, self.libertarianLabel, self.greenLabel];
        
        UIView *conservativeBar = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *liberalBar = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *libertarianBar = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *greenBar = [[UIView alloc] initWithFrame:CGRectZero];
        self.sentimentBars = @[conservativeBar, liberalBar, libertarianBar, greenBar];

        NSArray *sentimentColors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor]];
        
        sentimentModels = _sentimentModels;
        
        [self.sentimentLabels enumerateObjectsUsingBlock:^(UILabel *sentimentLabel, NSUInteger idx, BOOL *stop) {
            SentimentModel *sentimentModel = sentimentModels[idx];
            UIView *sentimentBar = self.sentimentBars[idx];
            
            sentimentLabel.text = sentimentModel.sentimentType;
            sentimentLabel.textAlignment = NSTextAlignmentCenter;
            sentimentLabel.textColor = [UIColor whiteColor];
            sentimentLabel.font = [sentimentLabel.font fontWithSize:sentimentTypeFontSize];

            UIColor *sentimentColor = sentimentColors[idx];
            sentimentBar.layer.backgroundColor = sentimentColor.CGColor;
            
            [self addSubview:sentimentLabel];
            [self addSubview:sentimentBar];
        }];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    [self.sentimentLabels enumerateObjectsUsingBlock:^(UILabel *sentimentLabel, NSUInteger idx, BOOL *stop) {
        SentimentModel *sentimentModel = sentimentModels[idx];
        UIView *sentimentBar = self.sentimentBars[idx];
        
        sentimentLabel.frame = CGRectMake(idx * sentimentLabelWidth, sentimentLabelY, sentimentLabelWidth, sentimentLabelHeight);

        sentimentBar.layer.anchorPoint = CGPointMake(0, 1);

        [UIView beginAnimations : @"ChangeSentimentBarHeight" context:nil];
        [UIView setAnimationDuration:1];
        
        sentimentBar.layer.frame = CGRectMake(idx * sentimentLabelWidth, maxBarHeight * (1 - sentimentModel.sentimentValue), sentimentLabelWidth, maxBarHeight * sentimentModel.sentimentValue);

        [UIView commitAnimations];
        

    }];
}

- (void)updateSentimentModels:(NSArray *)_sentimentModels
{
    sentimentModels = _sentimentModels;
}

@end
