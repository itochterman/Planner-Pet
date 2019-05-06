//
//  HippoMainView.m
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//



#import "HippoMainView.h"
#import "Masonry.h"
#import "HippoBodyStatusView.h"
#import "HippoManager.h"
#import "YYWebImage.h"
//#import "YBPopupMenu.h"

@interface HippoMainView ()<YBPopupMenuDelegate>

@property(nonatomic,strong)UIImageView *hippoBackImageView;
@property (nonatomic,strong)HippoBodyStatusView *hippoBodyView;
@property (nonatomic,copy) void (^enterActionBlock)(void);
@property (nonatomic,assign)SummerOrderStatus type;
//@property (nonatomic,strong)YYAnimatedImageView *titleImageView;
@property (nonatomic,strong)NSMutableArray *runImageAry;
@property (nonatomic,strong)NSMutableArray *jumpImageAry;
@property (nonatomic,strong)NSMutableArray *eatImageAry;
@property (nonatomic,strong)NSMutableArray *handImageAry;
@property (nonatomic,strong)NSMutableArray *shakeYourHeadImageAry;
@property (nonatomic,strong)NSMutableArray *standUpImageAry;
@property (nonatomic,strong)NSMutableArray *walkImageAry;
@property (nonatomic,strong)NSMutableArray *toiletImageAry;
@property (nonatomic,strong)NSMutableArray *cleanImageAry;
@property (nonatomic,strong)NSMutableArray *relaxImageAry;
@property (nonatomic,strong)NSMutableArray *showerImageAry;
//@property (nonatomic,strong)YBPopupMenu *cleanMenu;
@property (nonatomic,assign)NSInteger currentShitNumber;



@property (nonatomic,assign) float mood;
@property (nonatomic,assign) float food;
@property (nonatomic,assign) float exp;
@property (nonatomic,assign) float clean;

//记录前一次
@property (nonatomic,assign) float exMood;
@property (nonatomic,assign) float exFood;
@property (nonatomic,assign) float exExp;
@property (nonatomic,assign) float exClean;
@property(nonatomic,strong)UIImageView *hippoEatToolImageView;
@end
@implementation HippoMainView

- (instancetype)initWithEnterAction:(void(^)(void))enterActionBlock {
    self = [super init];
    if (self) {
        self.exExp = 1;
        self.exFood = 1;
        self.exMood = 1;
        self.exClean = 1;
        [self showLyinyDownAnimation];
        [self summer_setupViews];
        [self summer_bindViewModel];
        [self configDataNormalWithUI];
        [self configNormalData];
        [self configCreateDataTool];
        self.currentShitNumber = 0;
        self.enterActionBlock = enterActionBlock;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self summer_setupViews];
        [self summer_bindViewModel];
        
        [self configCreateDataTool];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self summer_setupViews];
        [self summer_bindViewModel];
    }
    return self;
}

//展现趴着的动画
- (void)showLyinyDownAnimation
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self configClickHippoAnimation:[self.relaxImageAry copy] andDurationTime:3.0 andRepeatCount:1];
    });
}

- (void)updateConstraints {
    [super updateConstraints];
}
- (void)summer_bindViewModel {
    
}

- (void)summer_setupViews {
    
    self.backgroundColor = [UIColor clearColor];
    __weak typeof(self) weakSelf = self;
//    [self addSubview:self.hippoBackImageView];
//
//    [self.hippoBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.mas_centerY);
//        make.centerX.equalTo(weakSelf.mas_centerX);
//        make.height.mas_equalTo(STSizeWithWidth(240.0));
//        make.width.mas_equalTo(STSizeWithWidth(240.0));
//    }];
    [self addSubview:self.hippoBackImageView];
    
    [self.hippoBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(STSizeWithWidth(200.0));
        make.width.mas_equalTo(STSizeWithWidth(300.0));
    }];
    [self.hippoBackImageView layoutIfNeeded];
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSingleDid:)];
    tapSingle.numberOfTapsRequired = 1;
    tapSingle.numberOfTouchesRequired = 1;
    

    UITapGestureRecognizer *tapHoippoDouble = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDoubleDid:)];
    tapHoippoDouble.numberOfTapsRequired = 2;
    tapHoippoDouble.numberOfTouchesRequired = 1;

    [tapSingle requireGestureRecognizerToFail:tapHoippoDouble];
    
//    [self.hippoBackImageView addGestureRecognizer:tapSingle];
//    [self.hippoBackImageView addGestureRecognizer:tapHoippoDouble];
    [self.hippoBackImageView addGestureRecognizer:tapSingle];
    [self.hippoBackImageView addGestureRecognizer:tapHoippoDouble];
    
}

- (void)tapSingleDid:(UITapGestureRecognizer *)tapGesture {
    
    CGPoint ponit = [tapGesture locationInView:self.hippoBackImageView];
    if ([tapGesture.view isEqual:self.hippoBackImageView]) {
        switch (self.type) {
            case ACTIVE:

                [self configSingeTapWithPoint:ponit];
                break;
            case GETDOWN:

                self.type = ACTIVE;
                [[HippoManager shareInstance] configStandUpChangeTime];
                [self configClickHippoAnimation:[self.standUpImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                [self configDataWithUI:self.type];
                break;
            case GETDOWNSHIT:

                self.type = ACTIVESHIT;
                [[HippoManager shareInstance] configStandUpChangeTime];
                [self configClickHippoAnimation:[self.standUpImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                [self configDataWithUI:self.type];
                break;
            case ACTIVESHIT:

                [self configSingeTapWithPoint:ponit];
                break;
                
            default:
                break;
        }
    }
}

- (void)tapDoubleDid:(UITapGestureRecognizer *)tapGesture {
    
    if ([tapGesture.view isEqual:self.hippoBackImageView]) {
        switch (self.type) {
            case ACTIVE:
    
                [self configPushMnue];
                break;
            case GETDOWN:

                self.type = ACTIVE;
                [[HippoManager shareInstance] configStandUpChangeTime];
                [self configClickHippoAnimation:[self.standUpImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                [self configDataWithUI:self.type];
                break;
            case GETDOWNSHIT:

                self.type = ACTIVESHIT;
                [[HippoManager shareInstance] configStandUpChangeTime];
                [self configClickHippoAnimation:[self.standUpImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                [self configDataWithUI:self.type];
                break;
            case ACTIVESHIT:
 
                [self configPushMnue];
                break;
            default:
                break;
        }
    }
}


- (void)configSingeTapWithPoint:(CGPoint)point {
    
    if (((STSizeWithWidth(150.0) - STSizeWithWidth(50.0) < point.x) && (point.x < STSizeWithWidth(150.0) + STSizeWithWidth(50.0))) && (STSizeWithWidth(150.0) < point.y) && (point.y < STSizeWithWidth(200.0))) {

        [self configClickHippoAnimation:[self.handImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
    } else if ((0 < point.x) && (point.x < STSizeWithWidth(150.0)) && (0 < point.y) && (point.y < STSizeWithWidth(100.0))) {

        [self configClickHippoAnimation:[self.shakeYourHeadImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
    } else if (((STSizeWithWidth(150.0) + STSizeWithWidth(50.0)) < point.x) && (point.x < STSizeWithWidth(300.0)) && (STSizeWithWidth(110.0) < point.y) && (point.y < STSizeWithWidth(200.0))) {

        [self configClickHippoAnimation:[self.runImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
    } else if (((STSizeWithWidth(150.0) + STSizeWithWidth(50.0)) < point.x) && (point.x < STSizeWithWidth(300.0)) && (STSizeWithWidth(50.0) < point.y) && (point.y < STSizeWithWidth(110.0))) {

        [self configClickHippoAnimation:[self.jumpImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
    }else if (((STSizeWithWidth(150.0) - STSizeWithWidth(50.0) < point.x) && (point.x < STSizeWithWidth(150.0) + STSizeWithWidth(50.0))) && (0 < point.y) && (point.y < STSizeWithWidth(100.0))) {

        [self configClickHippoAnimation:[self.walkImageAry copy] andDurationTime:6.0 andRepeatCount:1.0];
    }
    
    
}


- (void)configClickHippoAnimation:(NSArray *)imageAry andDurationTime:(NSTimeInterval)time andRepeatCount:(NSInteger)number {

    if (!self.hippoBackImageView.isAnimating) {
        
        [self.hippoBackImageView setAnimationImages:imageAry];
        
        [self.hippoBackImageView setAnimationDuration:time];
        
        self.hippoBackImageView.animationRepeatCount = number;
        
        [self.hippoBackImageView startAnimating];
    }
    
}


- (void)configDataNormalWithUI {
    SummerOrderStatus type =  [[HippoManager shareInstance] configDataNormalWithUI];
    [self configDataWithUI:type];
}

- (void)configNormalData {
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];
    float moodNumber = model.mood;
    float foodNumber = model.food;
    float expNumber = model.exp;
    float cleanNumber = model.clean;
    self.mood = moodNumber;
    self.food = foodNumber;
    self.exp = expNumber;
    self.clean = cleanNumber;
}
#pragma mark - 基本推出方法
- (void)configPushMnue {
    if ([self.subviews containsObject:self.hippoBodyView]) {

        [self configChangeUiNormalWithCenterImage];
        [self.hippoBodyView removeFromSuperview];
    } else {
        [UIView animateWithDuration:3.0 animations:^{
            [self configChangeUiSelectWithCenterImage];
            [self addSubview:self.hippoBodyView];
            __weak typeof(self) weakSelf = self;
            [self.hippoBodyView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(weakSelf.mas_right);
                make.centerY.equalTo(weakSelf.mas_centerY);
                make.height.mas_equalTo(STSizeWithWidth(400.0));
                make.width.mas_equalTo(STSizeWithWidth(260.0));
            }];
        }];
    }
}

- (void)configChangeUiSelectWithCenterImage {
    __weak typeof(self) weakSelf = self;
    [self.hippoBackImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX).offset(-STSizeWithWidth(130.0));
        make.height.mas_equalTo(STSizeWithWidth(200.0));
        make.width.mas_equalTo(STSizeWithWidth(300.0));
    }];
    [self.hippoBackImageView layoutIfNeeded];
    
    [self eatToolNormal];
}
- (void)configChangeUiNormalWithCenterImage {
    __weak typeof(self) weakSelf = self;
    [self.hippoBackImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(STSizeWithWidth(200.0));
        make.width.mas_equalTo(STSizeWithWidth(300.0));
    }];
    [self.hippoBackImageView layoutIfNeeded];
    [self eatToolNormal];
}

- (void)eatToolNormal {
    if ([[self subviews]containsObject:self.hippoEatToolImageView]) {
        __weak typeof(self) weakSelf = self;
        [self.hippoEatToolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.hippoBackImageView.mas_left).offset(STSizeWithWidth(60));
            make.bottom.equalTo(weakSelf.hippoBackImageView.mas_top);
            make.height.mas_equalTo(STSizeWithWidth(40));
            make.width.mas_equalTo(STSizeWithWidth(40));
        }];
        [self.hippoEatToolImageView layoutIfNeeded];
    }
}

- (void)configWithChangeFood:(float)food {
    __weak __typeof(self) weakSelf = self;
    [[HippoManager shareInstance] configDataWithAddFood:food foodSuccess:^(float mood, float food, float exp,float clean) {
        if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
            [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
        }
    }];
}


- (void)configWithChangeMood:(float)mood {
    __weak __typeof(self) weakSelf = self;
    [[HippoManager shareInstance] configDataWithAddMood:mood moodSuccess:^(float mood, float food, float exp,float clean) {
        if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
            
            [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
            [weakSelf configClickHippoAnimation:[weakSelf.relaxImageAry copy] andDurationTime:3.0 andRepeatCount:1];
        }
        
    }];
    [self configDataNormalWithUI];
}

- (void)configWithChangeFood:(float)mood andClean:(float)clean {
    __weak __typeof(self) weakSelf = self;
    [[HippoManager shareInstance] configDataWithAddFood:mood andClean:clean moodSuccess:^(float mood, float food, float exp, float clean) {
        if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
            
            [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
        }
    }];
    [self configDataNormalWithUI];
}
- (void)configWithChangeExp:(float)exp {
    __weak __typeof(self) weakSelf = self;
    [[HippoManager shareInstance] configDataWithExp:exp Success:^(float mood, float food, float exp, float clean) {
        if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
            
            [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
        }
    }];
    [self configDataNormalWithUI];
}

- (void)configDataWithUI:(SummerOrderStatus)type {
    self.type = type;
    switch (self.type) {
        case ACTIVE:
            self.hippoBackImageView.image = [UIImage imageNamed:@"hippoImageView"];
            break;
        case GETDOWN:
            self.hippoBackImageView.image = [UIImage imageNamed:@"hippoImageView"];
            break;
        case GETDOWNSHIT:

            self.hippoBackImageView.image = [UIImage imageNamed:@"hippoImageView"];
            break;
        case ACTIVESHIT:

            self.hippoBackImageView.image = [UIImage imageNamed:@"hippoImageView"];
            break;
        default:
            break;
    }
}

//这里是每秒会调用一次，用于监听exp、mood、clean、food的数值变化
- (void)configCreateDataTool {
    
    __weak __typeof(self) weakSelf = self;
    [[HippoManager shareInstance] configDataWithGcdTimerSuccess:^(float mood, float food, float exp,float clean,NSInteger shitNumber) {
        
        if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
            [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
        }
        NSLog(@"shitNumber---%ld",shitNumber);
        
        weakSelf.mood = mood;
        weakSelf.food = food;
        weakSelf.exp = exp;
        weakSelf.clean = clean;
        
        SummerOrderStatus type =  [[HippoManager shareInstance] configDataNormalWithUI];
        if (weakSelf.type != type) {
            [weakSelf configDataWithUI:type];
        }
        
        if (exp < HippoRedLine) {
            
            [weakSelf addSubview:weakSelf.hippoEatToolImageView];
        } else {
            
            [weakSelf.hippoEatToolImageView removeFromSuperview];
        }
        [weakSelf eatToolNormal];
        
        if (weakSelf.currentShitNumber != shitNumber && shitNumber > 0) {
            weakSelf.currentShitNumber = shitNumber;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf configClickHippoAnimation:[weakSelf.toiletImageAry copy] andDurationTime:4.0 andRepeatCount:1];
                [weakSelf.popupMenu dismiss];
                if (weakSelf.isCanShow) {
                    weakSelf.popupMenu = [YBPopupMenu showRelyOnView:self.hippoBackImageView titles:@[@"Clean, Clean, Clean!!! 💩"] icons:nil menuWidth:self.hippoBackImageView.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
                        popupMenu.delegate = self;
                        popupMenu.showMaskView = NO;
                        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
                        popupMenu.maxVisibleCount = 1;
                        popupMenu.itemHeight = 45;
                        popupMenu.borderWidth = 1;
                        popupMenu.fontSize = 12;
                        popupMenu.dismissOnTouchOutside = YES;
                        popupMenu.dismissOnSelected = NO;
                        popupMenu.borderColor = [UIColor brownColor];
                        popupMenu.textColor = [UIColor brownColor];
                    }];
                
                }
                
            });
            return;
        }
        
        //这里没个数值都用了一个ex开头的变量，是用来控制显示一次，不要频繁显示气泡
        if (exp < 0.5 && weakSelf.exExp >= 0.5 && !weakSelf.hippoBackImageView.isAnimating) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.popupMenu dismiss];
                weakSelf.popupMenu = [YBPopupMenu showRelyOnView:self.hippoBackImageView titles:@[@"Hungryyyyy!!! 🍞"] icons:nil menuWidth:self.hippoBackImageView.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
                    popupMenu.delegate = self;
                    popupMenu.showMaskView = NO;
                    popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
                    popupMenu.maxVisibleCount = 1;
                    popupMenu.itemHeight = 45;
                    popupMenu.borderWidth = 1;
                    popupMenu.fontSize = 12;
                    popupMenu.dismissOnTouchOutside = YES;
                    popupMenu.dismissOnSelected = NO;
                    popupMenu.borderColor = [UIColor brownColor];
                    popupMenu.textColor = [UIColor brownColor];
                }];
                weakSelf.exExp = exp;
            });
            return;
        }
//        if (clean < 0.5 && weakSelf.exClean >= 0.5 && !weakSelf.hippoBackImageView.isAnimating) {
//            [weakSelf configClickHippoAnimation:[weakSelf.toiletImageAry copy] andDurationTime:4.0 andRepeatCount:1];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.popupMenu dismiss];
//                weakSelf.popupMenu = [YBPopupMenu showRelyOnView:self.hippoBackImageView titles:@[@"Clean, Clean, Clean!!! 💩"] icons:nil menuWidth:self.hippoBackImageView.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
//                    popupMenu.delegate = self;
//                    popupMenu.showMaskView = NO;
//                    popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
//                    popupMenu.maxVisibleCount = 1;
//                    popupMenu.itemHeight = 45;
//                    popupMenu.borderWidth = 1;
//                    popupMenu.fontSize = 12;
//                    popupMenu.dismissOnTouchOutside = YES;
//                    popupMenu.dismissOnSelected = NO;
//                    popupMenu.borderColor = [UIColor brownColor];
//                    popupMenu.textColor = [UIColor brownColor];
//                }];
//            });
//            weakSelf.exClean = clean;
//            return;
//        }

        if (mood<0.5 && weakSelf.exMood >= 0.5 && !weakSelf.hippoBackImageView.isAnimating) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.popupMenu dismiss];
                weakSelf.popupMenu = [YBPopupMenu showRelyOnView:self.hippoBackImageView titles:@[@"Play with me... 😔"] icons:nil menuWidth:self.hippoBackImageView.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
                    popupMenu.delegate = self;
                    popupMenu.showMaskView = NO;
                    popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
                    popupMenu.maxVisibleCount = 1;
                    popupMenu.itemHeight = 45;
                    popupMenu.borderWidth = 1;
                    popupMenu.fontSize = 12;
                    popupMenu.dismissOnTouchOutside = YES;
                    popupMenu.dismissOnSelected = NO;
                    popupMenu.borderColor = [UIColor brownColor];
                    popupMenu.textColor = [UIColor brownColor];
                }];
            });
            weakSelf.exMood = mood;
            return;
        }
        
    }];
    
}
- (void)configBodyStatusAction:(NSInteger)tag {
    switch (tag) {
        case 10://点击游戏
        {
//            if (self.exp >= HippoRedLine) {
//
//
//            }
            if (self.enterActionBlock != nil) {
                self.enterActionBlock();
            }
            
            break;
        }
        case 20://点击清洁
        {
            bool isSelect = YES;
            if (isSelect) {
                isSelect = NO;
                __weak __typeof(self) weakSelf = self;
                
                if (weakSelf.clean >= 0.95) {
                    [SVProgressHUD showInfoWithStatus:@"Already very clean"];
                    [SVProgressHUD dismissWithDelay:1.0];
                    [weakSelf configClickHippoAnimation:[weakSelf.shakeYourHeadImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                }else{
                    if (weakSelf.exp < HippoUnit*1) {
                        [SVProgressHUD showErrorWithStatus:@"exp not enough"];
                        [SVProgressHUD dismissWithDelay:1.0];
                    }else{
                        [[HippoManager shareInstance] configDataWithClearShitSuccess:^(float mood, float food, float exp,float clean) {
                            [weakSelf.popupMenu dismiss];
                            if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
                                [weakSelf configClickHippoAnimation:[weakSelf.cleanImageAry copy] andDurationTime:2.0 andRepeatCount:1];
                                [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
                            }
                        }];
                    }
                    
                }
                
                isSelect = YES;
            }
            break;
        }
        case 999://click shower 点击洗澡
        {
            bool isSelect = YES;
            if (isSelect) {
                isSelect = NO;
                __weak __typeof(self) weakSelf = self;
                if (weakSelf.clean >= 0.98) {
                    [SVProgressHUD showInfoWithStatus:@"I am a CLEAN little cute hippo, NO extra showering, so we save water!!!"];
                    [SVProgressHUD dismissWithDelay:1.0];
//                    [weakSelf configClickHippoAnimation:[weakSelf.showerImageAry copy] andDurationTime:6.0 andRepeatCount:1.0];
                }else{
                    if (weakSelf.exp < HippoUnit*1) {
                        [SVProgressHUD showErrorWithStatus:@"exp not enough"];
                        [SVProgressHUD dismissWithDelay:1.0];
                    }else{
                        [[HippoManager shareInstance] takeShowerSuccess:^(float mood, float food, float exp,float clean) {
                            [weakSelf.popupMenu dismiss];
                            if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
                                [weakSelf configClickHippoAnimation:[weakSelf.showerImageAry copy] andDurationTime:2.0 andRepeatCount:1];
                                [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
                            }
                        }];
                    }
                    
                }
                
                isSelect = YES;
            }
        }

            break;
        case 40:

        {
        }
            break;
        case 50://click food 点击食物
        {

            bool isSelect = YES;
            if (isSelect) {
                isSelect = NO;
                __weak __typeof(self) weakSelf = self;
                if (weakSelf.exp >= 0.98) {
                    [SVProgressHUD showInfoWithStatus:@"exp is enough"];
                    [SVProgressHUD dismissWithDelay:1.0];
                    [weakSelf configClickHippoAnimation:[weakSelf.shakeYourHeadImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                }else{
                    if (weakSelf.food < HippoUnit * 3) {
                        [SVProgressHUD showInfoWithStatus:@"food not enough"];
                        [SVProgressHUD dismissWithDelay:1.0];
                    }else{
                        [[HippoManager shareInstance] configDataWithEatSuccess:^(float mood, float food, float exp,float clean) {
                            if ([weakSelf.subviews containsObject:weakSelf.hippoBodyView]) {
                                [weakSelf configClickHippoAnimation:[weakSelf.eatImageAry copy] andDurationTime:3.0 andRepeatCount:1.0];
                                [weakSelf.hippoBodyView configChangeUIWithData:mood andExpNumber:exp andFoodNumber:food andCleanNumber:clean];
                            }
                        } eatFailure:^{
                            
                            
                        }];
                    }
                }
                
                isSelect = YES;
                [[HippoManager shareInstance] configDataWithGifWoth:5.0 timerSuccess:^{
                    [self.popupMenu dismiss];
                }];
            }
            break;
        }
        case 60://click clean
            
            NSLog(@"CLEAN CLICKED ld");
            
            break;
        default:
            break;
    }
}

#pragma mark - get
- (UIImageView *)hippoBackImageView {
    if (!_hippoBackImageView) {
        _hippoBackImageView = [[UIImageView alloc]init];
        [_hippoBackImageView setUserInteractionEnabled:YES];
    }
    return _hippoBackImageView;
}

- (HippoBodyStatusView *)hippoBodyView {
    if (!_hippoBodyView) {
        __weak typeof(self) weakSelf = self;
        _hippoBodyView = [[HippoBodyStatusView alloc]initWithMood:self.mood andExp:self.exp andFood:self.food andClean:self.clean enterAction:^(NSInteger tag) {
            [weakSelf configBodyStatusAction:tag];
        }];
    }
    return _hippoBodyView;
}
- (UIImageView *)hippoEatToolImageView {
    if (!_hippoEatToolImageView) {
        _hippoEatToolImageView = [[UIImageView alloc]init];
        
//        _hippoEatToolImageView.image = [UIImage imageNamed:@"eatTool"];
    }
    return _hippoEatToolImageView;
}
//- (YYAnimatedImageView *)titleImageView {
//    if (!_titleImageView) {
//        _titleImageView = [[YYAnimatedImageView alloc]init];
//        [_titleImageView setUserInteractionEnabled:YES];
//    }
//    return _titleImageView;
//}

- (NSMutableArray *)showerImageAry {
    if (!_showerImageAry) {
        _showerImageAry = [NSMutableArray array];
        for (int i = 1; i < 71; i++) {
            NSString *imageText = [NSString stringWithFormat:@"shower00%d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_showerImageAry addObject:image];
        }
    }
    return _showerImageAry;
}

- (NSMutableArray *)runImageAry {
    if (!_runImageAry) {
        _runImageAry = [NSMutableArray array];
        for (int i = 1; i < 61; i++) {
            NSString *imageText = [NSString stringWithFormat:@"run00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_runImageAry addObject:image];
        }
    }
    return _runImageAry;
}
- (NSMutableArray *)jumpImageAry {
    if (!_jumpImageAry) {
        _jumpImageAry = [NSMutableArray array];
        for (int i = 1; i < 41; i++) {
            NSString *imageText = [NSString stringWithFormat:@"jump00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_jumpImageAry addObject:image];
        }
    }
    return _jumpImageAry;
}
- (NSMutableArray *)eatImageAry {
    if (!_eatImageAry) {
        _eatImageAry = [NSMutableArray array];
        for (int i = 1; i < 51; i++) {
            NSString *imageText = [NSString stringWithFormat:@"eat00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_eatImageAry addObject:image];
        }
    }
    return _eatImageAry;
}
- (NSMutableArray *)handImageAry {
    if (!_handImageAry) {
        _handImageAry = [NSMutableArray array];
        for (int i = 1; i < 36; i++) {
            NSString *imageText = [NSString stringWithFormat:@"hand00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_handImageAry addObject:image];
        }
    }
    return _handImageAry;
}
- (NSMutableArray *)shakeYourHeadImageAry {
    if (!_shakeYourHeadImageAry) {
        _shakeYourHeadImageAry = [NSMutableArray array];
        for (int i = 1; i < 71; i++) {
            NSString *imageText = [NSString stringWithFormat:@"shakeYourHead00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_shakeYourHeadImageAry addObject:image];
        }
    }
    return _shakeYourHeadImageAry;
}
- (NSMutableArray *)standUpImageAry {
    if (!_standUpImageAry) {
        _standUpImageAry = [NSMutableArray array];
        for (int i = 1; i < 63; i++) {
            NSString *imageText = [NSString stringWithFormat:@"standUp00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_standUpImageAry addObject:image];
        }
    }
    return _standUpImageAry;
}
- (NSMutableArray *)walkImageAry {
    if (!_walkImageAry) {
        _walkImageAry = [NSMutableArray array];
        for (int i = 1; i < 91; i++) {
            NSString *imageText = [NSString stringWithFormat:@"walk00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_walkImageAry addObject:image];
        }
    }
    return _walkImageAry;
}
- (NSMutableArray *)toiletImageAry {
    if (!_toiletImageAry) {
        _toiletImageAry = [NSMutableArray array];
        for (int i = 1; i < 46; i++) {
            NSString *imageText = [NSString stringWithFormat:@"toilet00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_toiletImageAry addObject:image];
        }
    }
    return _toiletImageAry;
}
- (NSMutableArray *)cleanImageAry {
    if (!_cleanImageAry) {
        _cleanImageAry = [NSMutableArray array];
        for (int i = 1; i < 35; i++) {
            NSString *imageText = [NSString stringWithFormat:@"clean00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_cleanImageAry addObject:image];
        }
    }
    return _cleanImageAry;
}
- (NSMutableArray *)relaxImageAry {
    if (!_relaxImageAry) {
        _relaxImageAry = [NSMutableArray array];
        for (int i = 1; i < 51; i++) {
            NSString *imageText = [NSString stringWithFormat:@"relax00%02d",i];
            UIImage *image = [UIImage imageNamed:imageText];
            [_relaxImageAry addObject:image];
        }
    }
    return _relaxImageAry;
}
#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    [ybPopupMenu dismiss];
}
@end
