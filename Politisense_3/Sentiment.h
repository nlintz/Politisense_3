//
//  Sentiment.h
//  SentimentClient
//
//  Created by Nathan Lintz on 11/19/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sentiment : NSObject

- (NSDictionary *)getSentiment:(NSString *)sentimentString;

@end
