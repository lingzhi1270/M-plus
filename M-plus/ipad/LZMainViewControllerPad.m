//
//  LZMainViewControllerPad.m
//  M-plus
//
//  Created by lingzhi on 2017/6/30.
//  Copyright © 2017年 lingzhi. All rights reserved.
//

#import "LZMainViewControllerPad.h"
#import "LZModuleInfoPad.h"
#import "LZModuleListCellPad.h"

#define RGB(r, g, b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ModuleTableWidth 63.0
#define LevelOneVCWidth  350.0
#define LevelTwoVCWidth  (1024 - ModuleTableWidth - LevelOneVCWidth)
#define LevelTwoNaviBarH 65.0

#define AvatarWidth      52.0
#define NameLabelWidth   55.0


#define SCREEN_WIDTH       [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT      [[UIScreen mainScreen] bounds].size.height
#define SystemVersion      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusBarHeight ((SystemVersion >= 7.0 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)? 20.f : 0.f)

@interface LZMainViewControllerPad (){
    
    NSMutableDictionary *moudleSourceDic;
    
}

@end

@implementation LZMainViewControllerPad

 static LZMainViewControllerPad *instance = nil;

+ (LZMainViewControllerPad *)sharedInstance{
    
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

+ (void)releaseSharedInstance
{
    instance = nil;
}


- (void)loadView{
    UIView *view = nil;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >=7.0)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    }
    else
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    }
    
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    moudleSourceDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    
    self.view.backgroundColor = RGB(85.0, 158.0, 252.0);
    moduleArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self parseModuleListInfo];
    
    _avatarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _avatarBtn.frame = CGRectMake((ModuleTableWidth - AvatarWidth)/ 2, 34.0, AvatarWidth, AvatarWidth);
    _avatarBtn.layer.masksToBounds = YES;
    _avatarBtn.layer.cornerRadius = AvatarWidth/2;
    
    _avatarBtn.backgroundColor = [UIColor whiteColor];
    
    [_avatarBtn addTarget:self action:@selector(avatarBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_avatarBtn];
    
    
    //User name label
    UILabel *userNameLbl = [[UILabel alloc] initWithFrame:
                            CGRectMake((ModuleTableWidth - NameLabelWidth)/2, 89.0, NameLabelWidth, 25.0)];
    [userNameLbl setTextAlignment:NSTextAlignmentCenter];
    [userNameLbl setTextColor:[UIColor whiteColor]];
    [userNameLbl setFont:[UIFont boldSystemFontOfSize:13]];
    [userNameLbl setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:userNameLbl];
    
    
    moduleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200.0, ModuleTableWidth, 480) style:UITableViewStylePlain];
    moduleTableView.backgroundColor = [UIColor clearColor];
    moduleTableView.delegate = self;
    moduleTableView.dataSource = self;
    moduleTableView.scrollEnabled = NO;
    moduleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:moduleTableView];
    
    navigationVC = [[LZNavigationViewControllerPad alloc] init];
    navigationVC.view.frame = CGRectMake(ModuleTableWidth,StatusBarHeight, SCREEN_WIDTH - ModuleTableWidth, 748);
    [self addChildViewController:navigationVC];
    [self.view addSubview:navigationVC.view];
    
    //默认选中第一个模块
    if ([moduleArray count] > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:moduleTableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (void)parseModuleListInfo
{
    //在这里可以通过服务器返回设置pad TabBar的名称
    
    for (NSDictionary *moudleDic in moudleSourceDic) {
        
        LZModuleInfoPad *moduleInfo = [[LZModuleInfoPad alloc] init];
        moduleInfo.alias = [moudleDic objectForKey:@"alias"];
        moduleInfo.title = [moudleDic objectForKey:@"title"];
        moduleInfo.name = [moudleDic objectForKey:@"name"];
        moduleInfo.type = [moudleDic objectForKey:@"type"];
        moduleInfo.isSelected = NO;
        [moduleArray addObject:moduleInfo];
    }
}

- (void)avatarBtnClicked:(id)sender
{
    
}

#pragma mark-
#pragma mark- UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moduleArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LZModuleListCellPad *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[LZModuleListCellPad alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    LZModuleInfoPad *moduleInfo = [moduleArray objectAtIndex:indexPath.row];
    
    //设置左边DOCK
    [cell setModuleListCellValue:moduleInfo];
    
    return cell;
    
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
