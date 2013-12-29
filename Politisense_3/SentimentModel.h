//
//  SentimentModel.h
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SentimentModel : NSObject

@property NSString *sentimentType;
@property float sentimentValue;

- (SentimentModel *)initWithAttrs:(NSString *)sentimentType sentimentValue:(float)sentimentValue;

@end
