//
//  HippoMainView.h
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/12.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GETDOWN = 1,//趴下
    ACTIVE,//活跃
    EGG,//蛋
} SummerOrderStatus;

NS_ASSUME_NONNULL_BEGIN

@interface HippoMainView : UIView
-(instancetype)initWithtype:(SummerOrderStatus)type enterAction:(void(^)(void))enterActionBlock;
@end

NS_ASSUME_NONNULL_END
