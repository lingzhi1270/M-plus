//
//  LZNavigationViewControllerPad.h
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZModuleInfoPad.h"

@interface LZNavigationViewControllerPad : UIViewController
{
    NSMutableArray *levelOneVCArray;//一级视图控制器数组
    NSMutableArray *levelTwoVCArray;//二级视图控制器数组

}
@property (nonatomic, strong)NSMutableArray *levelOneVCArray;
@property (nonatomic, strong)NSMutableArray *levelTwoVCArray;
@property (nonatomic, strong) UIViewController *curLevelOneVC;
@property (nonatomic, strong) UIViewController *lastLevelOneVC;

- (void)pushLevelOneViewController:(Class)LevelOneVCClass
                         withFrame:(CGRect)frame
                    withModuleInfo:(LZModuleInfoPad *)moduleInfo;
- (void)pushLevelTwoViewController:(Class)LevelTwoVCClass;
- (void)popLevelTwoViewController:(Class)LevelTwoVCClass;
- (void)showTheSpecificLevelTwoViewController:(Class)LevelTwoVCClass;
- (void)hideAllLevelTwoViewControllers;
- (UIViewController *)getTheSpecificLevelOneViewController:(Class)LevelOneVCClass;
- (UIViewController *)getTheSpecificLevelTwoViewController:(Class)LevelTwoVCClass;
- (void)levelOneViewWillAppearIfNeeded:(UIViewController *)levelOneVC;
- (void)levelOneViewWillDisappearIfNeeded;

@end
