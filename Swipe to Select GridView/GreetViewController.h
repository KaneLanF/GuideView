//
//  ExampleViewController.h
//  Swipe to Select GridView
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol greetViewRemoveDelegate <NSObject>

//- (void)pushLoginViewWith:(int)index;

- (void)greetViewRemove;

@end

@interface GreetViewController : UICollectionViewController
{
    CGPoint dragStartPt;
    bool dragging;
    
    NSMutableDictionary *selectedIdx;
}

@property (weak, nonatomic) id<greetViewRemoveDelegate>delegate;

//登录成功 返回主页
- (void)gotoHomepageWithLogin;

@end
