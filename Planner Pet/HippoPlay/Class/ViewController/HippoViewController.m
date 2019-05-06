//
//  HippoViewController.m
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import "HippoViewController.h"
#import "HippoMainView.h"
#import "Planner_Pet-Swift.h"
//#import "HippoBodyStatusView.h"
//#import "HippoModel+CoreDataProperties.h"
//#import "HippoManager.h"

@interface HippoViewController () <GameViewControllerDelegate,GameFlyViewControllerDelegate>
@property (nonatomic,strong)HippoMainView *hippoMianView;
//@property (nonatomic,strong)HippoBodyStatusView *hippoBodyView;
//@property (nonatomic, strong) GCDTimer  *gcdTimer;
@end

@implementation HippoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    [self configUI];
//    HippoModel *model = [[HippoToolManager shareInstance] readData];
//    if (model == nil) {
//        //不存在了
//        [[HippoToolManager shareInstance] createSqlite];
//        [[HippoToolManager shareInstance] insertDataId:@"1" actionTime:[[HippoToolManager shareInstance] getCurrentTiem] changeExpTime:[[HippoToolManager shareInstance] getCurrentTiem] changeMoodTime:[[HippoToolManager shareInstance] getCurrentTiem] food:1.0 exp:1.0 mood:1.0 shitNumber:1.0 downStatus:@"0" changeShitTime:[[HippoToolManager shareInstance] getCurrentTiem]];
//
//    }
//    [[HippoManager shareInstance] createSqlite];
//    __weak __typeof(self) weakSelf = self;
//    [[HippoManager shareInstance] configDataWithGcdTimerSuccess:^(float mood, float food, float exp) {
//        [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food];
//    }];
//    [self configDataWithGcdTimer];
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    
//    CurrentAppDelegate.allowAcrolls = YES;
//    [self orientationToPortrait:UIInterfaceOrientationLandscapeLeft];
//}
//
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    CurrentAppDelegate.allowAcrolls = NO;
//    [self orientationToPortrait:UIInterfaceOrientationPortrait];
//}

#pragma mark - GCDTimer
//- (void)configDataWithGcdTimer {
//    __weak __typeof(self) weakSelf = self;
//    self.gcdTimer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
//    [self.gcdTimer event:^{
//        //
//        [weakSelf configDataWithModel:[[HippoToolManager shareInstance] getCurrentTiem]];
//
//    } timeInterval:NSEC_PER_SEC * 1.0];
//
//    [self.gcdTimer start];
//}


- (void)configUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.view addSubview:self.hippoMianView];
    __weak typeof(self) weakSelf = self;
    [self.hippoMianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-STSizeWithWidth(30.0));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(STSizeWithWidth(500.0));
        make.width.mas_equalTo(STSizeWithWidth(600.0));
        
    }];
}
- (void)configHippoPlayGame {
    
    GameViewController *gameVC = [[GameViewController alloc]init];
    gameVC.delegate = self;
    [self presentViewController:gameVC animated:YES completion:nil];
}


#pragma mark - GameViewControllerDelegate
- (void)playGameSuccess {
    [self.hippoMianView configWithChangeMood:0.1];
}
- (void)playFlyGameSuccess {
    [self.hippoMianView configWithChangeMood:0.1];
}

#pragma mark - get
- (HippoMainView *)hippoMianView {
    if (!_hippoMianView) {
        __weak typeof(self) weakSelf = self;
        _hippoMianView = [[HippoMainView alloc]initWithEnterAction:^{
            [weakSelf configHippoPlayGame];
        }];
    }
    return _hippoMianView;
}

//- (HippoBodyStatusView *)hippoBodyView {
//    if (!_hippoBodyView) {
//        __weak typeof(self) weakSelf = self;
//        _hippoBodyView = [[HippoBodyStatusView alloc]initWithMood:1.0 andExp:1.0 andFood:1.0 enterAction:^(NSInteger tag) {
//            [weakSelf configBodyStatusAction:tag];
//        }];
//    }
//    return _hippoBodyView;
//}

- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}



@end
