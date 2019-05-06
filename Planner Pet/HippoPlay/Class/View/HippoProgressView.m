//
//  HippoProgressView.m
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
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
@property (nonatomic,strong) UIImageView *enterImageView;
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
        if (titleName==@"food"){
            _enterImageView.backgroundColor = [UIColor clearColor];
//            _enterImageView.layer.cornerRadius = 10;
//            _enterImageView.clipsToBounds = YES;
//            _enterImageView.layer.borderColor = [UIColor blueColor].CGColor;
//            _enterImageView.layer.borderWidth = 3.0f;
            
        }
        
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
    [super updateConstraints];
}
- (void)summer_bindViewModel {
    
}
- (void)summer_setupViews {
    
    self.backgroundColor = [UIColor clearColor];
    __weak typeof(self) weakSelf = self;
    [self addSubview:self.enterImageView];
    [self.enterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-STSizeWithWidth(10.0));
        make.height.width.mas_equalTo(STSizeWithWidth(60.0));
    }];

    [self addSubview:self.enterBtn];
    [self.enterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(STSizeWithWidth(80.0));
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
        make.top.equalTo(weakSelf.progressBackView.mas_top).offset(STSizeWithWidth(5.0));
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom).offset(-STSizeWithWidth(5.0));
        make.width.mas_equalTo(STSizeWithWidth(18.0));
    }];
    [self.progressBackView addSubview:self.progressYellowBackView];
    [self.progressYellowBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.progressBackView.mas_centerX);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom).offset(-STSizeWithWidth(5.0));
        make.width.mas_equalTo(STSizeWithWidth(18.0));
        make.height.equalTo(weakSelf.progressRedBackView.mas_height).multipliedBy(weakSelf.number);
    }];
//    [self.progressBackView addSubview:self.progressBottomBackView];
//    [self.progressBottomBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.progressBackView.mas_bottom);
//        make.left.equalTo(weakSelf.progressBackView.mas_left);
//        make.right.equalTo(weakSelf.progressBackView.mas_right);
//        make.height.mas_equalTo(STSizeWithWidth(12.0));
//    }];
//    [self.progressBackView addSubview:self.progressTopBackView];
//    [self.progressTopBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.progressYellowBackView.mas_top);
//        make.left.equalTo(weakSelf.progressBackView.mas_left);
//        make.right.equalTo(weakSelf.progressBackView.mas_right);
//        make.height.mas_equalTo(STSizeWithWidth(12.0));
//    }];
    
//    [self.enterBtn setTitle:self.titleName forState:UIControlStateNormal];
//    [self.enterBtn setImage:[UIImage imageNamed:self.titleName] forState:UIControlStateNormal];
    self.enterImageView.image = [UIImage imageNamed:self.titleName];
//    self.progressBottomBackView.layer.masksToBounds = YES;
//    self.progressBottomBackView.layer.cornerRadius = STSizeWithWidth(6.0);
//    self.progressTopBackView.layer.masksToBounds = YES;
//    self.progressTopBackView.layer.cornerRadius = STSizeWithWidth(6.0);
    
    
    
    self.progressRedBackView.layer.masksToBounds = YES;
    self.progressRedBackView.layer.cornerRadius = STSizeWithWidth(9.0);
    self.progressYellowBackView.layer.masksToBounds = YES;
    self.progressYellowBackView.layer.cornerRadius = STSizeWithWidth(9.0);
    self.progressBackView.layer.masksToBounds = YES;
    self.progressBackView.layer.cornerRadius = STSizeWithWidth(14.0);
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = [UIColor redColor];
    [self.progressBackView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width);
        make.height.mas_equalTo(2);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom).multipliedBy(0.8);
        
    }];
    
}

- (void)configChangeUiWithNumber:(CGFloat)number {
    self.number = number;
    __weak typeof(self) weakSelf = self;
    [self.progressYellowBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(weakSelf.progressBackView.mas_centerX);
        make.bottom.equalTo(weakSelf.progressBackView.mas_bottom).offset(-STSizeWithWidth(5.0));
        make.width.mas_equalTo(STSizeWithWidth(18.0));
        make.height.equalTo(weakSelf.progressRedBackView.mas_height).multipliedBy(weakSelf.number);
    }];
    [self.progressBackView layoutIfNeeded];
}


- (void)clickBtnAction:(UIButton *)sender {
    
    if (self.enterActionBlock != nil) {
        self.enterActionBlock();
    }
}

#pragma mark - get
- (UIView *)progressBackView {
    if (!_progressBackView) {
        _progressBackView = [[UIView alloc]init];
        _progressBackView.backgroundColor = STColorWithHex(0x6a44be);
    }
    return _progressBackView;
}
- (UIButton *)enterBtn {
    if (!_enterBtn) {
        _enterBtn = [[UIButton alloc]init];
        [_enterBtn setBackgroundColor:[UIColor clearColor]];
        [_enterBtn addTarget:self action:@selector(clickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterBtn;
}
- (UIView *)progressRedBackView {
    if (!_progressRedBackView) {
        _progressRedBackView = [[UIView alloc]init];
        _progressRedBackView.backgroundColor = STColorWithHex(0x382193);
    }
    return _progressRedBackView;
}
- (UIView *)progressYellowBackView {
    if (!_progressYellowBackView) {
        _progressYellowBackView = [[UIView alloc]init];
        _progressYellowBackView.backgroundColor = STColorWithHex(0x6ce5f8);
    }
    return _progressYellowBackView;
}
//- (UIView *)progressBottomBackView {
//    if (!_progressBottomBackView) {
//        _progressBottomBackView = [[UIView alloc]init];
//        _progressBottomBackView.backgroundColor = [UIColor yellowColor];
//    }
//    return _progressBottomBackView;
//}
//- (UIView *)progressTopBackView {
//    if (!_progressTopBackView) {
//        _progressTopBackView = [[UIView alloc]init];
//        _progressTopBackView.backgroundColor = [UIColor yellowColor];
//    }
//    return _progressTopBackView;
//}
- (UIImageView *)enterImageView {
    if (!_enterImageView) {
        _enterImageView = [[UIImageView alloc]init];
        _enterImageView.backgroundColor = [UIColor clearColor];
    }
    return _enterImageView;
}
@end
