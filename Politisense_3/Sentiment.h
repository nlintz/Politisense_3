//
//  Sentiment.h
//  SentimentClient
//
//  Created by Nathan Lintz on 11/19/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

// <<< You don't need to include Foundation.h. See longer explanation in ViewController.h >>>
#import <Foundation/Foundation.h>

@interface Sentiment : NSObject

// <<< This should be an asynchronous call since it involves a network call. Like, if you run the app
// with your wifi radio turned off, the app freezes when you tap "Analyze Sentiment". So... how do you make
// this call asynchronous? With blocks! A simple method signature might look like this:
//
// - (void)getSentiments:(NSString *)sentimentString
//            completion:(void (^)(BOOL isSuccessful, NSArray *sentiments))completion;
//
// The completion block should get called when the netwrok call finally returns. The |isSuccessful|
// parameter is YES if the call is successful and NO if the call fails (e.g. no network connection).
//
// Finally, this call should return an immutable NSArray instead of NSMutableArray since it's more general
// and immutable variables are generally safer than mutable. It's fine if internally the method uses
// a NSMutableArray since NSMutableArray is a subclass of NSArray so it can be returned and will be
// automatically cast to NSArray. >>>
//
- (NSMutableArray *)getSentiments:(NSString *)sentimentString;

@end
