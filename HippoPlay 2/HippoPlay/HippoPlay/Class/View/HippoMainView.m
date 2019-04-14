//
//  HippoMainView.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/12.
//  Copyright © 2019 xlkd 24. All rights reserved.
//



#import "HippoMainView.h"
#import "Masonry.h"


@interface HippoMainView ()

@property(nonatomic,strong)UIImageView *hippoBackImageView;
@property (nonatomic,copy) void (^enterActionBlock)(void);
@property (nonatomic,assign)SummerOrderStatus type;
@end
@implementation HippoMainView


- (instancetype)initWithtype:(SummerOrderStatus)type enterAction:(void(^)(void))enterActionBlock {
    self = [super init];
    if (self) {
        [self summer_setupViews];
        [self summer_bindViewModel];
        self.type = type;
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

- (void)summer_bindViewModel {
    
}


- (void)summer_setupViews {
    
    self.backgroundColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.hippoBackImageView];
    self.hippoBackImageView.image = [UIImage imageNamed:@"hippoImageView"];
    
    [self.hippoBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(STSizeWithWidth(240.0));
        make.width.mas_equalTo(STSizeWithWidth(240.0));
    }];
    UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapSingleDid:)];
    tapSingle.numberOfTapsRequired = 1;
    tapSingle.numberOfTouchesRequired = 1;
    
    //双击监听
    UITapGestureRecognizer *tapHoippoDouble = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDoubleDid:)];
    tapHoippoDouble.numberOfTapsRequired = 2;
    tapHoippoDouble.numberOfTouchesRequired = 1;
    //声明点击事件需要双击事件检测失败后才会执行
    [tapSingle requireGestureRecognizerToFail:tapHoippoDouble];
    
    [self.hippoBackImageView addGestureRecognizer:tapSingle];
    [self.hippoBackImageView addGestureRecognizer:tapHoippoDouble];
    
    
    
}

- (void)tapSingleDid:(UITapGestureRecognizer *)tapGesture {
    
    CGPoint ponit = [tapGesture locationInView:self.hippoBackImageView];
    if ([tapGesture.view isEqual:self.hippoBackImageView]) {
        switch (self.type) {
            case ACTIVE:
                //单机  -- 根据坐标点来切换图片
                [self configSingeTapWithPoint:ponit];
                break;
            case GETDOWN:
                // 一分钟不懂 河马会趴下  双击  唤醒河马
                self.type = ACTIVE;
                [self configDataWithUI:self.type];
                break;
            case EGG:
                //变蛋  -- 单机失效
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
                //站起来了  -- 双击出现菜单键
                if (self.enterActionBlock != nil) {
                    self.enterActionBlock();
                }
                break;
            case GETDOWN:
                // 一分钟不懂 河马会趴下  双击  唤醒河马
                self.type = ACTIVE;
                [self configDataWithUI:self.type];
                break;
            case EGG:
                //变蛋  -- 双击出现菜单键
                if (self.enterActionBlock != nil) {
                    self.enterActionBlock();
                }
                break;
                
            default:
                break;
        }
    }
}

- (void)configSingeTapWithPoint:(CGPoint)point {
    
}

- (void)configDataWithUI:(SummerOrderStatus)type {
    self.type = type;
    switch (self.type) {
        case ACTIVE:
            
            break;
        case GETDOWN:
            
            break;
        case EGG:
            
            break;
        default:
            break;
    }
}



- (UIImageView *)hippoBackImageView {
    if (!_hippoBackImageView) {
        _hippoBackImageView = [[UIImageView alloc]init];
        [_hippoBackImageView setUserInteractionEnabled:YES];
    }
    return _hippoBackImageView;
}
@end
