//
//  LZMainViewControllerPad.h
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZMainViewControllerPad : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *moduleArray;
    UITableView *moduleTableView;
    
    
}

@property (nonatomic,strong)UIButton *avatarBtn;


+ (LZMainViewControllerPad *)sharedInstance;
+ (void)releaseSharedInstance;
@end
