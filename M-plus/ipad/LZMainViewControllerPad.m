//
//  LZMainViewControllerPad.m
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import "LZMainViewControllerPad.h"

@interface LZMainViewControllerPad ()

@end

@implementation LZMainViewControllerPad

+ (LZMainViewControllerPad *)sharedInstance{
    
    static LZMainViewControllerPad *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
    
}

- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
