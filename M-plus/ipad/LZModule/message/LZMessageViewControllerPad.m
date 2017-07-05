//
//  LZMessageViewController.m
//  M-plus
//
//  Created by lingzhi on 2017/7/3.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import "LZMessageViewControllerPad.h"
#define ModuleTableWidth 63.0
#define LevelOneVCWidth  350.0
#define LevelTwoVCWidth  (1024 - ModuleTableWidth - LevelOneVCWidth)
#define LevelTwoNaviBarH 65.0
@interface LZMessageViewControllerPad ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *messageTableView;

@end

@implementation LZMessageViewControllerPad


//懒加载
- (UITableView *)messageTableView
{
    if (_messageTableView == nil) {
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LevelOneVCWidth, 748) style:UITableViewStylePlain];
        
        _messageTableView.showsHorizontalScrollIndicator = NO;
        _messageTableView.showsVerticalScrollIndicator = NO;
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        
    }
    return _messageTableView;
}

- (void)levelOneViewWillAppear
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.messageTableView];
}

#pragma mark- 
#pragma mark- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    return cell;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
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
