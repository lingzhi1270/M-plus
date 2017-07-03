//
//  LZModuleListCellPad.h
//  M-plus
//
//  Created by lingzhi on 2017/7/3.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZModuleInfoPad.h"
@interface LZModuleListCellPad : UITableViewCell
{
    UIImageView *moduleIcon;
    UILabel *moduleNameLabel;
    UIImageView *redIcon;
}

- (void)setModuleListCellValue:(LZModuleInfoPad *)moduleInfo;

- (void)showRedIcon:(BOOL)isShow;

@end
