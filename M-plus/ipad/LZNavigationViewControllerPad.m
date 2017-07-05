//
//  LZNavigationViewControllerPad.m
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import "LZNavigationViewControllerPad.h"

#import "LZMoreViewControllerPad.h"
#import "LZMessageViewControllerPad.h"
#import "LZContactViewControllerPad.h"
#import "LZWorkTableViewControllerPad.h"

#define SCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#define ModuleTableWidth 63.0
#define LevelOneVCWidth  350.0
#define LevelTwoVCWidth  (1024 - ModuleTableWidth - LevelOneVCWidth)
#define LevelTwoNaviBarH 65.0

@interface LZNavigationViewControllerPad ()

@end

@implementation LZNavigationViewControllerPad

@synthesize levelOneVCArray;
@synthesize levelTwoVCArray;
@synthesize curLevelOneVC;
@synthesize lastLevelOneVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        levelOneVCArray = [[NSMutableArray alloc] init];
        levelTwoVCArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - ModuleTableWidth, 748.0)];
    
    self.view = view;
    
    //左上角的圆角效果
    UIRectCorner corners = UIRectCornerTopLeft;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(10.0, 20.0)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = view.bounds;
    maskLayer.path          = maskPath.CGPath;
    view.layer.mask         = maskLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Default page
    UIView *defaultPageView = [[UIView alloc] initWithFrame:CGRectMake(LevelOneVCWidth, 0.0, LevelTwoVCWidth, 748.0)];
    defaultPageView.backgroundColor = [self colorWithRGBHex:0xebebeb];
    [self.view addSubview:defaultPageView];
    
    // logo image view
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake((LevelTwoVCWidth - 420.0) / 2, (748.0 - 180.0 - 20.0) / 2, 420.0, 180.0)];
    logoImageView.backgroundColor = [UIColor clearColor];
    logoImageView.image = [UIImage imageNamed:@"pad_mplus_logo"];
    [defaultPageView addSubview:logoImageView];
}

- (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark-  
/******************************************************************************
 函数名称 : pushLevelOneViewController:withFrame:withModuleInfo:
 函数描述 : 添加指定的一级视图控制器
 输入参数 : LevelOneVCClass frame
 输出参数 : N/A
 返回值  :
 备  注  :
******************************************************************************/

- (void)pushLevelOneViewController:(Class)LevelOneVCClass withFrame:(CGRect)frame withModuleInfo:(LZModuleInfoPad *)moduleInfo
{
    //如果重复点击当前模块，不需要走下边的流程
    if ([curLevelOneVC isKindOfClass:LevelOneVCClass])
    {
       return;

    }
    else
    {
        [self levelOneViewWillDisappearIfNeeded];
    }
    
    BOOL exist = NO;
    
    for (UIViewController *viewController in levelOneVCArray)
    {
        if ([viewController isKindOfClass:LevelOneVCClass])
        {
        
            //这里不需要break，因为要把其他controller的view隐藏掉
            exist = YES;
            viewController.view.hidden = NO;
            [self levelOneViewWillAppearIfNeeded:viewController];
            curLevelOneVC = viewController;
        }
        else
        {
            viewController.view.hidden = YES;
        }
        
    }
    
    if (!exist)
    {
        UIViewController *levelOneVC = [[LevelOneVCClass alloc] init];
        
        if ([levelOneVC isKindOfClass:[LZWorkTableViewControllerPad class]])
        {
            ((LZWorkTableViewControllerPad *)levelOneVC).moduleInfoPad = moduleInfo;
        }
        
        levelOneVC.view.frame = frame;
        [self addChildViewController:levelOneVC];
        [self.view addSubview:levelOneVC.view];
        [self levelOneViewWillAppearIfNeeded:levelOneVC];
        [levelOneVCArray addObject:levelOneVC];
        curLevelOneVC = levelOneVC;
    }
}

- (void)levelOneViewWillAppearIfNeeded:(UIViewController *)levelOneVC
{
    if ([levelOneVC isKindOfClass:[LZMessageViewControllerPad class]])
    {
        [(LZMessageViewControllerPad *)levelOneVC levelOneViewWillAppear];
    }
    else if ([levelOneVC isKindOfClass:[LZWorkTableViewControllerPad class]])
    {
        [(LZContactViewControllerPad *)levelOneVC levelOneViewWillAppear];
    }
    else if ([levelOneVC isKindOfClass:[LZContactViewControllerPad class]])
    {
        [(LZWorkTableViewControllerPad *)levelOneVC levelOneViewWillAppear];
    }
    else if ([levelOneVC isKindOfClass:[LZMoreViewControllerPad class]])
    {
        [(LZMoreViewControllerPad *)levelOneVC levelOneViewWillAppear];
    }

}

- (void)levelOneViewWillDisappearIfNeeded
{
    if (curLevelOneVC)
    {
        if ([curLevelOneVC isKindOfClass:[LZMoreViewControllerPad class]])
        {
            [(LZMoreViewControllerPad *)curLevelOneVC levelOneViewWillDisappear];
        }
    }
}

/******************************************************************************
 函数名称 : pushLevelTwoViewController
 函数描述 : 添加指定的二级视图控制器
 输入参数 : LevelTwoVCClass
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (void)pushLevelTwoViewController:(Class)LevelTwoVCClass
{
    BOOL exist = NO;
    
    for (UIViewController *viewController in levelTwoVCArray)
    {
        if ([viewController isKindOfClass:LevelTwoVCClass])
        {
            //这里不需要break，因为要把其他controller的view隐藏掉
            exist = YES;
            viewController.view.hidden = NO;
        }
        else
        {
            viewController.view.hidden = YES;
            [viewController.view endEditing:YES];
        }
    }
    
    if (!exist)
    {
        UIViewController *levelTwoVC = [[LevelTwoVCClass alloc] init];
        levelTwoVC.view.frame = CGRectMake(LevelOneVCWidth, 0.0, LevelTwoVCWidth, 748.0);;
        [self addChildViewController:levelTwoVC];
        [self.view addSubview:levelTwoVC.view];
        
        [levelTwoVCArray addObject:levelTwoVC];
    }
}

/******************************************************************************
 函数名称 : popLevelTwoViewController
 函数描述 : 移除指定的二级视图控制器
 输入参数 : LevelTwoVCClass
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (void)popLevelTwoViewController:(Class)LevelTwoVCClass
{
    //1. 把当前控制器移除
    for (UIViewController *viewController in levelTwoVCArray)
    {
        if ([viewController isKindOfClass:LevelTwoVCClass])
        {
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
            [levelTwoVCArray removeObject:viewController];
            
            break;
        }
    }
    
    //2. 把其他二级控制器隐藏
    for (UIViewController *viewController in levelTwoVCArray)
    {
        viewController.view.hidden = YES;
    }
}

/******************************************************************************
 函数名称 : showTheSpecificLevelTwoViewController
 函数描述 : 显示指定的二级视图控制器
 输入参数 : LevelTwoVCClass
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (void)showTheSpecificLevelTwoViewController:(Class)LevelTwoVCClass
{
    for (UIViewController *viewController in levelTwoVCArray)
    {
        if ([viewController isKindOfClass:LevelTwoVCClass])
        {
            viewController.view.hidden = NO;
        }
        else
        {
            viewController.view.hidden = YES;
        }
    }
}

/******************************************************************************
 函数名称 : hideAllLevelTwoViewControllers
 函数描述 : 隐藏所有的二级视图控制器
 输入参数 : N/A
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (void)hideAllLevelTwoViewControllers
{
    for (UIViewController *viewController in levelTwoVCArray)
    {
        viewController.view.hidden = YES;
    }
}

/******************************************************************************
 函数名称 : getTheSpecificLevelOneViewController
 函数描述 : 从一级视图控制器数组中取指定的视图控制器
 输入参数 : LevelOneVCClass
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (UIViewController *)getTheSpecificLevelOneViewController:(Class)LevelOneVCClass
{
    UIViewController *resultVC = nil;
    
    for (UIViewController *viewController in levelOneVCArray)
    {
        if ([viewController isKindOfClass:LevelOneVCClass])
        {
            resultVC = viewController;
            break;
        }
    }
    
    return resultVC;
}

/******************************************************************************
 函数名称 : getTheSpecificLevelTwoViewController
 函数描述 : 从二级视图控制器数组中取指定的视图控制器
 输入参数 : LevelTwoVCClass
 输出参数 : N/A
 返回值  :
 备  注  :
 ******************************************************************************/
- (UIViewController *)getTheSpecificLevelTwoViewController:(Class)LevelTwoVCClass
{
    UIViewController *resultVC = nil;
    
    for (UIViewController *viewController in levelTwoVCArray)
    {
        if ([viewController isKindOfClass:LevelTwoVCClass])
        {
            resultVC = viewController;
            break;
        }
    }
    
    return resultVC;
}

@end
