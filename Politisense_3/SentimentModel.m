//
//  SentimentModel.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "SentimentModel.h"

@implementation SentimentModel

// <<< Why are you declaring _sentimentType and _sentimentValue? >>>
@synthesize sentimentType=_sentimentType, sentimentValue=_sentimentValue;

- (SentimentModel *)initWithAttrs:(NSString *)sentimentType sentimentValue:(float)sentimentValue {
// <<< Initializers should follow a standard template:
// self = [super init]; // Or whatever the designated initializer of the superclass is
// if (self) // Only continue initialization if [super init] returns a non-nil value
// {
//     ...stuff
// }
// return self;
//
// Here's a good article on initializers: https://developer.apple.com/library/ios/documentation/general/conceptual/CocoaEncyclopedia/Initialization/Initialization.html
    self = [super init];
    self.sentimentType = sentimentType;
    self.sentimentValue = sentimentValue;
    return self;
}

// If you want your subclass's designated initializer to be something different than its superclass's
// designated initializer |initWithAttrs:sentimentValue:| vs |init| then you still need to explicity
// override your superclass's designated initializer. Really simple in this case:
//
// - (instanceType)init {
//     return [self initWithAttrs:nil sentimentValue:0.0f];
// }

@end
