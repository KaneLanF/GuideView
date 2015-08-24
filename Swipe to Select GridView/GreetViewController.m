//
//  ExampleViewController.m
//  Swipe to Select GridView
//
//  Created by Philip Yu on 4/18/13.
//  Copyright (c) 2013 Philip Yu. All rights reserved.
//

#import "GreetViewController.h"
#import "UIView+Positioning.h"
#import "GreetLoginView.h"

#define selectedTag 100
#define cellSize 72
#define textLabelHeight 20
#define cellAAcitve 1.0
#define cellADeactive 0.3
#define cellAHidden 0.0
#define defaultFontSize 10.0

#define numOfimg 15

#import "CommentImputView.h"
#import "CUSFlashLabel.h"

@interface GreetViewController ()
{
    NSIndexPath *lastAccessed;
    CUSFlashLabel *flashLabel;
    BOOL m_isNeedStop;
}

@end

@implementation GreetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;
    
    selectedIdx = [[NSMutableDictionary alloc] init];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView setAllowsMultipleSelection:YES];
    
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [self.view addGestureRecognizer:gestureRecognizer];
    [gestureRecognizer setMinimumNumberOfTouches:1];
    [gestureRecognizer setMaximumNumberOfTouches:1];
    
    //循环点亮
    [self performSelector:@selector(flashing) withObject:nil afterDelay:2];
    
    //登录框
    GreetLoginView *loginView = [GreetLoginView shareLoginView];
    loginView.frame = CGRectMake(0, self.view.bounds.size.height - 48,  self.collectionView.bounds.size.width, 48); //6P 55
    loginView.commonLoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    loginView.otherLoginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [loginView.commonLoginBtn addTarget:self action:@selector(commonLogin) forControlEvents:UIControlEventTouchUpInside];
    [loginView.otherLoginBtn addTarget:self action:@selector(otherLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:loginView aboveSubview:self.collectionView];
    
    //跳过Label
    flashLabel = [[CUSFlashLabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 20, 60, 40)];
    flashLabel.text = @"跳过>>";
    flashLabel.font = [UIFont systemFontOfSize:18];
    flashLabel.textColor = [UIColor whiteColor];
    [flashLabel setSpotlightColor:[UIColor redColor]];
    flashLabel.userInteractionEnabled = YES;
    [self.view insertSubview:flashLabel aboveSubview:self.collectionView];
    [flashLabel startAnimating];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoHomepage)];
    [flashLabel addGestureRecognizer:tap];
}

#pragma mark - 循环点亮

- (void)flashing
{
    // 根据Set的特性用随机数循环一下就可以了
    NSMutableSet *randomSet = [NSMutableSet setWithCapacity:3];
    
    while (randomSet.count < 3)
    {
        u_int32_t i = arc4random()%15;
        
        [randomSet addObject:[NSNumber numberWithUnsignedInt:i]];
    }
    NSLog(@"randomSet is %@",randomSet.allObjects);
    int i = 0;
    for (UICollectionViewCell *cell in self.collectionView.visibleCells)
    {
        UICollectionViewCell *mcell = [self.collectionView.visibleCells objectAtIndex:i];
        if ([randomSet.allObjects containsObject:[NSNumber numberWithInt:i]] )
        {
            NSIndexPath *touchOver = [self.collectionView indexPathForCell:mcell];
            
            if (lastAccessed != touchOver)
            {
                if (cell.selected)
                {
//                    [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
                }
                else
                {
                    [self selectCellForCollectionView:self.collectionView atIndexPath:touchOver];
                }
            }
                
        }
        else
        {
            NSIndexPath *touchOver = [self.collectionView indexPathForCell:mcell];
            [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
        }
    
        
        ++i;
    }
    
    if (!m_isNeedStop)
    {
        [self performSelector:@selector(flashing) withObject:nil afterDelay:2];
    }
}

#pragma mark - 按钮响应

//手机号登录
- (void)commonLogin
{
   
}

//第三方登录
- (void)otherLogin
{
   
}

//跳过登录 返回主页
- (void)gotoHomepage
{
    m_isNeedStop = YES;
    [flashLabel stopAnimating];
    [self recoverSet];
    
//    [self.delegate greetViewRemove];
}

- (void)recoverSet
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
}

//登录成功 返回主页
- (void)gotoHomepageWithLogin
{
    m_isNeedStop = YES;
    [flashLabel stopAnimating];
    [self recoverSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -  UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return numOfimg;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *reusableview = nil;
    
    return reusableview;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (![cell viewWithTag:selectedTag])
    {
        UILabel *selected = [[UILabel alloc] initWithFrame:CGRectMake(0, cellSize - textLabelHeight, cellSize, textLabelHeight)];
        selected.backgroundColor = [UIColor darkGrayColor];
        selected.textColor = [UIColor whiteColor];
        selected.text = @"SELECTED";
        selected.textAlignment = NSTextAlignmentCenter;
        selected.font = [UIFont systemFontOfSize:defaultFontSize];
        selected.tag = selectedTag;
        selected.alpha = cellAHidden;
        
        [cell.contentView addSubview:selected];
    }
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"w%ld.png", ([indexPath row] % numOfimg + 1)]]];
    [[cell viewWithTag:selectedTag] setAlpha:cellAHidden];
    cell.backgroundView.alpha = cellADeactive;
    
    // You supposed to highlight the selected cell in here; This is an example
    bool cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    [self setCellSelection:cell selected:cellSelected];
    
    return cell;
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 11)
    {
        //最后一排
        return CGSizeMake([UIScreen mainScreen].bounds.size.width/3.001, ([UIScreen mainScreen].bounds.size.height-48)/5 + 48);
    }
    
    //前面四排
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/3.001, ([UIScreen mainScreen].bounds.size.height-48)/5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}

//-  (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self setCellSelection:cell selected:YES];
    
    [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self setCellSelection:cell selected:NO];
    
    [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
}

- (void) setCellSelection:(UICollectionViewCell *)cell selected:(bool)selected
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve: UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1];
    cell.backgroundView.alpha = selected ? cellAAcitve : cellADeactive;
    [UIView commitAnimations];
    
    /*
    [UIView animateWithDuration:0.6 animations:^(void) {
        cell.backgroundView.alpha = selected ? cellAAcitve : cellADeactive;
//        [cell viewWithTag:selectedTag].alpha = selected ? cellAAcitve : cellAHidden;
    }];
     */
    
//    cell.backgroundView.alpha = selected ? cellAAcitve : cellADeactive;
//    [cell viewWithTag:selectedTag].alpha = selected ? cellAAcitve : cellAHidden;
}

- (void) resetSelectedCells
{
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        [self deselectCellForCollectionView:self.collectionView atIndexPath:[self.collectionView indexPathForCell:cell]];
    }
}

- (void) handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{    
    float pointerX = [gestureRecognizer locationInView:self.collectionView].x;
    float pointerY = [gestureRecognizer locationInView:self.collectionView].y;

    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        float cellSX = cell.frame.origin.x;
        float cellEX = cell.frame.origin.x + cell.frame.size.width;
        float cellSY = cell.frame.origin.y;
        float cellEY = cell.frame.origin.y + cell.frame.size.height;
        
        if (pointerX >= cellSX && pointerX <= cellEX && pointerY >= cellSY && pointerY <= cellEY)
        {
            NSIndexPath *touchOver = [self.collectionView indexPathForCell:cell];
            
            if (lastAccessed != touchOver)
            {
                if (cell.selected)
                    [self deselectCellForCollectionView:self.collectionView atIndexPath:touchOver];
                else
                    [self selectCellForCollectionView:self.collectionView atIndexPath:touchOver];
            }
            
            lastAccessed = touchOver;
        }
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        lastAccessed = nil;
        self.collectionView.scrollEnabled = YES;
    }
    
    
}

- (void) selectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self collectionView:collection didSelectItemAtIndexPath:indexPath];
}

- (void) deselectCellForCollectionView:(UICollectionView *)collection atIndexPath:(NSIndexPath *)indexPath
{
    [collection deselectItemAtIndexPath:indexPath animated:YES];
    [self collectionView:collection didDeselectItemAtIndexPath:indexPath];
}

@end
