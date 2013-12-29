//
//  Sentiment.m
//  SentimentClient
//
//  Created by Nathan Lintz on 11/19/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "Sentiment.h"

@implementation Sentiment

- (NSDictionary *)getSentiment:(NSString *)sentimentString
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


@end
