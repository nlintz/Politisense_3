//
//  Sentiment.m
//  SentimentClient
//
//  Created by Nathan Lintz on 11/19/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "Sentiment.h"

@implementation Sentiment

- (NSDictionary *)getRawSentiments:(NSString *)sentimentString
{
    NSURL *url = [NSURL URLWithString:@"http://indico.io/api/sentiment/classify"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSError *error = nil;
    
    [request setHTTPMethod:@"POST"];

    NSString *postData = @"text=";
    postData = [postData stringByAppendingString:sentimentString];
    
    [request setValue:[NSString stringWithFormat:@"%ul", [postData length]] forHTTPHeaderField:@"Content-length"];
    
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *sentimentData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
        
    NSDictionary *sentimentDict = [NSJSONSerialization JSONObjectWithData:sentimentData options:0 error:&error];
    
    return sentimentDict;
}

// Makes call using sentiment client to get the sentiment data
- (NSMutableArray *)getSentiments:(NSString *)sentimentString
{
    Sentiment *sentimentClient = [[Sentiment alloc] init];
    NSDictionary *sentimentDict = [sentimentClient getRawSentiments:sentimentString];
    
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
