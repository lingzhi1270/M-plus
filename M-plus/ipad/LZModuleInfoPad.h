//
//  LZModuleInfoPad.h
//  M-plus
//
//  Created by lingzhi on 2017/7/1.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZModuleInfoPad : NSObject

@property (nonatomic,strong)NSString *alias;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *type;
@property (nonatomic, assign) BOOL   isSelected;

@end
