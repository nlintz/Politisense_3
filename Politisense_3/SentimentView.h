//
//  SentimentView.h
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SentimentModel.h"

@interface SentimentView : UIView

- (id)initWithFrame:(CGRect)frame sentimentModels:(NSArray *)_sentimentModels;
- (void)updateSentimentModels:(NSArray *)sentimentModels;
@property (nonatomic, strong)  UILabel *conservativeLabel, *liberalLabel, *libertarianLabel, *greenLabel;
@property (nonatomic, strong)  NSArray *sentimentLabels, *sentimentBars;

@end
