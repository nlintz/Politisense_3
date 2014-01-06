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
{
    UILabel *titleLabel;
    UITextView *sentimentTextView;
    SentimentView *sentimentView;
}

@synthesize sentimentAnalyzeButton;


- (id)initWithFrame:(CGRect)frame sentimentModels:(NSArray *)sentimentModels
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        Create Subviews
        titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.sentimentAnalyzeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sentimentTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        sentimentView = [[SentimentView alloc] initWithFrame:CGRectZero sentimentModels:sentimentModels];
        
//        Styling Palatte
        UIColor *orangeColor = [UIColor colorWithRed:205.0/255 green:138.0/255 blue:21.0/255 alpha:1];
        
//        Background Color
        self.backgroundColor = [UIColor colorWithRed:31.0/255 green:33.0/255 blue:36.0/255 alpha:1];
        
        
//        Styling for titleLabel
        [titleLabel setText:@"Politisense"];
        [titleLabel setTextColor:orangeColor];
        [titleLabel setFont:[titleLabel.font fontWithSize:48]];
        
//        Styling for sentimentTextView
        [sentimentTextView setBackgroundColor:[UIColor whiteColor]];
        [sentimentTextView.layer setCornerRadius:5];
        [sentimentTextView setFont:[UIFont systemFontOfSize:15]];
        [sentimentTextView setAutocorrectionType:UITextAutocorrectionTypeNo];
        
//        Styling for sentimentAnalyzeButton
        [self.sentimentAnalyzeButton setTitle:@"Analyze Sentiment" forState:UIControlStateNormal];
        [self.sentimentAnalyzeButton setTitleColor:orangeColor forState:UIControlStateNormal];
        [self.sentimentAnalyzeButton.layer setCornerRadius:10];
        [self.sentimentAnalyzeButton.layer setBorderWidth:1.0f];
        [self.sentimentAnalyzeButton.layer setBorderColor:orangeColor.CGColor];

//        Add subviews
        [self addSubview:titleLabel];
        [self addSubview:self.sentimentAnalyzeButton];
        [self addSubview:sentimentTextView];
        [self addSubview:sentimentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    Layout for titleLabel
    float titleLabelY = 20.0f;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(40, titleLabelY, titleLabel.frame.size.width, titleLabel.frame.size.height);

//    Layout for sentimentTextField
    float sentimentTextFieldY = titleLabelY + titleLabel.frame.size.height;
    sentimentTextView.frame = CGRectMake(40, sentimentTextFieldY, 240, 95);
    
//    Layout for sentimentAnalyzeButton
    float sentimentAnalyzeButtonY = sentimentTextFieldY + sentimentTextView.frame.size.height + 10; //10 px of spacing added
    self.sentimentAnalyzeButton.frame = CGRectMake(40, sentimentAnalyzeButtonY, 240, 30);

//    Layout for sentimentView
    float sentimentViewY = sentimentAnalyzeButtonY + sentimentAnalyzeButton.frame.size.height + 10;
    float sentimentViewHeight = self.frame.size.height - sentimentViewY;
    sentimentView.frame = CGRectMake(0, sentimentViewY, self.bounds.size.width, sentimentViewHeight);
}

-(NSString *)getSentimentText {
    return sentimentTextView.text;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [sentimentTextView resignFirstResponder];
    return YES;
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [sentimentView setNeedsLayout];
}

- (void)setSentimentModels:(NSArray *)_sentimentModels{
    [sentimentView updateSentimentModels:_sentimentModels];
}


@end
