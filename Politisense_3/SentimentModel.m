//
//  SentimentModel.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "SentimentModel.h"

@implementation SentimentModel

@synthesize sentimentType=_sentimentType, sentimentValue=_sentimentValue;

- (SentimentModel *)initWithAttrs:(NSString *)sentimentType sentimentValue:(float)sentimentValue {
    self = [super init];
    self.sentimentType = sentimentType;
    self.sentimentValue = sentimentValue;
    return self;
}

@end
