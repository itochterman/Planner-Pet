//
//  HippoMainView.h
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface HippoMainView : UIView


- (instancetype)initWithEnterAction:(void(^)(void))enterActionBlock;

- (void)configWithChangeFood:(float)food;


- (void)configWithChangeMood:(float)mood;

@end

NS_ASSUME_NONNULL_END
