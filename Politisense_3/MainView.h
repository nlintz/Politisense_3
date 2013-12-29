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

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *sentimentTextView;
@property (nonatomic, strong) UIButton *sentimentAnalyzeButton;
@property (nonatomic, strong) SentimentView *sentimentView;

@end
