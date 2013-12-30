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

// <<< Yuck! Use an asynchronous request if it's a network call! You don't want your UI thread to
// block while you're waiting for the network call to return. >>>
    NSData *sentimentData = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
        
    NSDictionary *sentimentDict = [NSJSONSerialization JSONObjectWithData:sentimentData options:0 error:&error];
    
    return sentimentDict;
}

// Makes call using sentiment client to get the sentiment data
- (NSMutableArray *)getSentiments:(NSString *)sentimentString
{
// <<< Why are you instantiating a new Sentiment instance everytime this method is invoked instead of
// using self? Should this be a class method instead of an instance method? >>>
    Sentiment *sentimentClient = [[Sentiment alloc] init];
    NSDictionary *sentimentDict = [sentimentClient getRawSentiments:sentimentString];
  
// <<< These should be declared as floats instead of CGFloats. The documentation for |floatValue| specifies
// that it returns floats.
//
// Second, you generally don't wanna hardcode string literals that you want to display in the user interface
// because it's hard to localize. Like, if you wanted to translate this to Spanish, it would be really
// tricky to look at every place in your code where you hardcode the string "Conservative" and localize it there.
// Instead, consider NSLocalizedString instead of hardcoding UI strings http://nshipster.com/nslocalizedstring/
//
// Finally, it's a bad idea to include UI strings in model objects! In the spirit of separation of concerns,
// UI strings should only be referenced in view objects. Consider using an ENUM instead? There's an
// NS_ENUM macro that makes it super easy: http://nshipster.com/ns_enum-ns_options/ >>>
//
    CGFloat conservativeSentiment = [[sentimentDict objectForKey:@"Conservative"] floatValue];
    CGFloat liberalSentiment = [[sentimentDict objectForKey:@"Liberal"] floatValue];
    CGFloat libertarianSentiment = [[sentimentDict objectForKey:@"Libertarian"] floatValue];
    CGFloat greenSentiment = [[sentimentDict objectForKey:@"Green"] floatValue];

// <<< Alternatively, you can box a primitive into an NSNumber using @() syntax. There's also syntax
// for Array literals. So you can rewrite the code like this:
// NSArray *sentiments = @[@(conservativeSentiment), @(liberalSentiment), @(libertarianSentiment), @(greenSentiment)];
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
// <<< Alternatively: NSMutableArray *normalizedSentiments = [NSMutableArray array]; >>>
    NSMutableArray *normalizedSentiments = [[NSMutableArray alloc] init];
// <<< Oh you fancy huh >>>
    float max = [[rawSentiments valueForKeyPath:@"@max.floatValue"] floatValue];
    float min = [[rawSentiments valueForKeyPath:@"@min.floatValue"] floatValue];
    float normalizingConstant = .1 * (max - min);
    
    for (NSNumber *sentiment in rawSentiments)
    {
        float sentimentValue = [sentiment floatValue];
        float normalizedSentimentValue = (sentimentValue - min + normalizingConstant)/(max - min + normalizingConstant);
// <<< Alternatively: [normalizedSentiments addObject:@(normalizedSentimentValue)]; >>>
        [normalizedSentiments addObject:[NSNumber numberWithFloat:normalizedSentimentValue]];
    }
    return normalizedSentiments;
}


@end
