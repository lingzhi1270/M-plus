//
//  LZModuleListCellPad.m
//  M-plus
//
//  Created by lingzhi on 2017/7/3.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import "LZModuleListCellPad.h"
#import "LZUtil.h"

#define ModuleTableWidth 63.0
#define LevelOneVCWidth  350.0
#define LevelTwoVCWidth  (1024 - ModuleTableWidth - LevelOneVCWidth)
#define LevelTwoNaviBarH 65.0
@implementation LZModuleListCellPad

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        CGRect rect = CGRectMake(0, 0, 1, 1);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,[[LZUtil hexStringToColor:@"ff5353"] CGColor]);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        redIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ModuleTableWidth - 20, 5, 7, 7)];
        redIcon.layer.cornerRadius = redIcon.frame.size.height/2;
        redIcon.layer.masksToBounds = YES;
        redIcon.hidden = YES;
        redIcon.image = image;
        [self addSubview:redIcon];
        
        
        moduleIcon = [[UIImageView alloc] initWithFrame:CGRectMake((ModuleTableWidth - 32.0) / 2, 0.0, 32.0, 32.0)];
        moduleIcon.backgroundColor = [UIColor clearColor];
        [self addSubview:moduleIcon];

        // module label
        moduleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake((ModuleTableWidth - 55.0) / 2, 32.0, 55.0, 20.0)];
        moduleNameLabel.backgroundColor = [UIColor clearColor];
        moduleNameLabel.textColor = [UIColor whiteColor];
        moduleNameLabel.textAlignment = NSTextAlignmentCenter;
        moduleNameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:moduleNameLabel];

        
    }
    return self;
    
    
}


- (void)setModuleListCellValue:(LZModuleInfoPad *)moduleInfo;
{
    
    NSString *moduleName = moduleInfo.name;
    moduleNameLabel.text = moduleName;
    NSString *moduleType = moduleInfo.type;
    
    if ([moduleType isEqualToString:@"message"])
    {
        moduleIcon.image = moduleInfo.isSelected ?
        [UIImage imageNamed:@"pad_mplus_menu_message_on"] : [UIImage imageNamed:@"pad_mplus_menu_message"];
    }
    else if ([moduleType isEqualToString:@"contact"])
    {
        moduleIcon.image = moduleInfo.isSelected ?
        [UIImage imageNamed:@"pad_mplus_menu_contact_on"] : [UIImage imageNamed:@"pad_mplus_menu_contact"];
    }
    else if ([moduleType isEqualToString:@"worktable"])
    {
        moduleIcon.image = moduleInfo.isSelected ?
        [UIImage imageNamed:@"pad_mplus_menu_work_on"] : [UIImage imageNamed:@"pad_mplus_menu_work"];
    }
    else if ([moduleType isEqualToString:@"content"])
    {
        moduleIcon.image = moduleInfo.isSelected ?
        [UIImage imageNamed:@"pad_mplus_menu_doc_on"] : [UIImage imageNamed:@"pad_mplus_menu_doc"];
    }
    else if ([moduleType isEqualToString:@"more"])
    {
        moduleIcon.image = moduleInfo.isSelected ?
        [UIImage imageNamed:@"pad_mplus_menu_more_on"] : [UIImage imageNamed:@"pad_mplus_menu_more"];
       
        
    }
}



- (void)showRedIcon:(BOOL)isShow
{
    redIcon.hidden = !isShow;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
