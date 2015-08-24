//
//  CommentImputView.h
//  PocketKitchenIphone4.0
//
//  Created by Kane on 15/7/15.
//  Copyright (c) 2015年 jinban-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentImputView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

+ (CommentImputView*)shareImputView;

@end
