//
//  MainView.h
//  Politisense_3
//
//  Created by Nathan Lintz on 12/27/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SentimentView.h"

@interface MainView : UIView

// <<< It's fragile to expose references to all your subviews. And extra fragile to expose them as
// readwrite! It's better to have the view manage it's subviews internally. If you really need to let
// the view controller set data, expose one-off methods to do it. E.g. instead of exposing |sentimentView|
// directly, expose a method that accepts a SentimentModel and internally uses it to populate your
// sentiment view. >>>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *sentimentTextView;
@property (nonatomic, strong) UIButton *sentimentAnalyzeButton;
@property (nonatomic, strong) SentimentView *sentimentView;

@end
