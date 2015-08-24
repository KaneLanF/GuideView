//
//  GreetLoginView.h
//  PocketKitchenIphone4.0
//
//  Created by Kane on 15/8/6.
//  Copyright (c) 2015年 jinban-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreetLoginView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commonLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherLoginBtn;

+ (GreetLoginView*)shareLoginView;

@end
