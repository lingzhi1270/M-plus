//
//  AppDelegate.h
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZRootViewController.h"
#import "LZRootViewControllerPad.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#if TARGET_VERSION_TYPE == 1
@property (nonatomic,strong) LZRootViewController *rootViewController;


#else
@property (strong, nonatomic)LZRootViewControllerPad *rootViewControllerPad;

#endif


@end

