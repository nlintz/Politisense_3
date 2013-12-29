//
//  SentimentView.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "SentimentView.h"
#import "SentimentModel.h"

@implementation SentimentView

@synthesize conservativeLabel, conservativeModel, liberalLabel, liberalModel, libertarianLabel, libertarianModel,greenLabel, greenModel, sentimentLabels=_sentimentLabels, sentimentModels=_sentimentModels, sentimentBars=_sentimentBars;

- (id)initWithFrame:(CGRect)frame
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

        
        self.conservativeModel = [[SentimentModel alloc] initWithAttrs:@"Conservative"
                                                        sentimentValue:0.0f];
        self.liberalModel = [[SentimentModel alloc] initWithAttrs:@"Liberal"
                                                        sentimentValue:0.0f];
        self.libertarianModel = [[SentimentModel alloc] initWithAttrs:@"Libertarian"
                                                        sentimentValue:0.0f];
        self.greenModel = [[SentimentModel alloc] initWithAttrs:@"Green"
                                                        sentimentValue:0.0f];
        self.sentimentModels = @[self.conservativeModel, self.liberalModel, self.libertarianModel, self.greenModel];
        
        NSArray *sentimentColors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor]];
        
        float sentimentTypeFontSize = 12.0f;
        
        [self.sentimentLabels enumerateObjectsUsingBlock:^(UILabel *sentimentLabel, NSUInteger idx, BOOL *stop) {
            SentimentModel *sentimentModel = self.sentimentModels[idx];
            UIView *sentimentBar = self.sentimentBars[idx];
            
            sentimentLabel.text = sentimentModel.sentimentType;
            sentimentLabel.textAlignment = NSTextAlignmentCenter;
            sentimentLabel.textColor = [UIColor whiteColor];
            sentimentLabel.font = [sentimentLabel.font fontWithSize:sentimentTypeFontSize];

            sentimentBar.backgroundColor = sentimentColors[idx];
            
            [self addSubview:sentimentLabel];
            [self addSubview:sentimentBar];
        }];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize sentimentLabelSize = [self.conservativeLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f]}];
    float sentimentLabelWidth = self.bounds.size.width / 4;
    float sentimentLabelHeight = sentimentLabelSize.height;
    float sentimentLabelY = self.bounds.size.height - sentimentLabelHeight - 20; // 20 px padding from bottom
    float maxBarHeight = sentimentLabelY - 3; //3 px of padding between bar and bottom

    [self.sentimentLabels enumerateObjectsUsingBlock:^(UILabel *sentimentLabel, NSUInteger idx, BOOL *stop) {
        SentimentModel *sentimentModel = self.sentimentModels[idx];
        UIView *sentimentBar = self.sentimentBars[idx];
        sentimentLabel.frame = CGRectMake(idx * sentimentLabelWidth, sentimentLabelY, sentimentLabelWidth, sentimentLabelHeight);
        sentimentBar.frame = CGRectMake(idx * sentimentLabelWidth, maxBarHeight * (1 - sentimentModel.sentimentValue), sentimentLabelWidth, maxBarHeight * sentimentModel.sentimentValue);
    }];
}

@end
