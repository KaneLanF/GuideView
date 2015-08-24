//
//  CommentImputView.m
//  PocketKitchenIphone4.0
//
//  Created by Kane on 15/7/15.
//  Copyright (c) 2015年 jinban-Mac. All rights reserved.
//

#import "CommentImputView.h"

@implementation CommentImputView

+ (CommentImputView*)shareImputView
{
    return [[NSBundle mainBundle] loadNibNamed:@"CommentImputView" owner:nil options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
