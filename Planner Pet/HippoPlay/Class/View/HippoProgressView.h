//
//  HippoProgressView.h
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/12.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HippoProgressView : UIView
- (instancetype)initWithMood:(CGFloat)number andTitle:(NSString *)titleName enterAction:(void(^)(void))enterActionBlock;
- (void)configChangeUiWithNumber:(CGFloat)number;
@end

NS_ASSUME_NONNULL_END
