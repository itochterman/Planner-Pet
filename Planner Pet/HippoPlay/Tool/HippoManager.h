//
//  HippoManager.h
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/16.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HippoModel+CoreDataProperties.h"

typedef enum : NSUInteger {
    GETDOWN = 1,
    ACTIVE,
    GETDOWNSHIT,
    ACTIVESHIT,
} SummerOrderStatus;

NS_ASSUME_NONNULL_BEGIN

@interface HippoManager : NSObject
+ (instancetype)shareInstance;


- (void)createSqlite;


/**
 每天重置
 */
- (void)resetData;

- (SummerOrderStatus)configDataNormalWithUI;

- (void)configDataWithGcdTimerSuccess:(void (^)(float mood,float food,float exp,float clean,NSInteger shitNumber))success;

- (void)configDataWithClearShitSuccess:(void (^)(float mood,float food,float exp,float clean))clearShitSuccess;

- (void)configDataWithEatSuccess:(void (^)(float mood,float food,float exp,float clean))eatSuccess eatFailure: (void (^)(void))eatFailure;


- (void)configDataWithAddFood:(CGFloat)food foodSuccess:(void (^)(float mood,float food,float exp,float clean))foodSuccess;


- (void)configDataWithAddMood:(CGFloat)mood moodSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess;

- (void)configDataWithCleanSuccess:(void (^)(float mood,float food,float exp,float clean))eatSuccess eatFailure: (void (^)(void))eatFailure;


- (void)configDataWithGifWoth:(NSInteger)time timerSuccess:(void (^)(void))gifSuccess;


- (void)configStandUpChangeTime;


- (HippoModel *)configDataWithModel;
@end

NS_ASSUME_NONNULL_END
