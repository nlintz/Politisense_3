//
//  SentimentModel.h
//  Politisense_3
//
//  Created by Nathan Lintz on 12/28/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

// <<< You don't need to include Foundation.h. See discussion in ViewController.h >>>
#import <Foundation/Foundation.h>

@interface SentimentModel : NSObject
// <<< Strongly consider making this object immutable (by making the two properties readonly instead of
// strong or assign. Immutable model objects are a lot easier to reason about and are automatically
// threadsafe! It's totally fine to allocate four new SentimentModel objects everytime you look up a
// new keyword. See this article for a more in-depth discussion of value
// objects: http://www.objc.io/issue-7/value-objects.html >>>

@property (nonatomic, strong) NSString *sentimentType;
// <<< You should explicitly declare all properties as nonatomic otherwise you'll incur unnecessary
// overhead as the runtime aquires and releases a mutex everytime |sentimentValue| is referenced.
@property float sentimentValue;

// <<< Initializers should return instanceType. instanceType means that the method will return an object
// which is the same type as the receiver. So, if you end up subclassing SentimentModel to SentimentModelSubclass,
// then this method will return an object of type SentimentModelSubclass, which is what you expect
// from initializers >>>
- (SentimentModel *)initWithAttrs:(NSString *)sentimentType sentimentValue:(float)sentimentValue;

@end
