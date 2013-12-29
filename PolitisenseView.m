//
//  PolitisenseView.m
//  Politisense_3
//
//  Created by Nathan Lintz on 12/27/13.
//  Copyright (c) 2013 Nathan Lintz. All rights reserved.
//

#import "PolitisenseView.h"
#import "PolitisenseLabel.h"

@implementation PolitisenseView
{
    PolitisenseLabel *label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        label = [[PolitisenseLabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self addSubview:label];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
