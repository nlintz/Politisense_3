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

@property UILabel *titleLabel;
@property UITextField *sentimentTextField;
@property UIButton *sentimentAnalyzeButton;
@property SentimentView *sentimentView;

@end
