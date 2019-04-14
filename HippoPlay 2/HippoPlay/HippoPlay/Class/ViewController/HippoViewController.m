//
//  HippoViewController.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/12.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import "HippoViewController.h"
#import "HippoMainView.h"
#import "HippoBodyStatusView.h"
#import "HippoModel+CoreDataProperties.h"


@interface HippoViewController ()
@property (nonatomic,strong)HippoMainView *hippoMianView;
@property (nonatomic,strong)HippoBodyStatusView *hippoBodyView;
@end

@implementation HippoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Hippo";
    [self configUI];
    HippoModel *model = [[HippoToolManager shareInstance] readData];
    if (model == nil) {
        //不存在了
        [[HippoToolManager shareInstance] createSqlite];
        [[HippoToolManager shareInstance] insertDataId:@"1" actionTime:[[HippoToolManager shareInstance] getCurrentTiem] changeExpTime:[[HippoToolManager shareInstance] getCurrentTiem] changeMoodTime:[[HippoToolManager shareInstance] getCurrentTiem] food:1.0 exp:1.0 mood:1.0 shitNumber:1.0 downStatus:@"0" changeShitTime:[[HippoToolManager shareInstance] getCurrentTiem]];
        
    }
    GCDTimer *gcdTimer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [gcdTimer event:^{
        NSLog(@"1");
    } timeInterval:NSEC_PER_SEC * 1.0 delay:10];
    [gcdTimer start];
    
}


- (void)configUI {
    
//    self.edgesForExtendedLayout = [];
//    self.navigationController?.navigationBar.isTranslucent = false
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.view addSubview:self.hippoMianView];
    __weak typeof(self) weakSelf = self;
    [self.hippoMianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-STSizeWithWidth(30.0));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(STSizeWithWidth(300.0));
        make.width.mas_equalTo(STSizeWithWidth(300.0));
        
    }];
}
#pragma mark - 基本推出方法
- (void)configPushMnue {
    [self.view addSubview:self.hippoBodyView];
    __weak typeof(self) weakSelf = self;
    [self.hippoBodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.top.equalTo(weakSelf.view.mas_top).offset(STSizeWithWidth(60.0));
        make.height.mas_equalTo(STSizeWithWidth(440.0));
        make.width.mas_equalTo(STSizeWithWidth(300.0));
    }];
}

- (void)configBodyStatusAction:(NSInteger)tag {
    switch (tag) {
        case 10:
            NSLog(@"玩游戏");
            [self.hippoBodyView configChangeUIWithData:0.8 andExpNumber:0.4 andFoodNumber:0.0];
            break;
        case 20:
            NSLog(@"清理便便");
            break;
        case 30:
            NSLog(@"心情");
            break;
        case 40:
            NSLog(@"饱程度");
            break;
        case 50:
            NSLog(@"喂食");
            break;
        default:
            break;
    }
}
- (void)configDataWithModel {
    
}


#pragma mark - get
- (HippoMainView *)hippoMianView {
    if (!_hippoMianView) {
        __weak typeof(self) weakSelf = self;
        _hippoMianView = [[HippoMainView alloc]initWithtype:ACTIVE enterAction:^{
            [weakSelf configPushMnue];
        }];
    }
    return _hippoMianView;
}

- (HippoBodyStatusView *)hippoBodyView {
    if (!_hippoBodyView) {
        __weak typeof(self) weakSelf = self;
        _hippoBodyView = [[HippoBodyStatusView alloc]initWithMood:1.0 andExp:1.0 andFood:1.0 enterAction:^(NSInteger tag) {
            [weakSelf configBodyStatusAction:tag];
        }];
    }
    return _hippoBodyView;
}
@end
