//
//  HippoBodyStatusView.h
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HippoBodyStatusView : UIView
- (instancetype)initWithMood:(CGFloat)mood andExp:(CGFloat)exp andFood:(CGFloat)food andClean:(CGFloat)clean enterAction:(void(^)(NSInteger))enterActionBlock;
- (void)configChangeUIWithData:(CGFloat)moodNumber andExpNumber:(CGFloat)expNumber andFoodNumber:(CGFloat)foodNumber andCleanNumber:(CGFloat)cleanNumber;
@end

NS_ASSUME_NONNULL_END
