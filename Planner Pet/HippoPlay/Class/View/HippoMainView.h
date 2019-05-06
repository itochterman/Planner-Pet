//
//  HippoMainView.h
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/12.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBPopupMenu.h"



NS_ASSUME_NONNULL_BEGIN

@interface HippoMainView : UIView


- (instancetype)initWithEnterAction:(void(^)(void))enterActionBlock;

- (void)configWithChangeFood:(float)food;


- (void)configWithChangeMood:(float)mood;
- (void)configWithChangeFood:(float)mood andClean:(float)clean;
- (void)configWithChangeExp:(float)exp;
@property (nonatomic, strong) YBPopupMenu *popupMenu;

@property (nonatomic,assign) BOOL isCanShow;

@end

NS_ASSUME_NONNULL_END
