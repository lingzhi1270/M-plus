//
//  LZWorkTableViewControllerPad.h
//  M-plus
//
//  Created by lingzhi on 2017/7/3.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZModuleInfoPad.h"
@interface LZWorkTableViewControllerPad : UIViewController

@property (nonatomic, strong) LZModuleInfoPad *moduleInfoPad;

- (void)levelOneViewWillAppear;
@end
