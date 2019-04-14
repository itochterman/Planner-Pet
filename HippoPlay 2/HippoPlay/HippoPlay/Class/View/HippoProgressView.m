//
//  HippoProgressView.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/12.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import "HippoProgressView.h"

@interface HippoProgressView()
@property (nonatomic,copy) NSString *titleName;
@property (nonatomic,assign) CGFloat number;
@property (nonatomic,strong) UIView *progressBackView;
@property (nonatomic,strong) UIView *progressRedBackView;
@property (nonatomic,strong) UIView *progressYellowBackView;
@property (nonatomic,strong) UIView *progressBottomBackView;
@property (nonatomic,strong) UIView *progressTopBackView;
@property (nonatomic,strong) UIButton *enterBtn;
@property (nonatomic,copy) void (^enterActionBlock)(void);

@end

@implementation HippoProgressView

- (instancetype)initWithMood:(CGFloat)number andTitle:(NSString *)titleName enterAction:(void(^)(void))enterActionBlock {
    self = [super init];
    if (self) {
        self.number = number;
        self.titleName = titleName;
        self.enterActionBlock = enterActionBlock;
        [self summer_setupViews];
        [self summer_bindViewModel];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self summer_setupViews];
//        [self summer_bindViewModel];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self summer_setupViews];
//        [self summer_bindViewModel];
    }
    return self;
}

- (void)updateConstraints {
//    __weak typeof(self) weakSelf = self;
//    [self.progressYellowBackView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(weakSelf.progressBackView.mas_height).multipliedBy(self.number);
//    }];
    [super updateConstraints];
}
- (void)summer_bindViewModel {
    
}
- (void)summer_setupViews {
    
    self.backgroundColor = [UIColor redColor];
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(STSizeWithWidth(100.0));
    }];
    [self addSubview:self.progressBackView];
    [self.progressBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(weakSelf.mas_top);
        make.bottom.equalTo(weakSelf.enterBtn.mas_top);
        make.width.mas_equalTo(STSizeWithWidth(28.0));
    }];
    [self.progressBackView addSubview:self.progressRedBackView];
    [self.progressRedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.progressBackView.mas_centerX);
        make.top.equalTo(weakSelf.progressBackView.mas_top);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom);
        make.width.mas_equalTo(STSizeWithWidth(18.0));
    }];
    [self.progressBackView addSubview:self.progressYellowBackView];
    [self.progressYellowBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.progressBackView.mas_centerX);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom);
        make.height.equalTo(weakSelf.progressBackView.mas_height).multipliedBy(weakSelf.number);
        make.width.mas_equalTo(STSizeWithWidth(18.0));
    }];
    [self.progressBackView addSubview:self.progressBottomBackView];
    [self.progressBottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.progressBackView.mas_bottom);
        make.left.equalTo(weakSelf.progressBackView.mas_left);
        make.right.equalTo(weakSelf.progressBackView.mas_right);
        make.height.mas_equalTo(STSizeWithWidth(12.0));
    }];
    [self.progressBackView addSubview:self.progressTopBackView];
    [self.progressTopBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.progressYellowBackView.mas_top);
        make.left.equalTo(weakSelf.progressBackView.mas_left);
        make.right.equalTo(weakSelf.progressBackView.mas_right);
        make.height.mas_equalTo(STSizeWithWidth(12.0));
    }];
    
    [self.enterBtn setTitle:self.titleName forState:UIControlStateNormal];
    self.progressBottomBackView.layer.masksToBounds = YES;
    self.progressBottomBackView.layer.cornerRadius = STSizeWithWidth(6.0);
    self.progressTopBackView.layer.masksToBounds = YES;
    self.progressTopBackView.layer.cornerRadius = STSizeWithWidth(6.0);
}

- (void)configChangeUiWithNumber:(CGFloat)number {
    self.number = number;
    __weak typeof(self) weakSelf = self;
    [self.progressYellowBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.progressBackView.mas_centerX);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom);
        make.height.equalTo(weakSelf.progressBackView.mas_height).multipliedBy(weakSelf.number);
        make.width.mas_equalTo(STSizeWithWidth(18.0));
    }];
    [self.progressBackView layoutIfNeeded];
}

#pragma mark - 点击事件
- (void)clickBtnAction:(UIButton *)sender {
    
    if (self.enterActionBlock != nil) {
        self.enterActionBlock();
    }
}

#pragma mark - get
- (UIView *)progressBackView {
    if (!_progressBackView) {
        _progressBackView = [[UIView alloc]init];
        _progressBackView.backgroundColor = [UIColor blueColor];
    }
    return _progressBackView;
}
- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc]init];
        [_enterBtn setBackgroundColor:[UIColor orangeColor]];
        [_enterBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}
- (UIView *)progressRedBackView {
    if (!_progressRedBackView) {
        _progressRedBackView = [[UIView alloc]init];
        _progressRedBackView.backgroundColor = [UIColor redColor];
    }
    return _progressRedBackView;
}
- (UIView *)progressYellowBackView {
    if (!_progressYellowBackView) {
        _progressYellowBackView = [[UIView alloc]init];
        _progressYellowBackView.backgroundColor = [UIColor yellowColor];
    }
    return _progressYellowBackView;
}
- (UIView *)progressBottomBackView {
    if (!_progressBottomBackView) {
        _progressBottomBackView = [[UIView alloc]init];
        _progressBottomBackView.backgroundColor = [UIColor yellowColor];
    }
    return _progressBottomBackView;
}
- (UIView *)progressTopBackView {
    if (!_progressTopBackView) {
        _progressTopBackView = [[UIView alloc]init];
        _progressTopBackView.backgroundColor = [UIColor yellowColor];
    }
    return _progressTopBackView;
}
@end
