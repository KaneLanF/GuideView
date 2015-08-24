//
//  GreetLoginView.m
//  PocketKitchenIphone4.0
//
//  Created by Kane on 15/8/6.
//  Copyright (c) 2015年 jinban-Mac. All rights reserved.
//

#import "GreetLoginView.h"

@implementation GreetLoginView

+ (GreetLoginView*)shareLoginView
{
    return [[NSBundle mainBundle] loadNibNamed:@"GreetLoginView" owner:nil options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
